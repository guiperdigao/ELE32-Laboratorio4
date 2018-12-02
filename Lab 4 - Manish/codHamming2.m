function [out] = codHamming2(in)

G = [1 0 0 0 1 1 1; 0 1 0 0 1 0 1; 0 0 1 0 1 1 0; 0 0 0 1 0 1 1];

out = mod(in*G,2);

H = [1 1 1; 1 0 1; 1 1 0; 0 1 1; 1 0 0; 0 1 0; 0 0 1]';
end