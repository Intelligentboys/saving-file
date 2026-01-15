function main()
    clear,clc;
    num = [4, 8, 16, 32];
    K = cell(1,4);
    y = cell(1,4);
    h_t = cell(1,4);
    
    % 构造矩阵
    for i = 1:4
        K{i} = Creat_Matrix(num(i));
        h_t{i} = (1/num(i)) * (0:num(i));
        y{i} = (exp(h_t{i}+1) - 1) ./ (h_t{i}+1);
    end
    
    k = [3, 5, 7, 9];
    x = cell(1,4);
    
    % 奇异值截断
    for i = 1:4
        [U, S, V] = svd(K{i});
        S = diag(S);
        [U_trunc, S_trunc, V_trunc] = svd_truncation(U, S, V', k(i));
        x{i} = V_trunc' * diag(1./S_trunc) * U_trunc' * y{i}';
        
        fprintf('%d等分的情况下，选取主成分数量为%d，得到的平均误差为:', num(i), k(i));
        disp(norm(x{i} - exp(h_t{i})')/num(i));
        fprintf('\n\n');
    end
    subplot(2,2,1);
    plot(h_t{1},x{1},'r-');
    hold on;
    plot(h_t{1},exp(h_t{1}),'b-');
    legend('数值解','解析解','Location','northwest');
    title('区间4等分，选取主成分数量为3')
    subplot(2,2,2);
    plot(h_t{2},x{2},'r-');
    hold on;
    plot(h_t{2},exp(h_t{2}),'b-');
    legend('数值解','解析解','Location','northwest');
    title('区间8等分，选取主成分数量为5')
    subplot(2,2,3);
    plot(h_t{3},x{3},'r-');
    hold on;
    plot(h_t{3},exp(h_t{3}),'b-');
    legend('数值解','解析解','Location','northwest');
    title('区间16等分，选取主成分数量为7')
    subplot(2,2,4);
    plot(h_t{4},x{4},'r-');
    hold on;
    plot(h_t{4},exp(h_t{4}),'b-');
    legend('数值解','解析解','Location','northwest');
    title('区间32等分，选取主成分数量为9')
end

function K = Creat_Matrix(num)    %构造矩阵
    h_st = (1/num) * (0:num);
    h = 1/num;
    K = zeros(num+1, num+1);
    
    for t = 1:num+1
        for s = 1:num+1
            K(t,s) = h * exp(h_st(t) * h_st(s));
        end
    end
    
    K(:,1) = 0.5 * K(:,1);
    K(:,end) = 0.5 * K(:,end);
end

function [U_trunc, S_trunc, Vh_trunc] = svd_truncation(U, S, Vh, k)   %截断奇异值
    U_trunc = U(:, 1:k);
    S_trunc = S(1:k);
    Vh_trunc = Vh(1:k, :);
end