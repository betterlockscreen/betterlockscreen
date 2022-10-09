{
	pkgs ? import /run/nixpkgs {},
	lib ? pkgs.lib,
	...
}:

with lib;

pkgs.mkShell {
	buildInputs = with pkgs; [ bash bc coreutils i3lock-color gawk gnugrep gnused imagemagick procps shellcheck xorg.xdpyinfo xorg.xrandr xorg.xset ];
	shellHooks = ''
		alias bash5="${pkgs.bash}/bin/bash"
		alias i3lock="i3lock-color"
	'';
}
