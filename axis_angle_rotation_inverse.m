function [axis, angle] = axis_angle_rotation_inverse(R, pos_or_neg)
    %Function that generates an angle and an axis given a rotation matrix
    %
    %parameters:
    %-R= rotation matrix
    %-pos_or_neg= string "pos"/"neg" that specifies whichsolution to return
    % Check if the input matrix is a valid rotation matrix
    if ~isequal(size(R), [3, 3]) && isreal(R) && det(R) > 0 && isequal(R * R', eye(3))
        error('Input is not a valid rotation matrix.');
    end
    
    % Extract axis and angle from the rotation matrix
    angle = acos((trace(R) - 1) / 2);
    axisSkewSymmetric = (R - R') / (2 * sin(angle));

    % Extract the components of the axis from the skew-symmetric matrix
    axis = [axisSkewSymmetric(3, 2); axisSkewSymmetric(1, 3); axisSkewSymmetric(2, 1)];

    % Ensure positive or negative solution based on the input variable
    if pos_or_neg=="pos"
        angle = abs(angle);
    else
        angle = -abs(angle);
    end
end


