clear,clc;
k=1;
a=2;
p=0.1;
e=10^-2;
mu_1=0;
phi_1=exp(mu_1)-5*mu_1;
phid_1=exp(mu_1)-5;
while(1)
    if abs(phid_1)<e
        break;
    end
    if phid_1<0
        a=abs(a);
    elseif phid_1>0
        a=-abs(a);
    end
    mu_2=mu_1+a;
    phi_2=exp(mu_2)-5*mu_2;
    while phi_2<phi_1+phid_1*a
        a=2*a;
        mu_2=mu_1+a;
        phi_2=exp(mu_2)-5*mu_2;
    end
    
    mu=mu_1-1/2*((mu_1-mu_2)*phid_1)/(phid_1-(phi_1-phi_2)/(mu_1-mu_2));
    mu_1=mu;
    phi_1=exp(mu_1)-5*mu_1;
    phid_1=exp(mu_1)-5;
    a=a*p;
    k=k+1;
end
triArea([1 0 0],[0 1 0],[0 0 1])