function [msg] = Decodificador(m, vFinal3, estados)
custo =[];
inf = [];
decod =[];
check = [];
% Inicialização da matriz de custo:
for i = 0:(pow2(m)-1)
    custo = [custo; i];
    inf = [inf; pow2(300)];
    decod = [decod; 2];
    check = [check; 0];
end
inf(1) = 0;
custo = [custo, inf];
decod(1) = 0;
% Calculo de custo:
n = length(vFinal3);
rng = [1:3:n];
for i = 1:length(rng)
    len = size(custo,2);
    if i > 1
        adecod = custo(:,3:len);
    end
    simbolo = vFinal3(rng(i):rng(i)+2);
    acusto = custo(:,2);
    for k = 1:pow2(m)
        if custo(k,2) < pow2(300)
            saida0 = estados(k,(2*m+1):(2*m+3));
            dist0 = sum(mod((simbolo+saida0),2));
            dest0 = bi2de(estados(k,(m+1):(2*m)));
            saida1 = estados(k,(3*m+4):(3*m+6));
            dist1 = sum(mod((simbolo+saida1),2));
            dest1 = bi2de(estados(k,(2*m+4):(3*m+3)));
            if dest1 == dest0 & check(dest1+1) == 0
                if dist1 < dist0
                    acusto(dest1+1) = custo(k,2) + dist1;
                    decod(dest1+1) = 1;
                    if i > 1
                        n = size(custo,2);
                        custo((dest1+1),3:n) = adecod(k,:);
                    end
                else
                    acusto(dest0+1) = custo(k,2) + dist0;
                    decod(dest0+1) = 0;
                    if i > 1
                        n = size(custo,2);
                        custo((dest0+1),3:n) = adecod(k,:);
                    end
                end
            elseif check(dest1+1) == 0 && check(dest0+1) == 0
                acusto(dest0+1) = custo(k,2) + dist0;
                acusto(dest1+1) = custo(k,2) + dist1;
                decod(dest0+1) = 0;
                decod(dest1+1) = 1;
                if i > 1
                    n = size(custo,2);
                    custo((dest0+1),3:n) = adecod(k,:);
                    custo((dest1+1),3:n) = adecod(k,:);
                end
            end
            if check(dest1+1) == 1 && check(dest0+1) == 1
                if (custo(k,2) + dist0) < acusto(dest0+1)
                    decod(dest0+1) = 0;
                    acusto(dest0+1) = custo(k,2)+dist0;
                    if i > 1
                        n = size(custo,2);
                        custo((dest0+1),3:n) = adecod(k,:);
                    end
                end
                if (custo(k,2)+dist1) < acusto(dest1+1)
                    decod(dest1+1) = 1;
                    acusto(dest1+1) = custo(k,2)+dist1;
                    if i > 1
                        n = size(custo,2);
                        custo((dest1+1),3:n) = adecod(k,:);
                    end
                end
            end
            check(dest0+1) = 1;
            check(dest1+1) = 1;
        end
    end
    check = zeros(pow2(m),1);
    custo(:,2) = acusto;
    custo = [custo decod];
end
[m,n] = size(custo);
min = pow2(300);
for i = 1:m
    if custo(i,2) < min
        msg = custo(i,3:n);
        min = custo(i,2);
    end
end
end