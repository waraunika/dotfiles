{
  if ($1 == "startup_commands") { print; next }
  out = $1
  for (i = 2; i <= NF; i++) {
    out = out sprintf("\t%.4f", $i / 255)
  }
  print out
}
