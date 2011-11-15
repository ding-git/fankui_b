a = 1
loop do
  a += 1
  p a
  Process.exit(0) if a == 100000 
end