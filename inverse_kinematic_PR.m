function joint_values = inverse_kinematics_PR(l2, x, y,pos_neg)
    %function that performs the inverse kinematic of a PR robot
    %
    %parameters:
    %-l2= length of second link
    %-x= x coodinates of end effector position
    %-y= y coordinate of end effector position
    %-pos_neg= a string that indicates what solution you want "pos" or
    %"neg"

   
    % Calculate the joint values
    if pos_neg=="pos"
        q1=px+sqrt(l2^2-y^2)
    else
        q1=px-sqrt(l2^2-y^2)
    end

    q2=atan2(y,x-q1)

    % Output joint values
    joint_values = [q1;q2];
end