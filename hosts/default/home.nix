{ config, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "aryan";
  home.homeDirectory = "/home/aryan";
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  # Specify the packages to install
  home.packages = with pkgs; [
    git
    zoxide
    atuin
    fzf
    lf
    lsd
    zsh
    oh-my-posh
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
  ];



  # Manage dotfiles and Zsh configuration
  home.file = { };

  # Environment variables (if needed)
  home.sessionVariables = {
    # EDITOR = "emacs"; # Uncomment and set your preferred editor
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Enable Bash completion
  programs.bash.enableCompletion = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Aryan Tirkey";
    userEmail = "devty007@gmail.com";
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    
    # Aliases and other configurations
    shellAliases = {
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      ls = "lsd --color auto";
      bb = "cd ..";
      vs = "code . && exit 1";
      vsr = "code . -r";
      nb = "sudo nixos-rebuild switch";
      ez = "gedit ~/.zshrc";
      sz = "source ~/.zshrc";
    };
  };

  # Oh My Posh configuration
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "amro";
  };
}