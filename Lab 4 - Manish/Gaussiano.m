function [vfim] = Gaussiano(p,vFinal3)
inversa = @(e) -2*log(2.*e);
Q = @(x) 0.5*exp(-0.5.*(x.^2));
EN = inversa(p);
f1 = sqrt(2*EN) - (1/4)*sqrt(2/EN)*log((1-p)/p);
f2 = sqrt(2*EN) + (1/4)*sqrt(2/EN)*log((1-p)/p);
p2 = p*Q(f1) + (1-p)*Q(f2)
m = length(vFinal3);
    for j = 1:m
        x = rand;
        if x < p2
            vFinal3(j) = mod(vFinal3(j)+1,2);
        end
    end
vfim = vFinal3;
end