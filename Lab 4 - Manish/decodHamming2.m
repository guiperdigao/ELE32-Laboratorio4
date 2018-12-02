function [out, e] = decodHamming2(in)

H = [1 1 1; 1 0 1; 1 1 0; 0 1 1; 1 0 0; 0 1 0; 0 0 1];
s = mod(in*H,2);
e = zeros([1 7]);

for i = 1:7
    if H(i, :) == s
        e(i) = 1;
    end
end
correcao = mod(in - e,2);
out = correcao(1:4);
end