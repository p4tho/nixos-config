{ self, inputs, ... }: {
  flake.nixosModules.mainConfiguration = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.mainHardware

      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.docker
      self.nixosModules.niri
      self.nixosModules.thunar
      self.nixosModules.virt-manager
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    networking.hostName = "nixos";

    time.timeZone = "America/Los_Angeles";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Boot
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Graphics
    hardware.graphics.enable = true;

    programs.xwayland.enable = true;

    security.polkit.enable = true;

    services.xserver.enable = false;
    services.dbus.enable = true;

    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd '${config.programs.niri.package}/bin/niri-session'";
          user = "greeter";
        };
      };
    };

    # User
    users.users."user" = {
      isNormalUser = true;
      description = "user";
      extraGroups = [ "docker" "libvirtd" "networkmanager" "video" "wheel" ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit inputs self; };

      users."user" = {
        imports = [
          self.homeModules.kitty
          self.homeModules.remmina
          self.homeModules.zed
        ];

        home.stateVersion = "26.05";
      };
    };

    # Audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # Packages
    environment.systemPackages = with pkgs; [
      brightnessctl

      brave
      librewolf

      git

      htop
    ];

    system.stateVersion = "26.05";
  };
}
