%clc;
%filename='sherman3.mtx';
%[A,rows,cols,entries,rep,field,symm]=mmread(filename);
A=Problem.A;
[rows,cols]=size(A);
n=rows;
%b=ones(n,1);
e=10^-1;
%A=A*eye(n);
%for i=1:n
%temp=0;
%for j=1:n
%temp=temp+abs(A(i,j));
%end
%A(i,i)=temp-abs(A(i,i))+0.001;
%end
%B=abs(A)+abs(A');
%元素不为0则表示联通，1
%adjList=matrixToAdjList(B);
%connectedComponents=findConnectedComponents(adjList);
%[result,non]=cell_to_max(connectedComponents);
%[x1,n1,pt1]=Serial_GaBP(A,b,e,n);
%[x2,n2,pt2]=Nosym_serial_GaBP(A,b,e,n);
%tic
%[x2,n2,pt2]=jacobi(A,b,e,n);
%timejacobi=toc;
%tic;
%[x3,n3,pt3]=Nosym_serial_GaBP(A,b,e,n);
%timeGabp=toc;
%[x4,n4,pt4]=gauss_seidel(A,b,e,n);
%tic;
%[x5,n5,pt5]=new_CNSG(A,b,e,n,result,non);
%timenewGabp=toc;
%tic;
%[x6,n6,pt6]=SOR(A,b,e,n,1);
%[x6,n6,pt6]=gauss_seidel(A,b,e,n);
%timesor=toc;
tic;
[x7,n7,pt7]=gmres(A,b,n,e,2000);
timeGMRES=toc;
%[x5,n5,pt5]=Nosym_parallel_GaBP(A,b,e,n);
%[x6,n6,pt6]=conjugate_gradient(A,b,e,n);

figure;
semilogy(1:n2, pt2, 'r--', 'LineWidth', 1.5); % Jacobi（红色）
hold on;
semilogy(1:n3, pt3, 'b-.', 'LineWidth', 1.5); % GaBP（蓝色）
semilogy(1:n5, pt5, 'g--s', 'LineWidth', 1.6,'MarkerSize', 0.1); % DFS-GaBP（绿色）
semilogy(1:n6, pt6, 'c:', 'LineWidth', 1.5); % SOR（青色）
semilogy(1:n7, pt7, 'k-', 'LineWidth', 1.5); % GMRES（黑色）
% 设置坐标轴和标签
grid on;
xlabel('n', 'Interpreter', 'latex'); % 横坐标：n
ylabel('residual', 'Interpreter', 'latex'); % 纵坐标：残差公式
title('不同求解器的收敛性比较');
% 调整坐标轴范围（可选）
xlim([1, max([n2, n3, n5, n6, n7])]); % 横坐标范围
ylim([1e-6, 1e2]); % 纵坐标范围（对数刻度）
%yticks(10.^(-6:1:2)); % 示例：设置 x 轴刻度为 [0, 1, 2, 3]
set(gca, 'YTick', 10.^(-6:1:2));
% 图例
legend('Jacobi', 'GaBP', 'DFS-GaBP', 'SOR', 'GMRES', 'Location', 'best');
clf;
x=1:5;
y=[timejacobi,timesor,timeGMRES,timeGabp,timenewGabp];
bar(x,y);
% 示例：设置 x 轴刻度为 [0, 1, 2, 3]
set(gca, 'XTick', x);%xticks(x); % 设置横坐标的位置
%xticklabels({'Jacobi', 'SOR', 'GMRES', 'GaBP', 'DFS-GaBP'}); % 设置横坐标的注释
% 示例：将刻度标签改为文本
set(gca, 'XTickLabel', {'Jacobi', 'SOR', 'GMRES', 'GaBP', 'DFS-GaBP'});
title('21982×21982');
xlabel('迭代次数');
ylabel('残差');
%[x3,n3]=jacobi(A,b,e,n);
%[x4,n4]=gauss_seidel(A,b,e,n);
%[x5,n5]=Serial_GaBP(A,b,e,n);
%[x6,n6]=conjugate_gradient(A,b,e,n);
%[x7,n7]=Parallel_GaBP(A,b,e,n);
%[x8,n8]=N_s_G(A,b,e,n);
%[x9,pf,n9]=gabp(A,b,10000,e);