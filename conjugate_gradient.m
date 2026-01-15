function [x,num]=conjugate_gradient(A,b,e,n)
x=zeros(n,1);
r=b-A*x;
p=r;
residual_norm=norm(r);
num=1;
while (1)
    Ap=A*p;
    alpha=residual_norm^2/(p'*Ap);
    x=x+alpha*p;
    r_new=r-alpha*Ap;
    residual_norm_new=norm(r_new);
    if (residual_norm_new<e)
        break;
    end
    beta=residual_norm_new^2/residual_norm^2;
    p=r_new+beta*p;
    residual_norm=residual_norm_new;
    r=r_new;
    num=num+1;
end