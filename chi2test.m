function [h, p, chi2stat, df] = chi2test(observed)
    % 计算行和列的总和
    rowSums = sum(observed, 2);
    colSums = sum(observed, 1);
    
    % 计算总样本量
    total = sum(observed(:));
    
    % 计算期望频数表
    expected = rowSums * colSums / total;
    
    % 计算卡方统计量
    chi2stat = sum((observed - expected).^2 ./ expected);
    
    % 计算自由度
    df = (size(observed, 1) - 1) * (size(observed, 2) - 1);
    
    % 计算p值
    p = 1 - chi2cdf(chi2stat, df);
    
    % 做出假设检验决策
    h = p < 0.001; % 使用0.05作为显著性水平
end