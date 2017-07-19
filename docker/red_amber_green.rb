
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :red   if /==========\[ SUMMARY \]==========[^:]*:\s*failed/.match(output)
  return :green if /==========\[ SUMMARY \]==========[^:]*:\s*passed/.match(output)
  return :amber
}
