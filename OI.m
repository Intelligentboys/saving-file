function [Z,L]=OI(A,Z,n)
for i=1:n
    Y=A*Z;
    [Z,~]=qr(Y);
end
A=Z'*A*Z;
L=diag(A);