# betterlockscreen
*A simple lock script for i3lock*

Most of i3lock script out there converts your defined image to add blur, glitch or dim effect to image and it feels so slow and btw who needs dynamic lock background,
its not like I change lockscreen background every 5 minutes.
I wanted something that was fast and still should have all the effects I want for lockscreen background.

This script generates or already caches the variant for your custom images before hand so they can be later used any number of time as lockscreen background,
without the need to apply same effect again and again

## Screenshots

![scrot1](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot1.png "scrot1.png")

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png "scrot2.png")

## In action

* [Demonstration](https://www.youtube.com/watch?v=9Ng5FZwnn6M&feature=youtu.be) - youtube.com

## Table of Contents

- **[Requirements](#requirements)**
    - [Dependencies](#dependencies)
- **[Installation](#installation)**
    - [Manual/Git install](#manualgit-install)
    - [OS/Distro Packages](#osdistro-packages)
        - [Arch Linux](#arch-linux)
        - [Debian and derivatives](#debian-and-derivatives)
- **[Usage](#usage)**
- **[Desktop Background](#set-desktop-background-on-startup)**
- **[i3wm keybinding](#i3wm-keybinding-for-lockscreen)**
- **[Lockscreen whenever suspended](#lockscreen-when-suspendedsystemd-service)**


## Requirements

### Dependencies

- [i3lock-color](https://github.com/PandorasFox/i3lock-color)
	- i3lock fork with additional features( >= 2.11-c )
- [imagemagick](https://www.imagemagick.org/script/index.php)
	- To apply effects to images
- [xdpyinfo](https://www.x.org/archive/X11R7.7/doc/man/man1/xdpyinfo.1.xhtml), [xrandr](https://www.x.org/wiki/Projects/XRandR/), [bc](https://www.gnu.org/software/bc/) and [feh](https://feh.finalrewind.org/)
	- To find screen resolution, set custom blur level and wallpaper handling.

Note: Make sure all dependencies are satisfied beforehand.

## Installation

### Manual/Git install

```sh
git clone https://github.com/pavanjadhaw/betterlockscreen 
cd betterlockscreen
cp betterlockscreen ~/.local/bin

# or wget the script ~12KB
wget -O betterlockscreen https://git.io/fASUJ
chmod u+x betterlockscreen
cp betterlockscreen ~/.local/bin

# Add betterlockscreen to PATH:
# (In your .bashrc, .zshrc etc)
export PATH="${PATH}:${HOME}/.local/bin/"
```


### OS/Distro Packages


#### Arch Linux

###### Installing dependencies(not required if using betterlockscreen aur package)
`pacman -S imagemagick feh xorg-xrandr xorg-xdpyinfo`
- i3lock-color
	- `trizen -S i3lock-color`

#### Aur package

`betterlockscreen` is available in the Arch User repos as `betterlockscreen` and `betterlockscreen-git`.
- betterlockscreen
	- `trizen -S betterlockscreen`
- betterlockscreen-git
	- `trizen -S betterlockscreen-git`


#### Debian and derivatives

UtkarshVerma was so kind to provide an installation script for debian based systems, ![check it out here](https://github.com/UtkarshVerma/installer-scripts).



## Usage

Run `betterlockscreen` and point it to either a directory (`betterlockscreen -u "path/to/dir"`) or an image (`betterlockscreen -u "/path/to/img.jpg"`) and that's all. `betterlockscreen` will change update its cache with image you provided.

```sh
usage: betterlockscreen [-u "path/to/img.jpg"] [-l "dim, blur or dimblur"]
           [-w "dim, blur, or dimblur"] [-t "custom text"] [-s "lockscreen and suspend"]
					 [-r "resolution"] [-b "factor"]

betterlockscreen - faster and sweet looking lockscreen for linux systems.

required:
	-u, --update "path/to/img.jpg"	caches all required images

usage:
	-l, --lock effect-name
			locks with provided effect
	-w, --wall effect-name
			set desktop background with provided effect
	-s, --suspend effect-name
			lockscreen and suspend

			Available effects:
				dim, blur or dimblur

	-t, --text "custom text"
			set custom lockscreen text
	-b, blur 0.0 - 1.0
			set blur range
	-r, --resolution res
			uses a custom resolution


Usage examples:
1. Updating image cache(required)
betterlockscreen -u ~/Pictures/Forests.png # caches given image
betterlockscreen -u ~/Pictures             # caches random image from ~/Pictures directory

2. Custom resolution and blur range
betterlockscreen -u path/to/directory -r 1920x1080 -b 0.5

3. Lockscreen
betterlockscreen -l dim                    # lockscreen with dim effect

4. Lockscreen with custom text
betterlockscreen -l dim -t "custom lockscreen text"

5. Set desktop background
betterlockscreen -w blur                   # set desktop background with blur effect
```


## Set desktop background on startup

Add this line to `.xinitrc`.

```sh
# set desktop background with custom effect
betterlockscreen -w dim

# Alternative (set last used background)
source ~/.fehbg
```


#### i3wm

Add this line to `~/.config/i3/config`

```sh
# set desktop background with custom effect
exec --no-startup-id betterlockscreen -w dim

# Alternative (set last used background)
exec --no-startup-id source ~/.fehbg
```


#### i3wm keybinding for lockscreen

Add this line to your `~/.config/i3/config`

```sh
bindsym $mod+shift+x exec betterlockscreen --l dim
```


## Lockscreen when suspended(systemd service)

```sh
# move service file to proper dir (the aur package does this for you)
cp betterlockscreen@.service /etc/systemd/system/

# enable systemd service
systemctl enable betterlockscreen@$USER

# disable systemd service
systemctl disable betterlockscreen@$USER


# Note: Now you can call systemctl suspend to suspend your system
# and betterlockscreen service will be activated
# so when your system wakes your screen will be locked.
```


---

## Feel free to use and distribute

This is my first bash script so if you think this could be improved or if you have any suggestion. Feel free.

* Hat tip to anyone who's code was used
* Thanks to those who contributed to make it better
* Inspiration - r/unixporn
