function [visited,component] = dfs(adjList, node, visited, component)
    % adjList: 邻接表表示的图
    % node: 当前节点
    % visited: 访问数组
    % component: 当前连通分量的节点列表

    % 标记当前节点为已访问
    visited(node) = true;
    % 将当前节点添加到连通分量中
    component = [component, node];

    % 获取当前节点的邻接节点
    neighbors = adjList{node};

    % 递归访问所有未访问的邻接节点
    for i = 1:length(neighbors)
        if ~visited(neighbors(i))
            [visited,component] = dfs(adjList, neighbors(i), visited, component);
        end
    end
end