clear,clc;
load('H(1).mat');             %选取H_rt0,这是一个欠定方程组，其方程组的解不唯一
H_rt0_full=full(H_rt0);       %先将稀疏矩阵转化成正常的矩阵变量，否则无法使用pinv函数
x_0=zeros(169,1);             
x_0(61:110,:)=ones(50,1);     %生成一个中心有50个1，其他元素皆为零的解向量
b_0=H_rt0_full*x_0;           %计算解向量对应下的b

H_0_MP=pinv(H_rt0_full);      %pinv函数专门用于求解矩阵的MP逆
x_0_MP=H_0_MP*b_0;            %计算MP逆矩阵对应下的解向量

%两个解向量不相等
fprintf('下面是矩阵H_rt0的MP逆结果\n两个解向量差的2范数:%f\n',norm(x_0-x_0_MP)); 
%但是用MP逆算出来的解向量也是欠定方程组的解
fprintf('将MP逆计算的解向量代回方程组得到的残差:%f\n',norm(H_rt0_full*x_0_MP-b_0));   
%其中MP逆计算得到的解是最小范数解
fprintf('用MP逆得到的解向量的范数是否小于随机生成的解向量的范数:%d\n\n',norm(x_0)>=norm(x_0_MP));       

%下面是对H_rt1矩阵做相同的操作
H_rt1_full=full(H_rt1);
x_1=zeros(639,1);
x_1(201:300,:)=ones(100,1);
b_1=H_rt1_full*x_1;

H_1_MP=pinv(H_rt1_full);
x_1_MP=H_1_MP*b_1;

fprintf('下面是矩阵H_rt1的MP逆结果\n两个解向量差的2范数:%f\n',norm(x_1-x_1_MP));
fprintf('将MP逆计算的解向量代回方程组得到的残差:%f\n',norm(H_rt1_full*x_1_MP-b_1));
fprintf('用MP逆得到的解向量的范数是否小于随机生成的解向量的范数:%d\n\n',norm(x_1)>=norm(x_1_MP)); 

%下面考虑Drazin逆
%这里由于系数矩阵为非方阵，因此需要使用带权Drazin逆，W1，W2分别为权重矩阵，需要满足对称正定的条件
W1_0=eye(169);      %W1和W2并不唯一，只要满足对称正定的条件即可，W1和W2的不同也会使得算出来的逆矩阵不同
W2_0=eye(34);
H_0_WD = weighted_drazin_non_square(H_rt0_full, W1_0, W2_0);

x_0_WD=H_0_WD*b_0;

fprintf('下面是矩阵H_rt0的Drazin逆结果\n两个解向量差的2范数:%f\n',norm(x_0-x_0_WD));
fprintf('将Drazin逆计算的解向量代回方程组得到的残差:%f\n',norm(H_rt0_full*x_0_WD-b_0));
fprintf('用MP逆得到的解向量的范数是否小于用Drazin逆得到的解向量的范数:%d\n\n',norm(x_0_WD)>=norm(x_0_MP)); %这里可能偶尔出现不是的情况，不知道为啥

W1_1=eye(639);
W2_1=eye(68);
H_1_WD = weighted_drazin_non_square(H_rt1_full, W1_1, W2_1);

x_1_WD=H_1_WD*b_1;

fprintf('下面是矩阵H_rt1的Drazin逆结果\n两个解向量差的2范数:%f\n',norm(x_1-x_1_WD));
fprintf('将Drazin逆计算的解向量代回方程组得到的残差:%f\n',norm(H_rt1_full*x_1_WD-b_1));
fprintf('用MP逆得到的解向量的范数是否小于用Drazin逆得到的解向量的范数:%d\n\n',norm(x_1_WD)>=norm(x_1_MP));


H_0=zeros(169);
H_0(1:34,:)=H_rt0_full;       %填充为方阵
H_0_EP=core_EP_inverse(H_0);  %不存在EP-core inverse

H_1=zeros(639);
H_1(1:68,:)=H_rt1_full;
H_1_EP=core_EP_inverse(H_1);

b_2=H_1*x_1;         %填充过的矩阵需要重新计算右侧向量
x_1_EP=H_1_EP*b_2;
fprintf('下面是矩阵H_rt1的EP-core-inverse结果\n两个解向量差的2范数:%f\n',norm(x_1-x_1_EP));
fprintf('将EP-core-inverse计算的解向量代回方程组得到的残差:%f\n\n',norm(H_1*x_1_EP-b_2));

%求解正则化最小二乘问题(求解三种逆求得的解的最佳线性组合)
X=[x_1_MP,x_1_EP];

lambda=[0.000001,0.001,1];
order1=pcg(X'*(H_rt1_full'*H_rt1_full+lambda(1)*eye(639))*X,X'*H_rt1_full'*b_1);
order2=pcg(X'*(H_rt1_full'*H_rt1_full+lambda(2)*eye(639))*X,X'*H_rt1_full'*b_1);
order3=pcg(X'*(H_rt1_full'*H_rt1_full+lambda(3)*eye(639))*X,X'*H_rt1_full'*b_1);

fprintf('\n正则化系数分别取0.000001,0.001,1得到的解的情况:\n');
fprintf('lambda=0.000001   ,norm(Ax-b)=%f,norm(x)=%f\n',norm(H_rt1_full*X*order1-b_1),norm(order1));
fprintf('lambda=0.001      ,norm(Ax-b)=%f,norm(x)=%f\n',norm(H_rt1_full*X*order2-b_1),norm(order2));     
fprintf('lambda=1          ,norm(Ax-b)=%f,norm(x)=%f\n\n',norm(H_rt1_full*X*order3-b_1),norm(order3));
fprintf('正则化系数分别取0.000001,0.001,1得到的解与真实解的差异:\n');
fprintf('lambda=0.000001  ,norm(x_order-x)=%f\n',norm(X*order1-x_1));
fprintf('lambda=0.001     ,norm(x_order-x)=%f\n',norm(X*order2-x_1));
fprintf('lambda=1         ,norm(x_order-x)=%f\n',norm(X*order3-x_1));

fprintf('\n\n下面是对希尔伯矩阵的讨论:\n\n');

%考虑希尔伯特矩阵的性质
Hilbert=hilb(100);    %生成一个一百阶的希尔伯特矩阵
x_h=ones(100,1);      %构造一个100维的全1向量
b_h=Hilbert*x_h;

fprintf('从理论上，当矩阵是可逆时，所有的广义逆都会变为正常的逆。然而由于Hilbert矩阵高度病态，计算出现的误差会放大，导致计算出来的广义逆和真逆之间存在较大的误差，但是从解的结构可以看出几个解都是趋于真解的\n\n');

%MP逆
Hilbert_MP=pinv(Hilbert);
x_h_MP=Hilbert_MP*b_h;

fprintf('MP逆与真解的差的2范数:%f\n',norm(x_h-x_h_MP));
fprintf('将MP逆代入原方程组的残差%f\n\n',norm(Hilbert*x_h_MP-b_h));

%Drazin逆
Hilbert_D=drazin_inverse(Hilbert);
x_h_D=Hilbert_D*b_h;

fprintf('Drazin逆的解与真解的差的2范数:%f\n',norm(x_h-x_h_D));
fprintf('将Drazin逆的解代入原方程组的残差%f\n\n',norm(Hilbert*x_h_D-b_h));

%EP核逆
Hilbert_EP=core_EP_inverse(Hilbert);   %由于矩阵非常病态，因此计算矩阵秩的时候出现了误差导致报错，实际上可逆矩阵是存在EP核逆的，而matlab的产生的误差导致计算机会认为矩阵不可逆
x_h_EP=Hilbert_EP*b_h;

fprintf('EP核逆与真解的差的2范数:%f\n',norm(x_h_EP-x_h));
fprintf('将EP核逆代入原方程组的残差%f\n\n',norm(Hilbert*x_h_EP-b_h));
fprintf('相比而言，误差值大小:EP核逆>Drazin逆>MP逆\n');

%考虑一个秩为99的100阶方阵(基于Hilbert矩阵构造)
Hilbert_99=Hilbert;
Hilbert_99(1:1,:)=Hilbert(2:2,:);

b_h_99=Hilbert_99*x_h;
Hilbert_99_MP=pinv(Hilbert_99);
Hilbert_99_D=drazin_inverse(Hilbert_99);
Hilbert_99_EP=core_EP_inverse(Hilbert_99);
x_h_99_MP=Hilbert_99_MP*b_h_99;
x_h_99_D=Hilbert_99_D*b_h_99;
x_h_99_EP=Hilbert_99_EP*b_h_99;


norm(x_h-x_h_99_MP)
norm(Hilbert_99*x_h_99_MP-b_h_99)
norm(x_h-x_h_99_D)
norm(Hilbert_99*x_h_99_D-b_h_99)
norm(x_h-x_h_99_EP)
norm(Hilbert_99*x_h_99_EP-b_h_99)

Hilbert_98=Hilbert_99;
Hilbert_98(3:3,:)=Hilbert_99(4:4,:);

%考虑一个秩为98的100阶方阵(基于Hilbert矩阵构造)
b_h_98=Hilbert_98*x_h;
Hilbert_98_MP=pinv(Hilbert_98);
Hilbert_98_D=drazin_inverse(Hilbert_98);
Hilbert_98_EP=core_EP_inverse(Hilbert_98);
x_h_98_MP=Hilbert_98_MP*b_h_98;
x_h_98_D=Hilbert_98_D*b_h_98;
x_h_98_EP=Hilbert_98_EP*b_h_98;

norm(x_h-x_h_98_MP)
norm(Hilbert_98*x_h_98_MP-b_h_98)
norm(x_h-x_h_98_D)
norm(Hilbert_98*x_h_98_D-b_h_98)
norm(x_h-x_h_98_EP)
norm(Hilbert_98*x_h_98_EP-b_h_98)