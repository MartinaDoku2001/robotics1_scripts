function Rmatrix = ElementaryRotations(axis, angle)
    % Function that returns the elementary rotation matrix for a given axis and angle
    %
    % Parameters:
    % - axis: the axis of rotation ('X', 'Y', or 'Z')
    % - angle: the angle of rotation in radians
    %
    % Returns:
    % - Rmatrix: the elementary rotation matrix for the given axis and angle
    %
    % Example:
    % >> ElementaryRotationM('X', pi/2)
    %
    
    % Check if the axis is valid
    if ~(axis == 'X' || axis == 'Y' || axis == 'Z')
        error('Invalid axis. Use ''X'', ''Y'', or ''Z''.');
    end

    % Initialize symbolic variables
    syms theta

    % Calculate the rotation matrix based on the chosen axis
    if axis == 'X'
        Rmatrix = [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];
    elseif axis == 'Y'
        Rmatrix = [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];
    elseif axis == 'Z'
        Rmatrix = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
    else
        error('Invalid axis. Use ''X'', ''Y'', or ''Z''.');
    end

    % Substitute the symbolic angle 'angle' for 'theta'
    Rmatrix = subs(Rmatrix, theta, angle);
end
