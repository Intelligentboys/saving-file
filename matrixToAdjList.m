function adjList = matrixToAdjList(adjMatrix)
    % adjMatrix: 邻接矩阵表示的图
    % adjList: 邻接表表示的�?

    numNodes = size(adjMatrix, 1); % 获取节点数量
    adjList = cell(numNodes, 1);  % 初始化邻接表

    % 遍历每个节点
    for i = 1:numNodes
        % 找到与节点i相连的所有节�?
        neighbors = find(adjMatrix(i, :) ~= 0);
        adjList{i} = neighbors; % 将邻接节点存入邻接表
    end
end