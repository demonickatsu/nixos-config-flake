{
  description = "A NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    # nixos-extensions.url = "github:nixos/nixos-extensions";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux"; # Change this to your target system architecture
    in {
      nixosConfigurations = {
        katsuSystem = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix
            # /etc/nixos/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.katsu = {
                home.stateVersion = "24.11";
                home.packages = [ /* list packages here */ ];
                programs.rofi.theme = "./rofi/nord.rasi";

                # Ensure ~/Backgrounds exists and add image
                home.file."Backgrounds/nordnix1.png".source = ./assets/nordnix1.png;

                # Place autostart.sh in ~ and make it executable
                home.file.".scripts/autostart.sh".source = ./assets/autostart.sh;
                # home.file.".scripts/autostart.sh".permissions = "0755";
              };
            }
          ];
          # Optional: define other options like systemPackages, etc.
        };
      };
    };
}
