{ pkgs, rootPath, ... }:
{
  system.stateVersion = 5;
  system.configurationRevision = null;

  users.users."a.shtarev" = {
    home = "/Users/a.shtarev";
  };
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."a.shtarev" = { pkgs, rootPath, ... }:
  {
    home.stateVersion = "24.05";

    xdg.configFile."wezterm/wezterm.lua".source = rootPath + /dotfiles/wezterm.lua;

    programs.home-manager.enable = true;
    programs.wezterm = {
        enable = true;
    };
  };
    

}