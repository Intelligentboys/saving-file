function [x,num]=Serial_GaBP(A,b,e,n)
P=diag(diag(A));
u=diag(b./diag(A));
sum1=zeros(n,1);
sum2=sum1;
A2=A.*A;
A=A-P;
[row, col, ~] = find(A);
j=0;
for i=2:length(row)
    if col(i)~=col(i-1)
        j=j+1;
        b(j)=i;
    end
end
num=1;
while(1)
    sum2_old=sum2;
    j=1;
    sum1(col(1))=sum(P(:,col(1)));
    sum2(col(1))=sum(P(:,col(1)).*u(:,col(1)));
    for i=1:length(row)
       if i==b(j)
           sum2(col(i-1))=sum2(col(i-1))/sum1(col(i-1)); 
           j=j+1;
           sum1(col(i))=sum(P(:,col(i)));
           sum2(col(i))=sum(P(:,col(i)).*u(:,col(i)));
           P(col(i),row(i))=-A2(col(i),row(i))/(sum1(col(i))-P(row(i),col(i)));
           u(col(i),row(i))=(sum2(col(i))-P(row(i),col(i))*u(row(i),col(i)))/A(col(i),row(i));
       else
           P(col(i),row(i))=-A2(col(i),row(i))/(sum1(col(i))-P(row(i),col(i)));
           u(col(i),row(i))=(sum2(col(i))-P(row(i),col(i))*u(row(i),col(i)))/A(col(i),row(i));
       end
    end
    for j=1:n
        sum1(j)=sum(P(:,j));
        sum2(j)=(sum(P(:,j).*u(:,j)))/sum1(j);
    end 
    if(norm(sum2-sum2_old)<e)
        break;
    end
    num=num+1;
end
x=sum2;