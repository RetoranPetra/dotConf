{ config, lib, pkgs, ... }:
{
	imports = [ <home-manager/nixos> ];
	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
	home-manager.users.retoran = { pkgs, ... }: {
		# Relies on git
		programs.git.enable = true;
		programs.git.extraConfig.core.editor = "nvim";
		# Relies on lazygit
		programs.lazygit.enable = true;

		# Configuration
    xdg.configFile."nvim".source = /etc/nixos/home.retoran/home/retoran/.config/nvim;

		# Dependencies
		home.packages = with pkgs; [
			python3
			nodejs
			llvmPackages_latest.clang
			llvmPackages_latest.libcxx
			llvmPackages_latest.libllvm
			llvmPackages_latest.lldb
			unzip
			go
			cmake
			gnumake
			fzf
			lazygit
			ripgrep
		];
	};
}
