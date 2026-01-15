function AD = drazin_inverse(A)
    [U, S, V] = svd(A);
    tol = max(size(A)) * eps(norm(S, 'fro'));
    S_inv = S;
    S_inv(S > tol) = 1 ./ S(S > tol);
    AD = V * S_inv' * U';
end