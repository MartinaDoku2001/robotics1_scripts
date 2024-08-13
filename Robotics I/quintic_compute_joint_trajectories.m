function [q_tau, coefficients] = quintic_compute_joint_trajectories(q_in, q_fin, T, p_dot_0, p_dot_1, a_in, a_f, link_len, direct_kinematics, print_info)
        % Compute joint trajectories for a multi-joint robot
        %
        % Inputs:
        %   q_in: Initial joint angles (vector)
        %   q_fin: Final joint angles (vector)
        %   T: Total time
        %   p_dot_0: Initial end effector velocity
        %   p_dot_1: Final end effector velocity
        %   a_in: Initial acceleration
        %   a_f: Final acceleration
        %   link_len: Link lengths (vector)
        %   direct_kinematics: Symbolic expression of direct kinematics
        %   print_info : Boolean to print detailed information
        %
        % Outputs:
        %   q_tau: Cell array of symbolic expressions for joint trajectories
        %   coefficients: Matrix of trajectory coefficients (one row per joint)
    
        num_joints = length(q_in);
        link_lengths = link_len;
        
        % Jacobian
        joint_vars = sym('q', [1 num_joints]);
        all_vars = symvar(direct_kinematics);
        non_joint_vars = setdiff(all_vars, joint_vars);

        J = simplify(jacobian(direct_kinematics, joint_vars));

        % Substitute initial values for joints and keep other variables symbolic
        J_initial = subs(J, [joint_vars, non_joint_vars], [q_in, link_lengths]);
        
        % Check if J_initial is square. If yes, inverse, otherwise we must compute the pseudo-inverse
        if size(J_initial, 1) == size(J_initial, 2)
            J_initial_inv = simplify(inv(J_initial));
        else
            J_initial_inv = simplify(pinv(J_initial));
        end
        disp(J_initial_inv)

        % Velocity of configurations
        q_dot_0 = J_initial_inv * p_dot_0;
        q_dot_T = J_initial_inv * p_dot_1;
    
        % Initialize outputs
        q_tau = cell(1, num_joints);
        q_tau_dot = cell(1, num_joints);
        q_tau_dot_dot = cell(1, num_joints);
        coefficients = zeros(num_joints, 6);
    
        % Compute trajectories for each joint
        for i = 1:num_joints
            fprintf('-- Computations for Joint %d:\n', i);
            [q, c] = quintic_poly_double_norm_compute_coeff(q_in(i), q_fin(i), q_dot_0(i), q_dot_T(i), a_in, a_f, T, print_info);
            coefficients(i, :) = [c(6), c(5), c(4), c(3), c(2), c(1)];
            q_tau{i} = q;
            q_tau_dot{i} = diff(q, 'tau') / T;
            q_tau_dot_dot{i} = diff(q_tau_dot{i}, 'tau') / T;
            
            % Display results
            if(print_info == false)
                disp(q_tau{i});
                fprintf('\n');
            end
        end
    
        % Plot trajectories
        plot_trajectories(q_tau, q_tau_dot, q_tau_dot_dot, T);
    end
        
    function plot_trajectories(q_tau, q_tau_dot, q_tau_dot_dot, T)
        num_joints = length(q_tau);
        syms t real
        tau = t/T;
        
        % Position
        figure;
        hold on;
        for i = 1:num_joints
            fplot(subs(q_tau{i}, 'tau', tau), [0, T]);
        end
        title('Joint Positions');
        xlabel('Time (s)');
        ylabel('Position (rad)');
        legend(arrayfun(@(x) sprintf('q%d', x), 1:num_joints, 'UniformOutput', false));
        hold off;
    
        % Velocity
        figure;
        hold on;
        for i = 1:num_joints
            fplot(subs(q_tau_dot{i}, 'tau', tau), [0, T]);
        end
        title('Joint Velocities');
        xlabel('Time (s)');
        ylabel('Velocity (rad/s)');
        h = legend(arrayfun(@(x) sprintf('q%d_dot', x), 1:num_joints, 'UniformOutput', false));
        set(h, 'Interpreter', 'none');
        hold off;
    
        % Acceleration
        figure;
        hold on;
        for i = 1:num_joints
            fplot(subs(q_tau_dot_dot{i}, 'tau', tau), [0, T]);
        end
        title('Joint Accelerations');
        xlabel('Time (s)');
        ylabel('Acceleration (rad/s^2)');
        h = legend(arrayfun(@(x) sprintf('q%d_dot_dot', x), 1:num_joints, 'UniformOutput', false));
        set(h, 'Interpreter', 'none');
        hold off;
    end