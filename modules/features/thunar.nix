{ ... }: {
  flake.nixosModules.thunar = { pkgs, lib, ... }: {
    programs.thunar.enable = true;
    services.gvfs.enable = true;
  };
}
