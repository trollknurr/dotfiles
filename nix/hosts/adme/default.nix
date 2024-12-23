{ pkgs, ... }:
{
  system.stateVersion = 5;
  system.configurationRevision = null;

  users.users."anton.shtarev" = {
    home = "/Users/anton.shtarev";
  };
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."anton.shtarev" = { pkgs, ... }: {
    home.stateVersion = "24.05";
    let 
      project_root = builtins.getEnv "PWD";
    in 
      home.file."wezterm.lua" = {
        source = project_root / "dotfiles/wezterm.lua";
      };

    programs.home-manager.enable = true;
    programs.wezterm = {
        enable = true;
    };
  };
    

}