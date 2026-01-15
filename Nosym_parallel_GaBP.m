function [x1,num]=Nosym_parallel_GaBP(A,b,e,n)
P1=diag(diag(A));
m1=diag(b);
A=A-P1;
[row, col, ~] = find(A);
A=A+eye(n);
x1=zeros(n,1);
mu=x1;
sigma=x1;
num=0;
while(1)
    num=num+1;
    P2=P1;
    m2=m1;
    x2=x1;
    for j=1:n
        mu(j)=sum(m2(:,j));
        sigma(j)=sum(A(:,j).*P2(:,j));
        x1(j)=mu(j)/sigma(j);
    end
    for j=1:length(col)
        P1(row(j),col(j))=-A(col(j),row(j))/(sigma(row(j))-P2(col(j),row(j))*A(col(j),row(j)));
        m1(row(j),col(j))=P1(row(j),col(j))*(mu(row(j))-m2(col(j),row(j)));
    end
    if norm(x1-x2)<e
        break
    end
end