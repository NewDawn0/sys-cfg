{ fn, ... }:
{
  imports = fn.util.importRec ./.;
}
