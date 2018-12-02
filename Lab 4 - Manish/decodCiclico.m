function [out] = decodCiclico(in,g,conj)
n = length(in);
k = n - length(g);

% cálculo das sindromes do 1º bit
% conj = conjuntoSindromes(g,n)

% decodificação

[out,r] = deconv(fliplr(in),fliplr(g));
out = fliplr(out)
out = mod(out(1:k),2);
r = fliplr(r)
r = mod(r(1:n-k-1),2);
giros = 0;
while and(not(isequal(r,zeros(1,n-k-1))),giros<2^(n-k-1))
    giros = 0
    g
    in
    out
    conj
    r
    rorig = r
    ehSind = false
    for i = 1:size(conj,1)
        if isequal(conj(i,:), r)
            ehSind = true
        end
    end
    while and(not(ehSind),giros<2^(n-k-1))
        in = girar(in,g)
        r = girar(r,g)
        giros = giros + 1
        for i = 1:size(conj,1)
            if isequal(conj(i,:), r)
                ehSind = true
            end
        end
    end
    in(n) = mod(in(n) - 1, 2);
    for i = 1:giros
        in = desgirar(in,g);
    end
    [out,r] = deconv(fliplr(in),fliplr(g));
    out = fliplr(out);
    out = mod(out(1:k+1),2)
    r = fliplr(r);
    r = mod(r(1:n-k-1),2)
end
[out,r] = deconv(fliplr(in),fliplr(g));
out = fliplr(out);
out = mod(out(1:k+1),2)
r = fliplr(r);
r = mod(r(1:n-k-1),2)
end