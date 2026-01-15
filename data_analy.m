clear,clc;
a = 1.0;          % 对流速度
L = 1.0;          % 空间域长度
T = 0.1;          % 模拟时间
CFL = 0.5;        % 固定CFL数

% 不同网格分辨率
h_list = [0.01, 0.005, 0.0025];  % h和k同时减半
errors = zeros(size(h_list));

for i = 1:length(h_list)
    h = h_list(i);
    k = CFL * h / a;          % 保持CFL数固定
    N = round(L / h);          % 空间网格数
    M = round(T / k);          % 时间步数
    x = linspace(0, L, N+1);   % 空间网格

    % 初始条件（光滑函数）
    u0 = sin(2 * pi * x);
    u = u0(1:N);               % 忽略最后一个点（周期性边界）

    % Lax-Friedrichs迭代
    for n = 1:M
        u_left = [u(end), u(1:end-1)];
        u_right = [u(2:end), u(1)];
        u = 0.5 * (u_left + u_right) - 0.5 * a * k / h * (u_right - u_left);
    end

    % 计算解析解和误差
    u_exact = sin(2 * pi * (x - a * T));  % 精确解
    u_exact = u_exact(1:N);
    errors(i) = norm(u - u_exact, 'inf');  % 无穷范数误差
end

% 显示误差变化率
disp('网格步长h | 误差 | 误差比（h_i / h_{i-1}）');
disp([h_list', errors', [NaN; errors(1:end-1)' ./ errors(2:end)']]);