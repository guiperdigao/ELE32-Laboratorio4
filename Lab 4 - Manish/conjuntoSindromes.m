function [conj] = conjuntoSindromes(g,n)
k = n - length(g) + 1;
p = zeros([1 k]);
while not(isequal(p,ones(size(p))))
    p
    v = zeros([1 n]);
    conj = [;];
    v = v + conv(fliplr(g),fliplr(p));
    v = fliplr(v)
    v = mod(v,2)
    v(n) = mod(v(n)+1,2);
    [u, s] = deconv(fliplr(v),fliplr(g));
    s = fliplr(s)
    s = mod(s(1:n-k),2)
    esta = false;
    if length(conj)>0
        [l,h] = size(conj);
        for j = 1:l
            if isequal(conj(j,:), s)
                esta = true;
            end
        end
    end
    if ~esta
        conj = [conj;s]
    end
    
    carry = 1;
    for i = k:-1:1
        p(i) = p(i) + carry;
        if p(i) == 2
            p(i) = 0;
            carry = 1;
        else
            carry = 0;
        end
    end
end
end




