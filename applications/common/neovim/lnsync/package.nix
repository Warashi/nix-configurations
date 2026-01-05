{
  writeShellApplication,
}:
writeShellApplication {
  name = "lnsync";
  text = builtins.readFile ./main.sh;
}
