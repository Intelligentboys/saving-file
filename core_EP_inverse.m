function A_EP=core_EP_inverse(A)
%矩阵A必须为方阵
%首先计算矩阵的指标k
n=size(A);
B=A;
for k=1:n
    if rank(B)==rank(B*A)
        break;
    end
    B=B*A;
end

%判断矩阵A是否满足EP-core逆存在的充要条件:rank((A^k)'*A^(k+1))=rank(A^k)
if rank(B'*B*A)~=rank(B)
    %warning('该矩阵的EP-core inverse不存在!');
    %A_EP=zeros(n);
    %return;
end

A_EP=B*pinv(B'*B*A)*B';