clear,clc;
n=input('intput n=');
k=input('intput k=');
X=randn(n);
E=eye(n);
for i=1:n
    E(i,i)=-randn(1);
end
r=diag(E);
for i=1:n-1
    for j=1:n-i
        if abs(r(j))<abs(r(j+1))
            m=r(j);
            r(j)=r(j+1);
            r(j+1)=m;
        end
    end
end
A=X^-1*E*X;
A1=A;
A2=A;
A3=A;
for i=1:k
    [A1,L1]=OI(A1,orth(A),1);
    [A2,L2]=Qr(A2,1);
    [A3,L3]=h(A3,1);
    r1(i)=norm(L1-r);
    r2(i)=norm(L2-r);
    r3(i)=norm(L3-r);
end
subplot(1,3,1);
plot(r1,'b-');
title('正交迭代');
subplot(1,3,2);
plot(r2,'b-');
title('QR方法');
subplot(1,3,3)
plot(r3,'b-');
title('带原点位移的QR方法');