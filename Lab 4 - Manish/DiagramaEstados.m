function [estados] = DiagramaEstados(m,g1,g2,g3)
estados3 = de2bi(0,m);
mem = zeros(1,m);
aux =[0 1];
for k = 1:length(aux)
    va13 = multiplica(mem, aux(k), g1);
    va23 = multiplica(mem, aux(k), g2);
    va33 = multiplica(mem, aux(k), g3);
    va = [va13 va23 va33];
    mem = [aux(k) mem(1:(m-1))];
    estados3 = [estados3 mem va];
end
for i = 1:pow2(m)
    for k = 1:length(aux)
        if k == 1
            mem = estados3(i,(m+1):(2*m));
            [numLin ~] = size(estados3);
            existe = 0;
            for s = 1:(numLin-1)
                if mem == estados3(s,(m+1):(2*m)) & s ~= i
                    existe = 1;
                elseif mem == estados3(s,(2*m+4):(3*m+3)) & s ~= i
                    existe = 1;
                end
            end
            if mem == estados3(i,1:m)
                existe = 1;
            end
            if existe == 0
                va13 = multiplica(mem, 0, g1);
                va23 = multiplica(mem, 0, g2);
                va33 = multiplica(mem, 0, g3);
                va = [va13 va23 va33];
                mem0 = [0 mem(1:(m-1))];
                a0 = [mem mem0 va];
                va13 = multiplica(mem, 1, g1);
                va23 = multiplica(mem, 1, g2);
                va33 = multiplica(mem, 1, g3);
                va = [va13 va23 va33];
                mem1 = [1 mem(1:(m-1))];
                a0 = [a0 mem1 va];
                estados3 = [estados3;a0];
            end
        end
        if k == 2
            mem = estados3(i,(2*m+4):(3*m+3));
            [numLin ~] = size(estados3);
            existe = 0;
            for s = 1:(numLin-1)
                if mem == estados3(s,(m+1):(2*m)) & s ~= i
                    existe = 1;
                elseif mem == estados3(s,(2*m+4):(3*m+3)) & s ~= i
                    existe = 1;
                end
            end
            if mem == estados3(i,1:m)
                existe = 1;
            end
            if existe == 0
                va13 = multiplica(mem, 0, g1);
                va23 = multiplica(mem, 0, g2);
                va33 = multiplica(mem, 0, g3);
                va = [va13 va23 va33];
                mem0 = [0 mem(1:(m-1))];
                a0 = [mem mem0 va];
                va13 = multiplica(mem, 1, g1);
                va23 = multiplica(mem, 1, g2);
                va33 = multiplica(mem, 1, g3);
                va = [va13 va23 va33];
                mem1 = [1 mem(1:(m-1))];
                a0 = [a0 mem1 va];
                estados3 = [estados3;a0];
            end
        end
    end
end
estados = estados3;
end