function b=connect(A,n)
for i=1:n-1
    for k=i+1:n
        if A(i,k)==0 && A(k,i)~=0
            A(i,k)=1;
        end
        if A(k,i)==0 && A(i,k)~=0
            A(k,i)=1;
        end
    end
end

visit=zeros(n,1);
stack=visit;

%深度优先遍历
num=1;
k=1;
visit(k)=1;
top=0;
for i=1:n
    if A(k,i)~=0 && visit(i)==0 && i~=k
        top=top+1;
        stack(top)=i;
        visit(i)=1;
        num=num+1;
    end
end

while(top>0)
    k=stack(top);
    top=top-1;
    for i=1:n
        if A(k,i)~=0 && visit(i)==0 && i~=k
            top=top+1;
            stack(top)=i;
            visit(i)=1;
            num=num+1;
        end
    end
end

if num==n
    b=true;
else
    b=false;
end