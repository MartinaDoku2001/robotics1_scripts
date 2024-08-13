function [J] = find_range(J)
        % Compute the range of the jacobian
        range = simplify(orth(sym(J)));

        % Display the range
        disp('Range of the jacobian:');
        disp(range);

        disp('I will display the basis of the range now. -- Warning! this result might be wrong, please check by hand if possible')
        % Display the basis of the range
        [~,m]=size(range);
        for i=1:m
            [numerator, ~] = numden(range(:,i));
            fprintf('%d basis',i)
            display(simplify(numerator,'Steps',50));
        end
end