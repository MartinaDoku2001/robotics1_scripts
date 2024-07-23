function [solutions] = inverse_kinematics_3R_planar(l1, l2, l3, px, py, phi)
  %% Inverse Kinematics of a 3R Planar Robot
  % Parameters:
  % - l1: Length of link 1
  % - l2: Length of link 2
  % - l3: Length of link 3
  % - px: Final position on x-axis
  % - py: Final position on y-axis
  % - phi: Orientation of end effector (angle)
  
  % Calculate the position of the second joint (p2)
  p2 = [px; py] - [l3 * cos(phi); l3 * sin(phi)];
  p2x = p2(1);
  p2y = p2(2);
  
  % Calculate the angle for the second joint (theta2)
  cosTheta2 = (p2x^2 + p2y^2 - l1^2 - l2^2) / (2 * l1 * l2);
  sinTheta2Pos = sqrt(1 - cosTheta2^2);
  sinTheta2Neg = -sqrt(1 - cosTheta2^2);
  
  theta2Pos = atan2(sinTheta2Pos, cosTheta2);
  theta2Neg = atan2(sinTheta2Neg, cosTheta2);
  
  % Calculate the angle for the first joint (theta1)
  detM = l1^2 + l2^2 + 2 * l1 * l2 * cosTheta2;
  
  sinTheta1Pos = (p2y * (l1 + l2 * cosTheta2) - p2x * l2 * sinTheta2Pos) / detM;
  cosTheta1Pos = (p2x * (l1 + l2 * cosTheta2) + p2y * l2 * sinTheta2Pos) / detM;
  
  sinTheta1Neg = (p2y * (l1 + l2 * cosTheta2) - p2x * l2 * sinTheta2Neg) / detM;
  cosTheta1Neg = (p2x * (l1 + l2 * cosTheta2) + p2y * l2 * sinTheta2Neg) / detM;
  
  theta1Pos = atan2(sinTheta1Pos, cosTheta1Pos);
  theta1Neg = atan2(sinTheta1Neg, cosTheta1Neg);
  
  % Calculate the angle for the third joint (theta3)
  theta3Pos = phi - (theta1Pos + theta2Pos);
  theta3Neg = phi - (theta1Neg + theta2Neg);
  
  % Display the solutions
  disp('Positive solution:');
  thetaPos = [theta1Pos; theta2Pos; theta3Pos]
  
  disp('Negative solution:');
  thetaNeg = [theta1Neg; theta2Neg; theta3Neg]
  
  % Return the solutions
  solutions = [thetaPos, thetaNeg];
end