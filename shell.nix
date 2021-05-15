{
	pkgs ? import /run/nixpkgs {},
	lib ? pkgs.lib,
	...
}:

with lib;

pkgs.mkShell {
	buildInputs = with pkgs; [ bc coreutils i3lock-color gawk gnugrep gnused imagemagick procps shellcheck xorg.xdpyinfo xorg.xrandr xorg.xset ];
	shellHooks = ''
		alias i3lock="i3lock-color"
	'';
}
