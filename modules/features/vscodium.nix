{ ... }: {
  flake.homeModules.vscodium = { config, pkgs, lib, ... }: {
    programs.vscodium = {
      enable = true;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        userSettings = {
          "workbench.colorTheme" = "Dark High Contrast";
          "editor.fontSize" = 14;
          "editor.formatOnSave" = true;
          "editor.bracketPairColorization.enabled" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
        };
      };
    };

    home.packages = [
      (pkgs.writeShellScriptBin "code" ''
        exec codium "$@"
      '')
    ];
  };
}
