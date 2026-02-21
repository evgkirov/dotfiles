{
  description = "Example nix-darwin system flake";

  inputs = {
    # TODO: Migrate from unstable to 26.05 once it is released.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            vim
            nixfmt
            nil
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          nix.package = pkgs.lix;

          system.primaryUser = "evgkirov";

          security.pam.services.sudo_local.touchIdAuth = true;

          # TODO: power.*

          system.defaults = {
            NSGlobalDomain = {
              # _HIHideMenuBar = true;
              AppleFontSmoothing = 0;
              ApplePressAndHoldEnabled = false;
              AppleShowAllExtensions = true;
              InitialKeyRepeat = 20;
              KeyRepeat = 2;
              NSAutomaticCapitalizationEnabled = false;
              NSAutomaticDashSubstitutionEnabled = false;
              NSAutomaticPeriodSubstitutionEnabled = false;
              NSAutomaticQuoteSubstitutionEnabled = false;
              NSAutomaticSpellingCorrectionEnabled = false;
              NSNavPanelExpandedStateForSaveMode = true;
              NSNavPanelExpandedStateForSaveMode2 = true;
            };
            dock = {
              # TODO: persistent-apps
              autohide = true;
              mineffect = "scale";
              minimize-to-application = true;
              mru-spaces = false;
              show-recents = false;
            };
            finder = {
              FXDefaultSearchScope = "SCcf";
              FXPreferredViewStyle = "clmv";
              FXRemoveOldTrashItems = true;
              NewWindowTarget = "Home";
            };
            screencapture = {
              location = "~/Library/Mobile Documents/com~apple~CloudDocs/Screen Shots/";
            };
          };

        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#mac
      darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };

}
