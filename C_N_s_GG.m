function [x1,num,pt]=C_N_s_GG(A,b,e,n,connectedComponents)
P=zeros(n);
m=P;
x1=zeros(n,1);
num=0;
remain_connected=length(connectedComponents);
visited=zeros(remain_connected,1);

while(remain_connected~=0)
    num=num+1;
    x2=x1;
    
    for i=1:length(visited)
        if visited(i)==1
            continue;
        end
        for j=1:length(connectedComponents{i})
            mu=b(connectedComponents{i}(j));
            sigma=A(connectedComponents{i}(j),connectedComponents{i}(j));
            for k=1:length(connectedComponents{i})
                mu=mu+m(connectedComponents{i}(k),connectedComponents{i}(j));
                sigma=sigma+A(connectedComponents{i}(k),connectedComponents{i}(j))*P(connectedComponents{i}(k),connectedComponents{i}(j));
            end
            x1(connectedComponents{i}(j))=mu/sigma;
            for k=1:length(connectedComponents{i})
                if A(connectedComponents{i}(k),connectedComponents{i}(j))~=0 && connectedComponents{i}(j)~=connectedComponents{i}(k)
                    P(connectedComponents{i}(j),connectedComponents{i}(k))=-A(connectedComponents{i}(k),connectedComponents{i}(j))/(sigma-P(connectedComponents{i}(k),connectedComponents{i}(j))*A(connectedComponents{i}(k),connectedComponents{i}(j)));
                    m(connectedComponents{i}(j),connectedComponents{i}(k))=P(connectedComponents{i}(j),connectedComponents{i}(k))*(mu-m(connectedComponents{i}(k),connectedComponents{i}(j)));
                end
            end
        end
        if norm(x1(connectedComponents{i},1)-x2(connectedComponents{i},1))<e
            visited(i)=1;
            remain_connected=remain_connected-1;
        end
    end
    pt(num,1)=norm(A*x1-b);
    %fprintf("�?d次迭代残差为%f\n",num,pt(num,1));
end