{ ... }: {
  flake.homeModules.vscodium = { config, pkgs, lib, ... }: {
    programs.vscodium = {
      enable = true;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          pkief.material-product-icons
          jnoortheen.nix-ide
          golang.go
          rust-lang.rust-analyzer
        ];

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
