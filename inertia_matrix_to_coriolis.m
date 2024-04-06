function[c, C] = inertia_matrix_to_coriolis(M)
    % takes as inputs:
    %   - M = the inertia matrix
    %   
    % output:
    %   - c = robot centrifugal and Coriolis term
    %   - C = Christoffel matrices

    syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 a1 a2 a3 a4 a5 a6 real
  
    disp("Christoffel matrices")
    q=[q1;q2;q3];
    M1=M(:,1);
    C1=(1/2)*(jacobian(M1,q)+jacobian(M1,q)'-diff(M,q1))
    M2=M(:,2);
    C2=(1/2)*(jacobian(M2,q)+jacobian(M2,q)'-diff(M,q2))
    M3=M(:,3);
    C3=(1/2)*(jacobian(M3,q)+jacobian(M3,q)'-diff(M,q3))
    disp("robot centrifugal and Coriolis terms")
    dq=[dq1;dq2;dq3];
    c1=dq'*C1*dq;
    c2=dq'*C2*dq;
    c3=dq'*C3*dq;
    c=[c1;c2;c3]
    C=[C1;C2;C3]