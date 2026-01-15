function [x,num]=jacobi(A,b,e,n)
x=zeros(n,1);
num=0;
D=diag(diag(A));
R=A-D;
while(1)
   num=num+1;
   x_old=x;
   x=(b-R*x_old)./diag(D);
   if(norm(x-x_old)<e)
       break;
   end
end