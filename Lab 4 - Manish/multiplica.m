function [saida] = multiplica(mem0,entr, g)

u = [entr mem0];
v = u.*g;
saida = mod(sum(v),2);
end

