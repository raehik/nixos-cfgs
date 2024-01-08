user: pkgsF: { ... }: {
  home-manager.users.${user} = { pkgs, ... }: { home.packages = pkgsF pkgs; };
}
