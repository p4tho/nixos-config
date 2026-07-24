{ self, inputs, ... }: {
  flake.nixosModules.virt-manager = { pkgs, lib, ... }: {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
