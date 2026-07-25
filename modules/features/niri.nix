{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { self', pkgs, lib, ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        input.keyboard = {
          xkb.layout = "us,ua";
        };

        layout = {
          gaps = 5;

          default-column-width = {
            proportion = 1.0;
          };
        };

        binds = {
          "Super+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Super+Return".spawn-sh = lib.getExe self'.packages.myKitty;
          "Super+F".fullscreen-window = {};
          "Alt+Q".close-window = {};

          # Columns
          "Super+Left".move-column-left = {};
          "Super+Right".move-column-right = {};
          "Super+Up".move-window-up = {};
          "Super+Down".move-window-down = {};

          "Super+Shift+Left".set-column-width = "-5%";
          "Super+Shift+Right".set-column-width = "+5%";
          "Super+Shift+Down".set-window-height = "-5%";
          "Super+Shift+Up".set-window-height = "+5%";

          "Super+M".maximize-column = {};

          # Workspace
          "Super+1".focus-workspace = 1;
          "Super+2".focus-workspace = 2;
          "Super+3".focus-workspace = 3;
          "Super+4".focus-workspace = 4;
          "Super+5".focus-workspace = 5;
          "Super+6".focus-workspace = 6;
          "Super+7".focus-workspace = 7;
          "Super+8".focus-workspace = 8;
          "Super+9".focus-workspace = 9;

          "Super+Shift+1".move-column-to-workspace = 1;
          "Super+Shift+2".move-column-to-workspace = 2;
          "Super+Shift+3".move-column-to-workspace = 3;
          "Super+Shift+4".move-column-to-workspace = 4;
          "Super+Shift+5".move-column-to-workspace = 5;
          "Super+Shift+6".move-column-to-workspace = 6;
          "Super+Shift+7".move-column-to-workspace = 7;
          "Super+Shift+8".move-column-to-workspace = 8;
          "Super+Shift+9".move-column-to-workspace = 9;

          # Misc.
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";

          # Brightness
          "XF86MonBrightnessDown".spawn-sh = "brightnessctl set 5%-";
          "XF86MonBrightnessUp".spawn-sh = "brightnessctl set 5%+";
        };
      };
    };
  };
}
