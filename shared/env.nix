{ pkgs, ... }:
{
  environment.etc = with pkgs.nd-apps; {
    "gitconfig".source = "${git}/etc/gitconfig";
    "gitignore".source = "${git}/etc/gitignore";
  };
}
