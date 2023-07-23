# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';

in

{
  #---JAVA-----
  programs.java.enable = true;

  #swaylock
  security.pam.services.swaylock = {};
  #keyring
  services.gnome.gnome-keyring.enable = true;
  #----DOCKER----------------
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "khang" ];
  #----BLUETOOTH--------------
  hardware.bluetooth.enable = true;
  systemd.tmpfiles.rules = [
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = ["systemd-tmpfiles-setup.service"];

  #----NVIDIA-----------------
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = [ "nvidia"];
  hardware.nvidia.forceFullCompositionPipeline = true;

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia.prime = {
    #offload = {
    # enable = true;
    # enableOffloadCmd = true;
    #};
    #offload.enable = true;
    reverseSync.enable = true;
    #sync.enable = true;

    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:6:0:0";
  };

  # security.pam.services.sddm.enableKwallet = true;

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce false;
        powerManagement.enable = lib.mkForce false;
      };
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
  #------------------------------ 
  programs.hyprland = {
   enable = true;
   xwayland.enable = true;
   nvidiaPatches = true;
  };
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  elisa
  gwenview
  okular
  oxygen
  khelpcenter
  konsole
  plasma-browser-integration
  print-manager
  kwallet
  kwallet-pam
  kwalletmanager
   xdg-desktop-portal-kde
];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-unikey
    ];
};


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.gdm.enable = true;

  services.xserver.displayManager.setupCommands = ''
    xrandr --output eDP --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DisplayPort-0 --off --output HDMI-1-0 --mode 1920x1080 --pos 0x0 --rotate normal
  '';
  # services.xserver.displayManager.gdm.enable = true;

  # services.xserver.displayManager.lightdm.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.sessionVariables = rec {
   WLR_NO_HARDWARE_CURSORS = "1";
   INPUT_METHOD = "fcitx";
   QT_IM_MODULE= "fcitx";
   GTK_IM_MODULE= "fcitx";
      XMODIFIERS="@im=fcitx";
      XIM_SERVERS="fcitx";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khang = {
    isNormalUser = true;
    description = "khang";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  fonts.fonts = with pkgs; [
   noto-fonts
   noto-fonts-cjk
   siji
   (nerdfonts.override { fonts = [ "JetBrainsMono"  ]; })
  ];



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
   chromium
   lsof
   arandr
   nvidia-offload
   vim
   insomnia
   neovim
   lazygit
   i3
   gnumake
   git
   kitty
   tmux
   stow
   zsh
   sheldon
   starship
   gcc
   rofi
   nodejs
   go
   python3
   rustc
   cargo
   ruby
   variety
   pokemon-colorscripts-mac   
   feh
   picom
   lf
   (polybar.override {
    alsaSupport = true;
    mpdSupport = true;
    pulseSupport = true;
   })
   flameshot
   bluetuith 
   mpd
   ncmpcpp
   cava
   ffmpeg
   mpc-cli
   awscli2
   azure-cli
   google-cloud-sdk
   mysql-workbench
   mongodb-compass
   vscode
   wofi
   wdisplays
   waybar
   swww
   grim
   slurp
   pulseaudio-ctl
   azure-functions-core-tools
   wl-clipboard
   bat
   swaylock
   swaylock-fancy
   swayidle
   killall
   deluged
   pipewire
   wireplumber
   xdg-desktop-portal-hyprland
   unrar
   docker-compose
   ripgrep
   unzip
    # support both 32- and 64-bit applications
    wineWowPackages.stable

    # support 32-bit only
    wine

    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
    warpd
   (lutris.override {
       extraPkgs = pkgs: [
         wineWowPackages.stable
         winetricks
       ];
   })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
