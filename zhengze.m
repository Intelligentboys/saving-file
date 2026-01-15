function x=zhengze(A,b) 
B=A'*A;
L=chol(B);
c=A'*b;
y=L'\c;
x=L\y;