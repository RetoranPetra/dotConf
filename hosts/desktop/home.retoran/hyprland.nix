{ ... }: {
	imports = [
		./../../../modules/home.retoran/hyprland
	];
	wayland.windowManager.hyprland = {
		primaryMonitor = "DP-1";
		settings = {
      "monitor" = [ "DP-1,2560x1440@180,0x0,1" "DP-2,2560x1440@120,-1440x0,1,transform,1" ",preferred,auto,auto" ];
		};
	};
}
