function x=SVD(A,b,n)
[U,S,V]=svd(A);
U=U(:,1:n);
S=S(1:n,:);
x=V*(S\(U'*b));