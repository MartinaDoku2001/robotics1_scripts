function [JL] = DH_to_JL(DHTABLE,variables)
    %Function that find the linear jacobian for a robot 
    %
    %parameters:
    %-DH in the order alpha a d theta, ex:
    %   DHTABLE = [ pi/2    0       sym('d1')   q1;
    %               pi/2    0           0       q2;
    %               pi/2    0          q3       0;
    %               0      sym('a4')    0       q4];
    %
    syms alpha_ d a theta_

    N = size(DHTABLE, 1);

    TDH = [cos(theta_) -sin(theta_)*cos(alpha_) sin(theta_)*sin(alpha_) a*cos(theta_);
           sin(theta_) cos(theta_)*cos(alpha_) -cos(theta_)*sin(alpha_) a*sin(theta_);
           0 sin(alpha_) cos(alpha_) d;
           0 0 0 1];

    A = cell(1, N);

    for i = 1:N
        A{i} = subs(TDH, [alpha_, a, d, theta_], DHTABLE(i, :));
    end

    T = eye(4);
    position_0_to_i = cell(1, N);

    for i = 1:N
        T = T * A{i};
        position_0_to_i{i} = T(1:3,4);
    end

    p_0_e=position_0_to_i{N};
    % Compute the column vectors for the Jacobian matrix
    
    JL = simplify(jacobian(p_0_e, variables));

    % Display or return the Jacobian matrix as needed
    disp('Linear Jacobian Matrix: ');
    disp(JL);
end

