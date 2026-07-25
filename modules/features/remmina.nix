{ ... }: {
  flake.homeModules.remmina = { config, pkgs, lib, ... }: {
    services.remmina.enable = true;

    home.packages = with pkgs; [
      freerdp
    ];
  };
}
