{ self, inputs, ... }: {
  flake.homeModules.kitty = { pkgs, lib, ... }: {
    programs.kitty = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty;
    };
  };

  perSystem = { self', pkgs, lib, ... }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;

      settings = {
        confirm_os_window_close = 0;
        window_padding_width = 5;

        # Colors & Theme
        background = "#000000";
        foreground = "#e9e9e9";
        cursor = "#e9e9e9";
        selection_background = "#424242";
        selection_foreground = "#000000";

        # 16-color Palette
        color0 = "#000000";
        color8 = "#000000";
        color1 = "#d44d53";
        color9 = "#d44d53";
        color2 = "#b9c949";
        color10 = "#b9c949";
        color3 = "#e6c446";
        color11 = "#e6c446";
        color4 = "#79a6da";
        color12 = "#79a6da";
        color5 = "#c396d7";
        color13 = "#c396d7";
        color6 = "#70c0b1";
        color14 = "#70c0b1";
        color7 = "#fffefe";
        color15 = "#fffefe";

        # Tab Bar Colors
        active_tab_foreground = "#eeeeee";
        active_tab_background = "#424242";
        inactive_tab_foreground = "#e9e9e9";
        inactive_tab_background = "#000000";
      };
    };
  };
}
