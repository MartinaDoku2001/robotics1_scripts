function joint_values = inverse_kinematics_RPR(l2, x, y, alpha, pos_neg)
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
        q2=sqrt((x-l2*cos(alpha))^2+(y-l2*sin(alpha))^2);
    else
        q2=-sqrt((x-l2*cos(alpha))^2+(y-l2*sin(alpha))^2);
    end

    q1=atan2(y-l2*sin(alpha),x-l2*cos(alpha));
    
    q3= alpha - q1
    % Output joint values
    joint_values = [q1;q2;q3];
end