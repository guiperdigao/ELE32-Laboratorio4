function [u, e] = BSC(v, p)

u = v;
e = zeros([1 length(v)]);
prob = rand([1 length(v)]);

for i = 1:length(v) 
    if prob(i) < p
        e(i) = 1;
        u(i) = abs(v(i)-1);
    end  
end
end