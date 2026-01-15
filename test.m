clear,clc;
n=input('ÊäÈë¾ØÕóµÄ½×Êý');
A=2*eye(n);
b=ones(n,1);
e=10^-8;
A(1,2)=1;
A(n,n-1)=1;
for i=2:n-1
    k=rand(1);
    A(i,i-1)=k-floor(k);
    A(i,i+1)=2-A(i,i-1);
end
A=[1 2 3 0 0 0;
   2 2 1 0 0 0;
   3 1 1 0 0 0;
   0 0 0 9 1 1
   0 0 0 1 9 1;
   0 0 0 1 1 9];
A=rand(2000);
B=[1 2 3;
   2 2 1; 
   3 1 1];
C=[9 1 1;
   1 9 1;
   1 1 9];
%[x1,n1]=Nosym_parallel_GaBP(A,b,e,n);
%[y,m]=Nosym_parallel_GaBP(B,b,e,3);
%[z,k]=Nosym_parallel_GaBP(C,b,e,3);
%[x2,n2]=Nosym_serial_GaBP(A,b,e,n);
[x3,n3]=jacobi(A,b,e,n);
[x4,n4]=gauss_seidel(A,b,e,n);
%[x5,n5]=Parallel_GaBP(A,b,e,n);
[x6,n6]=Serial_GaBP(A,b,e,n);
%[x7,n7]=conjugate_gradient(A,b,e,n);
%norm(A*x1-b)
%norm(A*x2-b)
%norm(A*x3-b)
%norm(A*x4-b)
%norm(A*x6-b)
%B=A+A';
%adjList = matrixToAdjList(B);
%connectedComponents = findConnectedComponents(adjList);
%[result,non]=cell_to_max(connectedComponents);
%[x1,num]=C_N_p_G(A,b,e,n,connectedComponents);
%input('');
%[x1,num]=C_N_s_G(A,b,e,n,result,non);
%[x1,num,pt]=C_N_s_GG(A,b,e,n,connectedComponents);