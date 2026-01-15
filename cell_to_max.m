function [result,non] = cell_to_max(adjList)
% 找到最大长度
max_length = max(cellfun(@length, adjList));

% 初始化结果矩阵
result = zeros(max_length, numel(adjList));

% 填充并拼接
for i = 1:numel(adjList)
    vec = adjList{i};  % 获取当前向量
    if ~isempty(vec)
        result(1:length(vec), i) = vec;  % 填充到结果矩阵
    end
end

non=sum(result ~= 0, 1);