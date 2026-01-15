function [x1,num]=C_N_s_G(A,b,e,n,result,non)
P=zeros(n);
m=P;
x1=zeros(n,1);
num=0;
remain_connected=length(non);
visited=zeros(remain_connected,1);

while(remain_connected~=0)
    num=num+1;
    x2=x1;
    
    for i=1:length(visited)
        if visited(i)==1
            continue;
        end
        for j=1:non(i)
            mu=b(result(j,i));
            sigma=A(result(j,i),result(j,i));
            for k=1:non(i)
                mu=mu+m(result(k,i),result(j,i));
                sigma=sigma+A(result(k,i),result(j,i))*P(result(k,i),result(j,i));
            end
            x1(result(j,i))=mu/sigma;
            for k=1:non(i)
                if A(result(k,i),result(j,i))~=0 && result(j,i)~=result(k,i)
                    P(result(j,i),result(k,i))=-A(result(k,i),result(j,i))/(sigma-P(result(k,i),result(j,i))*A(result(k,i),result(j,i)));
                    m(result(j,i),result(k,i))=P(result(j,i),result(k,i))*(mu-m(result(k,i),result(j,i)));
                end
            end
        end
        if norm(x1(result(1:non(i),i),1)-x2(result(1:non(i),i),1))<e
            visited(i)=1;
            remain_connected=remain_connected-1;
        end
    end
    norm(x1-x2)
end