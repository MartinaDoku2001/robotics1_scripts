function [solutions] = find_singularity(J, variables)
    %Function that computes the singularity of ajacobian matrix square or
    %not
    %
    %parameters:
    %J= jacobian
    %variables= vector of variables of the jacobians
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
            
        end
end