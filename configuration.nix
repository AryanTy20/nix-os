# Main NixOS Configuration File
# This file defines system-wide settings and the packages to be installed.
# For detailed guidance, refer to the NixOS manual and 'configuration.nix(5)' man page.

{ config, pkgs, ... }:

{
  ##################
  # System Bootloader
  ##################
  # Configures the bootloader (systemd-boot in this case) and EFI variables.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##################
  # Networking Configuration
  ##################
  # Define the system's hostname
  networking.hostName = "nixos";

  # Enable NetworkManager for managing networking connections
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary (uncomment and edit as required)
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ##################
  # Time and Localization Settings
  ##################
  # Set the system time zone
  time.timeZone = "Asia/Kolkata";

  # Localization settings to ensure UTF-8 encoding
  i18n.defaultLocale = "en_IN.UTF-8";  # Set default locale with UTF-8
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN.UTF-8";
    LC_IDENTIFICATION = "en_IN.UTF-8";
    LC_MEASUREMENT = "en_IN.UTF-8";
    LC_MONETARY = "en_IN.UTF-8";
    LC_NAME = "en_IN.UTF-8";
    LC_NUMERIC = "en_IN.UTF-8";
    LC_PAPER = "en_IN.UTF-8";
    LC_TELEPHONE = "en_IN.UTF-8";
    LC_TIME = "en_IN.UTF-8";
  };

  ##################
  # X11 and Desktop Environment
  ##################
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable GNOME Desktop Environment with the GDM display manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure the keymap for X11 (use the US layout)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  ##################
  # Printing and Sound Configuration
  ##################
  # Enable CUPS for printing services
  services.printing.enable = true;

  # Configure sound using PipeWire (disable PulseAudio)
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Enable JACK support if needed (uncomment to enable)
    # jack.enable = true;
  };

  ##################
  # User Configuration and System Packages
  ##################
  # Define user accounts and groups
  users.users.aryan = {
    isNormalUser = true;
    description = "aryan";
    extraGroups = [ "networkmanager" "wheel" ];  # Add to wheel for sudo privileges
    packages = with pkgs; [
      # Add more user-specific packages here
      # thunderbird
    ];
  };

  # Enable Firefox browser for all users
  programs.firefox.enable = true;

  # Install system-wide packages
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    btop
    neofetch
    vscode
  ];

  # Allow unfree packages (e.g., for Visual Studio Code)
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (pkgs.lib.getName pkg) [
      "vscode"
    ];

  ##################
  # Services Configuration
  ##################
  # Uncomment to enable OpenSSH for remote access
  # services.openssh.enable = true;

  # Open specific firewall ports if required (uncomment and configure as needed)
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  
  # Disable the firewall (not recommended unless necessary)
  # networking.firewall.enable = false;

  ##################
  # System Versioning
  ##################
  # Set the system state version (leave at the default for your NixOS version)
  system.stateVersion = "24.11";  # Ensure compatibility with your NixOS release

}
