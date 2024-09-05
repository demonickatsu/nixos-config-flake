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
                # home.packages = [ /* list packages here */ ];
                programs.rofi = {
                  enable = true;
                  theme = "~/.scripts/rofi/nord.rasi";
                  };
                programs.kitty = {
                  enable = true;
                  settings = {
                    # Disable closing confirmation prompt
                    allow_remote_control no

                    background_opacity 0.75

                    font_family JetBrains Mono Nerd Font
                    font_size 11.0
                    hinting none

                    # Nord color scheme
                    color0  #3B4252
                    color1  #BF616A
                    color2  #A3BE8C
                    color3  #EBCB8B
                    color4  #81A1C1
                    color5  #B48EAD
                    color6  #88C0D0
                    color7  #E5E9F0
                    color8  #4C566A
                    color9  #BF616A
                    color10 #A3BE8C
                    color11 #EBCB8B
                    color12 #81A1C1
                    color13 #B48EAD
                    color14 #8FBCBB
                    color15 #ECEFF4
                    background #2E3440
                    foreground #D8DEE9
                    selection_background #4C566A
                    selection_foreground #ECEFF4
                    cursor #D8DEE9
                  };
                # Ensure ~/Backgrounds exists and add image
                home.file."Backgrounds/nordnix1.png".source = ./assets/nordnix1.png;
                home.file.".scripts/nord.rasi".source = ./rofi/nord.rasi;
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
