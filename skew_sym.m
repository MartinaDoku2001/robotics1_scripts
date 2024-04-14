function S = skew_sym(v)
    % Check that the input vector is a column vector
    v = v(:);
    % Create skew_symmetric matrix 3x3
    S = [ 0,    -v(3),  v(2);
          v(3),  0,    -v(1);
         -v(2),  v(1),  0 ];
end