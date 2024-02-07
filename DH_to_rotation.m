function [R]= DH_to_rotation(DHTABLE,rot_to_idx)
    %function to obtain the rotation matrix from the base up to i'th frame
    %
    %parameters:
    %- DHTABLE= dhtable in the order alpha a d theta
    %- rot_to_idx= index of the frame to which we want tp rotate
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
    rotation_0_to_i = cell(1, N);

    for i = 1:N
        T = T * A{i};
        rotation_0_to_i{i} = simplify(T);
    end

    % Compute the desired rotation
    fprintf("rotation from 0 to %d \n",rot_to_idx)
    R=rotation_0_to_i{rot_to_idx}(1:3, 1:3)