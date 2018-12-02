function b = girar(a,f)
  n = length(a);
  k = length(f);
  g = [f, zeros(1, n-k)];
  g(k) = 0;
  b = zeros(size(a));
  b(1) = mod(g(1)*a(n),2);
  for i = 2:n
    b(i) = mod(g(i)*a(n) + a(i-1),2);
  end
end