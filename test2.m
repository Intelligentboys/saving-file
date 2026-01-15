clear,clc;
filename='sherman3.mtx';
%[A,rows,cols,entries,rep,field,symm]=mmread(filename);
load('F:\matlab\bin\First\矩阵\std1_jac3_db.mat')
%n=rows;
[c,rows]=size(Problem.A);
A=Problem.A;
B=abs(A)+abs(A');
adjList = matrixToAdjList(B);
connectedComponents = findConnectedComponents(adjList);
A=A*eye(rows);
remain_connected=length(connectedComponents);
for i=1:rows
    for k=1:remain_connected
        if ismember(i,k)
            break
        end
    end
    for j=1:rows
        if A(i,j)~=0
            A(i,j)=k;
        
        end
        
    end
end
figure;
% --- 绘制主热图 ---
% 仅对非零值设置颜色范围
alpha_mask = double(A ~= 0);
imagesc(A);
set(gca, 'Color', [0 0 0]); % 背景设为白色
h = get(gca, 'Children');
set(h, 'AlphaData', alpha_mask); % 应用透明度
colorbar;
set(gca, 'XTick', []); % 隐藏 x 轴刻度
set(gca, 'YTick', []); % 隐藏 y 轴刻度
%[x,flag,r,iter,cc]=gmres(A,b);

%[x1,n1]=Serial_GaBP(A,b,e,n);
%[x2,n2]=Nosym_serial_GaBP(A,b,e,n);
%[x3,n3]=jacobi(A,b,e,n);
%[x4,n4]=gauss_seidel(A,b,e,n);
%[x5,n5]=Serial_GaBP(A,b,e,n);
%[x6,n6]=conjugate_gradient(A,b,e,n);
%[x7,n7]=Parallel_GaBP(A,b,e,n);
%[x9,n9]=Nosym_parallel_GaBP(A,b,e,n);

%[x1,num]=C_N_p_G(A,b,e,n,connectedComponents);
%[x1,num]=C_N_s_G(A,b,e,n,result,non);
%[x4,n4]=sor(A,b,e,n,0.7,14000);