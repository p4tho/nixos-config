# nixos-config

This is the NixOS configuration I use to develop my projects.

## Development Flakes
I just use flakes from the community to initialize flakes for my projects.

To start a Rust project I would run `nix flake init -t github:the-nix-way/dev-templates#rust`, and then configure it to my liking.

## Install
1) Modify hardware.nix to match your system's settings.
```
nixos-generate-config --show-hardware-config
git add .
```
Replace settings found in the current hardware.nix with the configuration you get from the command and save it to your local git repository.

2) Install everything the system needs.
```
sudo nixos-rebuild switch --flake .#main
```
