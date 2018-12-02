function [Erros1,Erros2] = Ciclico()
g1 = [1 0 0 0 1 0 1];
g2 = [1 0 1 0 0 0 1];
g3 = [1 1 1 1 1 1 1];
conj1 = conjuntoSindromes(g1,14);
conj2 = conjuntoSindromes(g2,14);
conj3 = conjuntoSindromes(g3,14);
k = 8;
tam = 400;
PP = [0.5, 0.2, 0.1,0.05, 0.02, 0.01,0.005, 0.002, 0.001, 0.0005, 0.0002, 0.0001];
% PP = [0.1 0.01 0.001];
% PP = [0.5 0.4 0.3 0.2 0.1 0.05 0.04 0.03 0.02 0.01 0.005 0.004 0.003 0.002 0.001];
% PP = [0.5 0.4 0.3 0.2 0.1 0.05 0.04 0.03 0.02 0.01 0.005 0.004 0.003 0.002 0.001 0.0005 0.0004 0.0003 0.0002 0.0001 0.0005 0.0002 0.0001 0.00005 0.00002 0.00001];
Erros1 = zeros(size(PP));
Erros2 = zeros(size(PP));
Erros3 = zeros(size(PP));
ErrosH= zeros(size(PP));
Erros = zeros(size(PP));
T1 = zeros(size(PP));
T2 = zeros(size(PP));
T3 = zeros(size(PP));
TH = zeros(size(PP));
for i = 1:length(PP)
    for j = 1:30
      p = PP(i);
      dados = mod(randi(2, [1 tam]),2);
      saidaC1 = zeros([1 tam]);
      saidaC2 = zeros([1 tam]);
      saidaC3 = zeros([1 tam]);
      saidaH  = zeros([1 tam]);
      saida   = zeros([1 tam]);
      for x = 1:(tam/k)
          tic
          saidaC1(k*(x-1)+1:k*x)       = decodCiclico(BSCC(codCiclico(dados(k*(x-1)+1:k*x),g1),p),g1,conj1);
          T1(i) = toc;
          tic
          saidaC2(k*(x-1)+1:k*x)       = decodCiclico(BSCC(codCiclico(dados(k*(x-1)+1:k*x),g2),p),g2,conj2);
          T2(i) = toc;
          tic
          saidaC3(k*(x-1)+1:k*x)       = decodCiclico(BSCC(codCiclico(dados(k*(x-1)+1:k*x),g3),p),g3,conj3);
          T3(i) = toc;
          tic
          saidaH(k*(x-1)+1:k*(x-1)+4)  = decodHamming2(BSCC(codHamming2(dados(k*(x-1)+1:k*(x-1)+4)),p));
          TH(i) = toc;
          saida(k*(x-1)+5:k*x)         = BSCC(dados(k*(x-1)+5:k*x),p);
      end
      
      %Erros1(i) = (norm(abs(dados-saidaH1),1)/tam)
      Erros1(i) = (norm(abs(dados-saidaC1),1)/tam + (j-1)*Erros1(i))/j;
      Erros2(i) = (norm(abs(dados-saidaC2),1)/tam + (j-1)*Erros2(i))/j;
      Erros3(i) = (norm(abs(dados-saidaC3),1)/tam + (j-1)*Erros3(i))/j;
      ErrosH(i) = (norm(abs(dados-saidaH),1)/tam + (j-1)*Erros2(i))/j;
      Erros(i) = (norm(abs(dados-saida),1)/tam + (j-1)*Erros(i))/j;
      mean(T1);
      mean(T2);
      mean(T3);
      mean(TH);
    end
end
% loglog(PP,Erros1,PP,ErrosH,PP,PP)
% title ("Comparação do Hamming 4:7 e codificação cíclica 8:14");
% xlabel ("Probabilidade de erro no canal");
% ylabel ("Porcentagem de erros de comunicação");
% legend ("1 + x^4 + x^6","Hamming 4:7","sem correção", "location", "northeast"); 
% grid;
% hold off;
% set ( gca, 'xdir', 'reverse' )
% 
% loglog(PP,Erros1,PP,Erros2,PP,PP)
% title ("Comparação da codificação cíclica 8:14");
% xlabel ("Probabilidade de erro no canal");
% ylabel ("Porcentagem de erros de comunicação");
% legend ("1 + x^4 + x^6","1 + x^2 + x^6","sem correção", "location", "northeast"); 
% grid;
% set ( gca, 'xdir', 'reverse' )
end
