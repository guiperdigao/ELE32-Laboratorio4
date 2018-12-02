function [out] = codCiclico(in,g)
  out = conv(fliplr(in), fliplr(g));
  out = mod(out, 2);
  out = fliplr(out);
end
