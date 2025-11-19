#!/usr/bin/env bash

getout() {
	echof error "installation cancelled. Exiting...."
	sleep 1
	exit 1
}

auto_install() {
	read -r -p "would you like to install ${DEPS[$key]} (y/n) : " value_auto_install
	bool_install=${value_auto_install,,}
	while [ "$bool_install" != "n" ]
	do
		echo "$bool_install"
		if [ "$bool_install" == "y" ]; then
			check_os
			if [ "$install" == "null" ]; then
			    echof error "Can't detect installation type!, exiting..."
				exit 1
			fi
			sudo "${install[@]}" "${DEPS[$key]}"
			break
		elif [ "$bool_install" == "n" ]; then
			echo "$bool_install"
			getout
		elif [ "$bool_install" != "y" ] && [ "$bool_install" != "n" ]; then
			echof error "Not a valid input"
			read -r -p "Please enter a valid input (y/n) : " value_auto_install
			bool_install=${value_auto_install,,}

		fi
	done
	if [ "$bool_install" == n ]; then
		getout
	fi
}
check_os() {
	os_name="null"
	install=(null)
	if [ -s /etc/os-release ]; then #modern device only, older is in development
		echof act "checking os type...."
		sleep .7
		echof info "found os type file. Reading..."
		sleep .7
		if ! [[ $(grep -c "arch" /etc/os-release) -eq 0 ]]; then 
			os_name="arch"
			install=(pacman -S --noconfirm)
		elif ! [[ $(grep -c "debian" /etc/os-release) -eq 0 ]]; then
			os_name="debian"
			install=(apt install)
		elif ! [[ $(grep -c "fedora" /etc/os-release) -eq 0 ]]; then
			os_name="fedora"
			install=(dnf install)
		elif ! [[ $(grep -c "nix" /etc/os-release) -eq 0 ]]; then
			os_name="nix-os"
			install=(nix-env -iA nixos.)
		elif ! [[ $(grep -c "gentoo" /etc/os-release) -eq 0 ]]; then
			os_name="gentoo"
			install=(emerge)
		elif ! [[ $(grep -c "void" /etc/os-release) -eq 0 ]]; then
			os_name="void"
			install=(xbps-install)
		else
			echof error "can't detect os-type, this disabled the auto install of packages"
			getout
		fi
		echof info "Detected os type is : $os_name"
		echof info "installing packages using ${install[*]}"
		sleep 1
	else
		echof error "can't detect os-type"
	fi

}

cmd_exists () {
    command -v "$1" >/dev/null
}

echof() {
    local colorReset="\033[0m"
    local prefix="$1"
    local message="$2"

    case "$prefix" in
        header) msgpfx="[\e[1;95mB\e[m]" color="";;
        info) msgpfx="[\e[1;97m=\e[m]" color="\033[0;34m";;
        act) msgpfx="[\e[1;92m*\e[m]" color="";;
        ok) msgpfx="[\e[1;93m+\e[m]" color="\033[0;32m";;
        error) msgpfx="[\e[1;91m!\e[m]" color="\033[0;31m";;
        *) msgpfx="" color="";;
    esac
    echo -e "$msgpfx $color $message $colorReset"
}

case $1 in
	system)
		BL_INSTALL_DIR="/usr/local/bin"
	;;

	user)
		BL_INSTALL_DIR="$HOME/.local/bin"

		if [[ ! -d $BL_INSTALL_DIR ]]; then
			mkdir -p "$BL_INSTALL_DIR"
		fi
	;;

	*)
		echo "Usage: $0 <install-mode> [<version>] [<systemd-service>]"
		echo "  <install-mode>: (string) 'user' installs to '~/.local/bin/', 'system' installs to '/usr/local/bin'"
		echo "  <version>: (string) defaults to 'latest' which will determinate the latest tag from git or specified branch/tag"
		echo "  <systemd-service>: (boolean) defaults to 'false' - Whether to copy and enable system-service"
		echo -e "\nPlease note: The order of the parameters *is* relevant, if you want to set '<system-service>' you need to specify '<version>' as well!"
		exit 1
	;;
esac

echof header "Welcome To Betterlockscreen Setup"

if [[ ! -w $BL_INSTALL_DIR ]]; then
	echof error "Error : Unable to write to '$BL_INSTALL_DIR', Please re-run with sudo command !"
	exit 1
fi

echof info "Checking system-requirements..."

declare -A DEPS
DEPS["ImageMagick"]="convert"
DEPS["i3lock-color"]="i3lock-color"
DEPS["xdpyinfo"]="xdpyinfo"
DEPS["xrdb"]="xrdb"
DEPS["xset"]="xset"

if ! cmd_exists DEPS["i3lock-color"] && cmd_exists "i3lock"; then
	DEPS["i3lock-color"]="i3lock"
fi

for key in "${!DEPS[@]}"; do
	[[ ! -e $(command -v "${DEPS[$key]}") ]] && echof error "Missing '$key' under binary named '${DEPS[$key]}'!" && auto_install
done

echof ok "done!"
sleep 1.5
BLI_TEMP_DIR=$(mktemp -d)
CUR_DIR="$(pwd)/."
echof info "copying file to temporary folder $BLI_TEMP_DIR from $CUR_DIR"
sleep 2

cp -a -R "$CUR_DIR" "$BLI_TEMP_DIR"
cd "$BLI_TEMP_DIR" || exit 1
echof ok "done!"
sleep 1
VERSION=$2
if [[ $VERSION == "" ]] || [[ $VERSION == "latest" ]]; then
	echof info "Checking latest release... "
	VERSION=$(git describe --tags "$(git rev-list --tags --max-count=1)")
	echof ok "done! ($VERSION)"
fi

git checkout "$VERSION" &>/dev/null

echof info "Installing Betterlockscreen to '$BL_INSTALL_DIR'... "
cp betterlockscreen "$BL_INSTALL_DIR"
echof ok "done!"

if [[ $3 == "true" ]]; then
	SYSTEMD_SERVICE_DIR="/usr/lib/systemd/system"

	echof info "Installing/enable sytemd-service... "

	if [[ ! -w $SYSTEMD_SERVICE_DIR ]]; then
		echof error "\nUnable to write to '$SYSTEMD_SERVICE_DIR'!"
		exit 1
	fi

	cp system/betterlockscreen@.service $SYSTEMD_SERVICE_DIR
	systemctl enable betterlockscreen@"$USER"

	echof ok "done!"
fi

if [[ $PATH != *"$BL_INSTALL_DIR"*  ]]; then
	echof error "Please ensure to add 'export PATH=\"\$PATH:/home/\$USER/.local/bin\"' to your shell-config!\033[0m"
fi

echof ok "Install completed successfully!"
exit 0
