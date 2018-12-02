prob = [0.5, 0.2, 0.1,0.05, 0.02, 0.01,0.005, 0.002, 0.001, 0.0005, 0.0002, 0.0001];
prob = flip(prob);
t = length(prob);
erro = zeros(1, t);

%% Atividade 1:
Q = @(x) 0.5*exp(-0.5.*(x.^2));
intervalo = (0:0.01:10);
curvap = Q(sqrt(2*intervalo));
figure(1)
plot(intervalo,curvap)

%% Atividade 2:
inversa = @(e) -2*log(2.*e);
equiv = inversa(prob);

[erroH1,erroH2,erroH3,erroH4] = Hamming();
[erroC1,erroC2] = Ciclico();
[erroCo1,erroCo2,erroCo3] = Convolucao();
erroC2 = flip(erroC2);
erroC1 = flip(erroC1);

figure(2)
plot(equiv,erroH1,equiv,erroH4,equiv,erroH2,equiv,erroH3,equiv,erroC1,equiv,erroC2,equiv,erroCo1,equiv,erroCo2,equiv,erroCo3)
legend('Hamming(7,4)','Codificador(10,6)','Codificador(12,8)','Codificador(15,11)',"1 + x^4 + x^6","1 + x^2 + x^6","m = 3","m = 4","m = 6")

%% Atividade 3:
    %Canais prontos
    
%% Atividade 4:
[erroVU1,erroVU2,erroVU3] = ViterbiUm()
[erroVD1,erroVD2,erroVD3] = ViterbiDois()
figure(3)
plot(equiv,erroVU1,equiv,erroVU2,equiv,erroVU3,equiv,erroVD1,equiv,erroVD2,equiv,erroVD3)
legend ("m = 3 v1","m = 4 v1","m = 6 v1","m = 3 v2","m = 4 v2","m = 6 v2")


%% Atividade 5:
figure(4)
plot((4/7)*equiv,erroH1,(4/7)*equiv,erroC1,(1/3)*equiv,erroCo1,(1/3)*equiv,erroVU1,(1/3)*equiv,erroVD1)
legend('Hamming(7,4)',"1 + x^4 + x^6",'Viterbi(m = 3)','Var. 1 de Viterbi (m = 3)','Var. 2 de Viterbi (m = 3)' )
