#!/bin/bash
echo "hello wrold"
checkos() {
	echo "hi"
	local bold=$(tput bold)
	local normal=$(tput sgr0)
	local os_name="null"
	local os_file="etc/os-release"
	if [ -s /etc/os-release ]; then
		echo "${bold}hi${normal}"
		echo "found os type file"
		if ! ugrep -c -q "arch" $os_file; then
			os_name="arch"
		#elif grep -q '/kubepods' /proc/1/cgroup 2>/dev/null; then
		#	os_name="Kubernetes"
		#elif grep -q 'lxc' /proc/1/cgroup 2>/dev/null; then
		#	os_name="LXC"
		#elif grep -q 'VxID' /proc/self/status 2>/dev/null; then
		#	os_name="OpenVZ"""
		#elif grep -c 'arch' == 1; then
		echo "os type is ARCH!"
		fi
	fi
}
checkos
