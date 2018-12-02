function [erro,erro2,erro3,erro4] = Hamming()
prob = [0.5, 0.2, 0.1,0.05, 0.02, 0.01,0.005, 0.002, 0.001, 0.0005, 0.0002, 0.0001];
prob = flip(prob);
t = length(prob);
erro = zeros(1, t);
u = randi([0, 1], 250000, 4);
%% Codificador de Hamming
P = [1 1 1; 1 0 1; 1 1 0; 0 1 1];
G = [eye(4) P];
H = [P' eye(3)];
v = mod(u*G,2);
v_o = v; %salva mensagem original

for r = 1:t
    %% Canal BSC:
    p = prob(r);
    [n,m] = size(v);
    for i = 1:n
        for j = 1:m
            x = rand;
            if x < p
                v(i,j) = mod(v(i,j)+1,2);
            end
        end
    end

    %% Decodificador
    s = mod(v*H',2);
    A = H';
    for x = 1:n
        k = -1;
        for i = 1:7
            if s(x,:) == A(i,:)
                k = i;
            end
        end
        if k ~= -1
            v(x,k) = mod(v(x,k)+1,2);
        end
    end
    msg = v(:,1:4);

    %% Porcentagem de erro:
    e = mod(u+msg,2);
    [n,m] = size(u);
    erro(r) = sum(sum(e))/(n*m);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Codificador para tamanhos maiores (12,8)
P2 = [1 1 0 0;0 1 0 1;1 0 0 1;0 0 1 1; 0 1 1 0;1 0 1 0;1 1 0 1;1 0 1 1];
G2 = [eye(8) P2];
H2 = [P2' eye(4)];
u2 = randi([0, 1], 125000, 8);
v2 = mod(u2*G2,2);
erro2 = zeros(1, t);
for r = 1:t
    %% Canal BSC:
    p = prob(r);
    [n,m] = size(v2);
    for i = 1:n
        for j = 1:m
            x = rand;
            if x < p
                v2(i,j) = mod(v2(i,j)+1,2);
            end
        end
    end

    %% Decodificador
    s2 = mod(v2*H2',2);
    A2 = H2';
    for x = 1:n
        k = -1;
        for i = 1:12
            if s2(x,:) == A2(i,:)
                k = i;
            end
        end
        if k ~= -1
            v2(x,k) = mod(v2(x,k)+1,2);
        end
    end
    msg2 = v2(:,1:8);

    %% Porcentagem de erro:
    e2 = mod(u2+msg2,2);
    [n,m] = size(u2);
    erro2(r) = sum(sum(e2))/(n*m);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Codificador para tamanhos maiores (15,11)
P3 = [1 1 0 0;1 0 1 0; 0 1 1 0; 1 1 1 0; 1 0 0 1;0 1 0 1;1 1 0 1;0 0 1 1;1 0 1 1;0 1 1 1; 1 1 1 1];
G3 = [eye(11) P3];
H3 = [P3' eye(4)];
u3 = randi([0, 1], 91000, 11);
v3 = mod(u3*G3,2);
erro3 = zeros(1, t);
for r = 1:t
    %% Canal BSC:
    p = prob(r);
    [n,m] = size(v3);
    for i = 1:n
        for j = 1:m
            x = rand;
            if x < p
                v3(i,j) = mod(v3(i,j)+1,2);
            end
        end
    end

    %% Decodificador
    s3 = mod(v3*H3',2);
    A3 = H3';
    for x = 1:n
        k = -1;
        for i = 1:15
            if s3(x,:) == A3(i,:)
                k = i;
            end
        end
        if k ~= -1
            v3(x,k) = mod(v3(x,k)+1,2);
        end
    end
    msg3 = v3(:,1:11);

    %% Porcentagem de erro:
    e3 = mod(u3+msg3,2);
    [n,m] = size(u3);
    erro3(r) = sum(sum(e3))/(n*m);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Codificador para tamanhos maiores (10,6)
P4 = [1 0 1 0; 1 1 0 0; 0 1 0 1; 1 0 0 1;0 0 1 1; 0 1 1 0];
G4 = [eye(6) P4];
H4 = [P4' eye(4)];
u4 = randi([0, 1],166667, 6);
v4 = mod(u4*G4,2);
erro4 = zeros(1, t);
for r = 1:t
    %% Canal BSC:
    p = prob(r);
    [n,m] = size(v4);
    for i = 1:n
        for j = 1:m
            x = rand;
            if x < p
                v4(i,j) = mod(v4(i,j)+1,2);
            end
        end
    end

    %% Decodificador
    s4 = mod(v4*H4',2);
    A4 = H4';
    for x = 1:n
        k = -1;
        for i = 1:10
            if s4(x,:) == A4(i,:)
                k = i;
            end
        end
        if k ~= -1
            v4(x,k) = mod(v4(x,k)+1,2);
        end
    end
    msg4 = v4(:,1:6);

    %% Porcentagem de erro:
    e4 = mod(u4+msg4,2);
    [n,m] = size(u4);
    erro4(r) = sum(sum(e4))/(n*m);
end
end
%plot(prob,prob,prob,erro,prob,erro4,prob,erro2,prob,erro3)
%legend('p','Hamming(7,4)','Codificador(10,6)','Codificador(12,8)','Codificador(15,11)')