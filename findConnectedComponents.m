function connectedComponents = findConnectedComponents(adjList)
    % adjList: 閭绘帴琛ㄨ〃绀虹殑鍥?
    % connectedComponents: 涓?釜鍏冭優鏁扮粍锛屾瘡涓厓鑳炲寘鍚竴涓繛閫氬垎閲忕殑鑺傜偣鍒楄〃
    num=0;
    numNodes = length(adjList); % 鑾峰彇鑺傜偣鏁伴噺
    visited = false(1, numNodes); % 鍒濆鍖栬闂暟缁?
    connectedComponents = {}; % 鍒濆鍖栬繛閫氬垎閲?

    % 閬嶅巻鎵?湁鑺傜偣
    for i = 1:numNodes
        if ~visited(i)
            % 鍒濆鍖栦竴涓柊鐨勮繛閫氬垎閲?
            component = [];
            % 璋冪敤 DFS 鏉ヨ闂墍鏈変笌鑺傜偣 i 杩為?鐨勮妭鐐?
            [visited,component] = dfs(adjList, i, visited, component);
            % 灏嗚繛閫氬垎閲忔坊鍔犲埌缁撴灉涓?
            connectedComponents{end+1} = component;
            num=num+1;
        end
    end
    fprintf('连通分量个数为：%d',num);
end



