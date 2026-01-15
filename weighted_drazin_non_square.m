function AWD = weighted_drazin_non_square(A, W1, W2)
    % 输入: A (m×n), W1 (n×n), W2 (m×m) 为正定矩阵
    % 输出: 带权 Drazin 逆 A_{W1,W2}^D (n×m)
    
    % 步骤1: 计算权重矩阵的平方根
    W1_sqrt = sqrtm(W1);
    W2_sqrt = sqrtm(W2);
    
    % 构造加权方阵 ~A = W2^(1/2) * A * W1^(1/2)
    A_tilde = W2_sqrt * A * W1_sqrt;
    
    % 步骤2: 计算 ~A 的广义 Drazin 逆（基于 SVD）
    [U, S, V] = svd(A_tilde, 'econ');
    tol = max(size(A_tilde)) * eps(norm(S, 'fro'));
    S_inv = S';
    S_inv(S > tol) = 1 ./ S(S > tol);
    AD_tilde = V * S_inv * U';
    
    % 步骤3: 还原带权 Drazin 逆
    AWD = inv(W1_sqrt) * AD_tilde * inv(W2_sqrt);
end