function [x,num]=Parallel_GaBP(A,b,e,n) %A是一个对称正定的矩阵，e表示误差控制,n是矩阵的阶数
P1=diag(diag(A));
u1=diag(b./diag(A));
sum1=zeros(n,1);
sum2=sum1;
A=A-P1;
A2=A.*A;
[row, col, ~] = find(A);
num=1;
while(1)
    P2=P1;
    u2=u1;
    sum2_old=sum2;
    for i=1:n
       sum1(i)=sum(P1(:,i));
       sum2(i)=sum(P1(:,i).*u1(:,i));
    end
    for i=1:length(row)
       P1(row(i),col(i))=-A2(row(i),col(i))/(sum1(row(i))-P2(col(i),row(i)));
       u1(row(i),col(i))=(sum2(row(i))-P2(col(i),row(i))*u2(col(i),row(i)))/A(row(i),col(i));
    end
    for i=1:n
       sum2(i)=sum2(i)/sum1(i); 
    end
    if(norm(sum2-sum2_old)<e)
        break;
    end
    num=num+1;
end
x=sum2;