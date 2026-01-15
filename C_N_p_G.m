function [x1,num]=C_N_p_G(A,b,e,n,connectedComponents)
P1=zeros(n);
m1=P1;
x1=zeros(n,1);
num=0;
remain_connected=length(connectedComponents);
visited=zeros(remain_connected,1);

while(remain_connected~=0)
    num=num+1;
    P2=P1;
    m2=m1;
    x2=x1;
    
    for i=1:length(visited)
        if visited(i)==1
            continue;
        end
        for j=1:length(connectedComponents{i})
            mu=b(connectedComponents{i}(j));
            sigma=A(connectedComponents{i}(j),connectedComponents{i}(j));
            for k=1:length(connectedComponents{i})
                if A(connectedComponents{i}(j),connectedComponents{i}(k))~=0 && connectedComponents{i}(j)~=connectedComponents{i}(k)
                    mu=mu+m2(connectedComponents{i}(k),connectedComponents{i}(j));
                    sigma=sigma+A(connectedComponents{i}(k),connectedComponents{i}(j))*P2(connectedComponents{i}(k),connectedComponents{i}(j));
                end
            end
            x1(connectedComponents{i}(j))=mu/sigma;
            for k=1:length(connectedComponents{i})
                if A(connectedComponents{i}(k),connectedComponents{i}(j))~=0 && connectedComponents{i}(j)~=connectedComponents{i}(k)
                    P1(connectedComponents{i}(j),connectedComponents{i}(k))=-A(connectedComponents{i}(k),connectedComponents{i}(j))/(sigma-P2(connectedComponents{i}(k),connectedComponents{i}(j))*A(connectedComponents{i}(k),connectedComponents{i}(j)));
                    m1(connectedComponents{i}(j),connectedComponents{i}(k))=P1(connectedComponents{i}(j),connectedComponents{i}(k))*(mu-m2(connectedComponents{i}(k),connectedComponents{i}(j)));
                end
            end
        end
        if norm(x1(connectedComponents{i},1)-x2(connectedComponents{i},1))<e
            visited(i)=1;
            remain_connected=remain_connected-1;
        end
    end
end