{ ... }: {
  flake.homeModules.vscodium = { config, pkgs, lib, ... }: {
    programs.vscodium = {
      enable = true;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        userSettings =
          (builtins.fromJSON
            (builtins.readFile ./vscodium.json));
      };
    };

    home.packages = [
      (pkgs.writeShellScriptBin "code" ''
        exec codium "$@"
      '')
    ];
  };
}
