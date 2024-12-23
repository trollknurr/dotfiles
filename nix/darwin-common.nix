{ config, pkgs, inputs, ... }: {
  
  programs.bash.enable = true;
  
  services.nix-daemon.enable = true;
  
  nix.settings.cores = 0; # use all cores
  nix.settings.max-jobs = 10; # use all cores
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  security.pam.enableSudoTouchIdAuth = true;
  
  homebrew = {
    onActivation = {
        upgrade = true;
        autoUpdate = true;
    };
    enable = true;
    casks = [
        "hammerspoon"
        "logseq"
        "iina"
        "wezterm"
        "itsycal"
    ];
  };

  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    dock.autohide = true;
    dock.expose-animation-duration = 0.05;
    finder.AppleShowAllExtensions = true;
    finder.FXEnableExtensionChangeWarning = false;
    loginwindow.GuestEnabled = false;
  };
  

  environment.variables = {
    EDITOR = "vim";
  };

  environment.systemPackages = [
    pkgs.vim
  ];

}