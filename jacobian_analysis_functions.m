%JACOBIAN ANALYSIS
clear all
clc

syms q1 q2 q3 q4 real
r=[q2*cos(q1)+q4*cos(q1+q3);
q2*sin(q1)+q4*sin(q1+q3);
q1+q3]
variables=[q1, q2, q3, q4]
J=jacobian(r)
%jacobianAnalysis(J,variables)
q2=0
q3=0
display(J')
findNullspace(J')
findRange(J')

function [J, variables] = jacobianAnalysis(J, variables)
    %performs the full analysis of a Jacobian, square or not,
    %displaying: 
    %-determinant
    %-singularity
    %-singular Jacobian--x
    %-rank
    %-nullspace
    %-nullspace in the singular jacobian --x
    %-range
    %
    %parameters:
    % J = jacobian matrix
    % v = list of symbolic variables (only the one used to differentiate
    % the Jacobian, don't put constants in there)

    % Check if the jacobian is squared
    [m, n] = size(J);
    if m ~= n
        for i = 1:n
            % Create a submatrix of the original non-square matrix by
            % Removing one column at a time
            Jcopy=J;
            Jcopy(:,i)=[];

            % Determinant of the i-th submatrix
            fprintf('Determinant of the %s -th submatrix: \n', mat2str(i));
            disp(simplify(det(Jcopy)));

            % Compute the singularity (equal the determinant to zero)
            fprintf('singularity condition of the %s -th submatrix: \n', mat2str(i));
            disp(simplify(det(Jcopy)==0));
        end
    else
        % Compute the determinant
        determinant_Jacobian = simplify(det(J));

        disp('Determinant of the Jacobian:');
        disp(simplify(determinant_Jacobian));
    
        % Compute the singularity (equal the determinant to zero)
        fprintf('singularity condition: \n');
        disp(determinant_Jacobian==0);


        n_var=length(variables)
        % Solve for all possible values of the symbols that make the determinant zero
        if n_var==2
            [q1_sol,q2_sol,params, cond] = solve(determinant_Jacobian == 0, variables, 'ReturnConditions', true);
            solutions=[q1_sol,q2_sol];
        elseif  n_var==3
            [q1_sol,q2_sol,q3_sol,params, cond] = solve(determinant_Jacobian == 0, variables, 'ReturnConditions', true);
            solutions=[q1_sol,q2_sol,q3_sol];
        elseif  n_var==4
            [q1_sol,q2_sol,q3_sol,q4_sol,params, cond] = solve(determinant_Jacobian == 0, variables, 'ReturnConditions', true);
            solutions=[q1_sol,q2_sol,q3_sol,q4_sol];
        end
        disp('All possible solutions for the symbols that make the determinant zero:');
        display(solutions);
        display(cond);
        
    end
        % Compute the rank of the Jacobian
        rank_J = rank(J);
        
        % Display the rank of the Jacobian
        disp('Rank of the Jacobian:');
        disp(rank_J);
        
        % Compute the nullspace of the Jacobian
        nullspace_J = null(J);
        
        % Display the nullspace of the Jacobian
        disp('Nullspace of the Jacobian:');
        disp(simplify(nullspace_J));

        % Compute the range of the jacobian
        Range = simplify(orth(sym(J)));

        % Display the range
        disp('range of the jacobian');
        disp('warning! this result might be wrong, please check by hand if possible')
        R=simplify(orth(sym(J)));
        [n,m]=size(R);
        for i=1:m
            [numerator, denominator] = numden(R(:,i));
            fprintf('%d basis',i)
            display(simplify(numerator,'Steps',50));
        end

end

function [J, variables] = findSingularity(J, variables)
    [m, n] = size(J);
        if m ~= n
            for i = 1:n
                % Create a submatrix of the original non-square matrix by
                % removing one column at a time
                Jcopy=J;
                Jcopy(:,i)=[];
    
                % Determinant of the i-th submatrix
                fprintf('Determinant of the %s -th submatrix: \n', mat2str(i));
                disp(simplify(det(Jcopy)));
    
                % Compute the singularity (equal the determinant to zero)
                fprintf('singularity condition of the %s -th submatrix: \n', mat2str(i));
                disp(simplify(det(Jcopy)==0));
            end
        else
            % Compute the determinant
            determinant_Jacobian = simplify(det(J));
    
            disp('Determinant of the Jacobian:');
            disp(simplify(determinant_Jacobian));
        
            % Compute the singularity (equal the determinant to zero)
            fprintf('singularity condition: \n');
            disp(determinant_Jacobian==0);
    
    
            
            n_var=length(variables)
            % Solve for all possible values of the symbols that make the determinant zero
            if n_var==2
                [q1_sol,q2_sol,params, cond] = solve(determinant_Jacobian == 0, variables, 'ReturnConditions', true);
                solutions=[q1_sol,q2_sol];
            elseif  n_var==3
                [q1_sol,q2_sol,q3_sol,params, cond] = solve(determinant_Jacobian == 0, variables, 'ReturnConditions', true);
                solutions=[q1_sol,q2_sol,q3_sol];
            elseif  n_var==4
                [q1_sol,q2_sol,q3_sol,q4_sol,params, cond] = solve(determinant_Jacobian == 0, variables, 'ReturnConditions', true);
                solutions=[q1_sol,q2_sol,q3_sol,q4_sol];
            end
            disp('All possible solutions for the symbols that make the determinant zero:');
            display(solutions);
            display(cond);
            
        end
end

function [J] = findRank(J)
        % Compute the rank of the Jacobian
        rank_J = rank(J);

        % Display the rank of the Jacobian
        disp('Rank of the Jacobian:');
        disp(rank_J);
end

function [J] = findNullspace(J)
        % Compute the nullspace of the Jacobian
        nullspace_J = null(J);

        % Display the nullspace of the Jacobian
        disp('Nullspace of the Jacobian:');
        disp(nullspace_J);
end

function [J] = findRange(J)
        % Compute the range of the jacobian
        Range = orth(sym(J));

        % Display the range
        disp('range of the jacobian');
        disp('warning! this result might be wrong, please check by hand if possible')
        R=simplify(Range);
        [n,m]=size(R);
        for i=1:m
            [numerator, denominator] = numden(R(:,i));
            fprintf('%d basis',i)
            display(simplify(numerator,'Steps',50));
        end
end
       




