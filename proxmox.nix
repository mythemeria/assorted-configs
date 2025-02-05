{ config, pkgs, modulesPath, lib, system, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  config = {
    #Provide a default hostname
    networking.hostName = lib.mkDefault "nixos";

    # Enable QEMU Guest for Proxmox
    services.qemuGuest.enable = lib.mkDefault true;

    # Use the boot drive for grub
    boot.loader.grub.enable = lib.mkDefault true;
    boot.loader.grub.devices = [ "nodev" ];

    boot.growPartition = lib.mkDefault true;

    # Allow remote updates with flakes and non-root users
    nix.settings.trusted-users = [ "root" "@wheel" ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable mDNS for `hostname.local` addresses
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.publish = {
      enable = true;
      addresses = true;
    };

    # Some sane packages we need on every system
    environment.systemPackages = with pkgs; [
      git
      python3
    ];

    # Enable ssh
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
    programs.ssh.startAgent = true;

    # Add an admin user
    users.users.izi = {
      isNormalUser = true;
      description = "real human bean";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Must change to use unique key!!!
    users.users.izi.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHNHZwrNtuYjLqsjY5ZgftBb6CtBz5f56+w157rxINl izi@infinite"
    ];

    # Default filesystem
    fileSystems."/" = lib.mkDefault {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };

    system.stateVersion = lib.mkDefault "24.05";
  };
}