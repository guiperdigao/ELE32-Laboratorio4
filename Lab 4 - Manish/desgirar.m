function b = desgirar(a,f)
  n = length(a);
  k = length(f);
  g = [f, zeros(1, n-k)];
  g(k) = 0;
  b = zeros(size(a));
  b(n) = mod(a(1),2);
  for i = 1:n-1
    b(i) = mod(a(i+1)-g(i+1)*b(n),2);
  end
end