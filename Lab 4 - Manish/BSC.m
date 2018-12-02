function [vfim] = BSC(p,vFinal3)
m = length(vFinal3);
    for j = 1:m
        x = rand;
        if x < p
            vFinal3(j) = mod(vFinal3(j)+1,2);
        end
    end
vfim = vFinal3;
end