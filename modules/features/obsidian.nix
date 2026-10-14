{ ... }: {
  flake.homeModules.obsidian = { config, pkgs, lib, ... }: {
    programs.obsidian = {
      enable = true;
    };
  };
}
