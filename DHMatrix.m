function matrix = DHMatrix()
    % Function that returns the DH matrix for a robot
    % For usage, simply define the DH Matrix as:
    % DH = DHmatrix();
    %
    % Then, after defining your "DH_table", you can substitute the values
    % using the following command:
    % for i = 1 : n_joints
    %     A{i} = subs(DH, {alpha, a, d, theta}, DH_table(i, :));
    % end

    syms alpha a d theta;

    matrix = [cos(theta) -cos(alpha)*sin(theta) sin(alpha)*sin(theta) a*cos(theta);
            sin(theta) cos(alpha)*cos(theta) -sin(alpha)*cos(theta) a*sin(theta);
            0 sin(alpha) cos(alpha) d;
            0 0 0 1];
end