function [x, iter] = sor(A,b,e,n,omega,max_iter)

    iter = 0;
    x=zeros(n,1);
    D = diag(diag(A));          % 对角部分
    L = -tril(A, -1);           % 严格下三角部分（取负）
    U = -triu(A, 1);            % 严格上三角部分（取负）

    M = (D - omega * L);        % (D - ωL)
    N = ((1 - omega) * D + omega * U); % ((1-ω)D + ωU)

    while iter < max_iter
        x_old = x;
        x = M \ (omega * b + N * x_old); % x = inv(M) * (ωb + N * x_old)

        if norm(x - x_old) < e
            break;
        end

        iter = iter + 1;
    end

    if iter == max_iter
        warning('达到最大迭代次数，未收敛到指定容差。');
    end
end