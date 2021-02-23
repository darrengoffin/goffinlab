function result = DG_logspace(min, max, n)

  assert(min~=0, 'Log-spaced frequencies cannot have min of 0')

  result = logspace(log10(min), log10(max), n);

end
