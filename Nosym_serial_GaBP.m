function [x1,num]=Nosym_serial_GaBP(A,b,e,n)
P=diag(diag(A));
m=diag(b);
A=A-P;
[row, col, ~] = find(A);
A=A+eye(n);
x1=zeros(n,1);
mu=x1;
sigma=x1;
num=0;
i=0;
b(n)=0;
for j=2:length(row)
    if col(j)~=col(j-1)
        i=i+1;
        b(i)=j;
    end
end
while(1)
    num=num+1;
    x2=x1;
    i=1;
    mu(col(1))=sum(m(:,col(1)));
    sigma(col(1))=sum(A(:,col(1)).*P(:,col(1)));
    x1(col(1))=mu(col(1))/sigma(col(1));
    for j=1:length(row)
        if j==b(i)
           i=i+1;
           mu(col(j))=sum(m(:,col(j)));
           sigma(col(j))=sum(A(:,col(j)).*P(:,col(j)));
           x1(col(j))=mu(col(j))/sigma(col(j));
           P(col(j),row(j))=-A(row(j),col(j))/(sigma(col(j))-P(row(j),col(j))*A(row(j),col(j)));
           m(col(j),row(j))=P(col(j),row(j))*(mu(col(j))-m(row(j),col(j)));
        else
           P(col(j),row(j))=-A(row(j),col(j))/(sigma(col(j))-P(row(j),col(j))*A(row(j),col(j)));
           m(col(j),row(j))=P(col(j),row(j))*(mu(col(j))-m(row(j),col(j)));
        end
    end
    for i=1:n
        mu(i)=sum(m(:,i));
        sigma(i)=sum(A(:,i).*P(:,i));
        x1(i)=mu(i)/sigma(i);
    end
    if norm(x1-x2)<e
        break;
    end
end