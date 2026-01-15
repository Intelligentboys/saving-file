function [x,num]=gauss_seidel(A,b,e,n)
x=zeros(n,1);
num=0;
D = diag(diag(A),0);
U = triu(-A,1); %上三角矩阵
L = tril(-A,-1); %下三角矩阵
B = inv(D-L)*U;
f = inv(D-L)*b;
while(1)
    num=num+1;
    x_old=x;
    x=B*x+f;
    if(norm(x-x_old)<e)
        break;
    end
end