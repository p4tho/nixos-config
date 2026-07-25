{ ... }: {
  flake.nixosModules.virt-manager = { pkgs, lib, ... }: {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };

    # Override qemu_full to disable the broken ceph dependency
    environment.systemPackages = with pkgs; [
      (qemu_full.override { cephSupport = false; })
    ];
  };
}
