function [erro,erro2,erro3] = ViterbiDois()
prob = [0.5, 0.2, 0.1,0.05, 0.02, 0.01,0.005, 0.002, 0.001, 0.0005, 0.0002, 0.0001];
prob = flip(prob);
t = length(prob);
erro = zeros(1, t);

for r = 1:t
    u = randi([0, 1], 1, 10000);
    %% Codificador m = 3:
    m = 3;
    g13 = [1 0 1 1];
    g23 = [1 1 0 1];
    g33 = [1 1 1 1];
    mem = zeros(1,m);
    vFinal3 = [];
    for k = 1:length(u)
        v13 = multiplica(mem, u(k), g13);
        v23 = multiplica(mem, u(k), g23);
        v33 = multiplica(mem, u(k), g33);
        v = [v13 v23 v33];
        mem = [u(k) mem(1:(m-1))];
        vFinal3 = [vFinal3 v];
    end
    %%% Diagrama de estados m = 3:
    estados = DiagramaEstados(m,g13,g23,g33);
    %% Canal BSC:
    p = prob(r);
    vFinal3 = Gaussiano(p,vFinal3);
    % Algoritmo de Viterbi:
    msg = AWGN(m,vFinal3,estados);
    % Porcentagem de erro:
    e = mod(u+msg,2);
    [n,m] = size(u);
    erro(r) = sum(sum(e))/(n*m);
    
    % Codificador m = 4:
    m = 4;
    g14 = [1 0 1 0 1];
    g24 = [1 1 0 1 1];
    g34 = [1 1 1 1 1];
    mem = zeros(1,m);
    vFinal4 = [];
    for k = 1:length(u)
        v14 = multiplica(mem, u(k), g14);
        v24 = multiplica(mem, u(k), g24);
        v34 = multiplica(mem, u(k), g34);
        v = [v14 v24 v34];
        mem = [u(k) mem(1:(m-1))];
        vFinal4 = [vFinal4 v];
    end
    %%% Diagrama de estados m = 4:
    estados4 = DiagramaEstados(m,g14,g24,g34);
    %% Canal BSC:
    p = prob(r);
    vFinal4 = Gaussiano(p,vFinal4);
    % Algoritmo de Viterbi:
    msg4 = AWGN(m,vFinal4,estados4);
    % Porcentagem de erro:
    e4 = mod(u+msg4,2);
    [n,m] = size(u);
    erro2(r) = sum(sum(e4))/(n*m);
    
    % Codificador m = 6:
    m = 6;
    g16 = [1 0 0 1 1 1 1];
    g26 = [1 0 1 0 1 1 1];
    g36 = [1 1 0 1 1 0 1];
    mem = zeros(1,m);
    vFinal6 = [];
    for k = 1:length(u)
        v16 = multiplica(mem, u(k), g16);
        v26 = multiplica(mem, u(k), g26);
        v36 = multiplica(mem, u(k), g36);
        v = [v16 v26 v36];
        mem = [u(k) mem(1:(m-1))];
        vFinal6 = [vFinal6 v];
    end
    %%% Diagrama de estados m = 6:
    estados6 = DiagramaEstados(m,g16,g26,g36);
    %% Canal BSC:
    p = prob(r);
    vFinal6 = Gaussiano(p,vFinal6);
    % Algoritmo de Viterbi:
    msg6 = AWGN(m,vFinal6,estados6)
    % Porcentagem de erro:
    e6 = mod(u+msg6,2);
    [n,m] = size(u);
    erro3(r) = sum(sum(e6))/(n*m);
end
%plot(prob,prob,prob,erro,prob,erro2,prob,erro3)
end