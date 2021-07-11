# Betterlockscreen
> fast and sweet looking lockscreen for linux systems with effects!

<div align="center">
  <a href="https://github.com/pavanjadhaw/betterlockscreen/releases"><img alt="GitHub release (latest by date including pre-releases)" src="https://img.shields.io/github/v/release/pavanjadhaw/betterlockscreen?include_prereleases&label=latest&style=for-the-badge"></a>
  <a href="https://github.com/pavanjadhaw/betterlockscreen/releases"><img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/pavanjadhaw/betterlockscreen?label=Stable&style=for-the-badge"></a>
  <a href="https://github.com/pavanjadhaw/betterlockscreen/actions/workflows/main.yml?query=branch%3Amaster"><img alt="GitHub Workflow Status (master)" src="https://img.shields.io/github/workflow/status/pavanjadhaw/betterlockscreen/Main/master?label=master&style=for-the-badge"></a>
  <a href="https://github.com/pavanjadhaw/betterlockscreen/actions/workflows/main.yml?query=branch%3Anext"><img alt="GitHub Workflow Status (next)" src="https://img.shields.io/github/workflow/status/pavanjadhaw/betterlockscreen/Main/next?label=next&style=for-the-badge"></a>
  <a href="https://github.com/pavanjadhaw/betterlockscreen/blob/master/LICENSE"><img src="https://img.shields.io/github/license/pavanjadhaw/betterlockscreen.svg?style=for-the-badge"></a>
</div>

<div align="center">
  <h2>You want to support us?</h2>

  <a href="https://github.com/pavanjadhaw/betterlockscreen/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/pavanjadhaw/betterlockscreen?style=social"></a>
  <a href="https://github.com/pavanjadhaw/betterlockscreen/fork"><img alt="GitHub forks" src="https://img.shields.io/github/forks/pavanjadhaw/betterlockscreen?style=social"></a>
  <a href="https://www.codetriage.com/pavanjadhaw/betterlockscreen"><img src="https://www.codetriage.com/pavanjadhaw/betterlockscreen/badges/users.svg"></a>
</div>
<br />

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png 'scrot2.png')
<br />

## Table of Contents

- [about](#about)
- [how it works](#how-it-works)
- [requirements](#requirements)
- [installation](#installation)
- [configuration](#configuration)
- [usage](#usage)
- [background](#set-desktop-background-on-startup)
- [keybinding](#keybindings)
- [lockscreen on suspend](#lockscreen-when-suspendedsystemd-service)

### About

Most of i3lock wrapper scripts out there takes an image, adds some effect and locks the screen
adding effects, overall experience doesn't feel natural given delay of 2-3 seconds.
Who would like a delay of 2-3 seconds while locking screen?

So betterlockscreen was my attempt to solve this problem, as we dont need to change lockscreen background frequently
this script caches images with effect so overall experience is simple and as fast as native i3lock.

### How it works

The script takes image adds various effects and caches those images in special directory and then uses those
images as lockscreen background depending on argument provided by user.

### Requirements

> Note: Make sure your system has all dependencies satisfied

- [i3lock-color](https://github.com/Raymo111/i3lock-color) - i3lock fork with additional features(`>= 2.13.c.3`)
- [imagemagick](https://www.imagemagick.org/script/index.php) - To apply effects to images
- [xdpyinfo](https://www.x.org/archive/X11R7.7/doc/man/man1/xdpyinfo.1.xhtml), [xrandr](https://www.x.org/wiki/Projects/XRandR/), [bc](https://www.gnu.org/software/bc/) and [feh](https://feh.finalrewind.org/) - To find screen resolution, set custom blur level and wallpaper handling.

### Installation

> manual installation

```sh
git clone https://github.com/pavanjadhaw/betterlockscreen
cd betterlockscreen
cp betterlockscreen ~/.local/bin/
```

<p style="text-align: center">OR</p>

```sh
# or wget the script ~12KB
wget -O betterlockscreen https://git.io/fASUJ
chmod u+x betterlockscreen
cp betterlockscreen ~/.local/bin/
```

```sh
# Add betterlockscreen to PATH:
# (In your .bashrc, .zshrc etc)
export PATH="${PATH}:${HOME}/.local/bin/"
```

### Package Manager

#### Arch Linux

###### Installing dependencies(not required if using betterlockscreen aur package)

`pacman -S imagemagick feh xorg-xrandr xorg-xdpyinfo`

- i3lock-color - `trizen -S i3lock-color`

#### Aur package

`betterlockscreen` is available in the Arch User repos as `betterlockscreen` and `betterlockscreen-git`.

- betterlockscreen - `trizen -S betterlockscreen`
- betterlockscreen-git - `trizen -S betterlockscreen-git`

#### Debian and derivatives

UtkarshVerma was so kind to provide an installation script for debian based systems, ![check it out here](https://github.com/UtkarshVerma/installer-scripts).

#### Void Linux

##### xbps repository

`betterlockscreen` is available in official Void's repository as `betterlockscreen`.

Installing using `xbps` (will automatically install all required dependencies): `xbps-install -S betterlockscreen`

#### Gentoo Linux

##### GURU

Install `betterlockscreen` from Gentoo's [GURU overlay](https://wiki.gentoo.org/wiki/Project:GURU):

If not already, enable (e.g. with app-eselect/eselect-repository) and sync (with emaint) GURU
```sh
eselect repository enable guru
emaint sync -r guru
```

then install
```sh
emerge x11-misc/betterlockscreen
```

### Configuration

You can customise various colors for betterlockscreen, copy config file from examples directory to `~/.config/betterlockscreenrc` and edit it accordingly.

If configuration file is not found then default configurations will be used.

If you have installed betterlockscreen from AUR package, then you can copy default config from docs

```sh
cp /usr/share/doc/betterlockscreen/examples/betterlockscreenrc ~/.config
```

### Usage

Run `betterlockscreen` and point it to either a directory (`betterlockscreen -u "path/to/dir"`) or an image (`betterlockscreen -u "/path/to/img.jpg"`) and that's all. `betterlockscreen` will change update its cache with image you provided.

```sh
usage: betterlockscreen [-u "path/to/img.jpg"] [-l "dim, blur or dimblur"]
           [-w "dim, blur, pixel or dimblur"] [-t "custom text"] [-s "lockscreen and suspend"]
					 [-r "resolution"] [-b "factor"] [--off <timeout>]

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
				dim, blur, pixel or dimblur

	-t, --text "custom text"
			set custom lockscreen text
	-b, blur 0.0 - 1.0
			set blur range
	-r, --resolution res
			uses a custom resolution
	--off, --off <timeout>
			sets custom monitor timeout (<timeout> in seconds)


Usage examples:
1. Updating image cache(required)
betterlockscreen -u ~/Pictures/Forests.png # caches given image
betterlockscreen -u ~/Pictures             # caches random image from ~/Pictures directory

2. Custom resolution and blur range
betterlockscreen -u path/to/directory -r 1920x1080 -b 0.5

3. Lockscreen
betterlockscreen -l dim                    # lockscreen with dim effect

4. Lockscreen with custom text
betterlockscreen -l pixel -t "custom lockscreen text"

5. Set desktop background
betterlockscreen -w blur                   # set desktop background with blur effect

6. Lockscreeen with custom monitor off timeout
betterlockscreen --off 5 -l blur           # set monitor off lockscreen timeout (5 seconds)
```

### Set desktop background on startup

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

### Keybindings

To lockscreen using keyboard shortcut

#### i3wm

Add this line to your `~/.config/i3/config`

```sh
bindsym $mod+shift+x exec betterlockscreen -l dim
```

#### bspwm

Add this line to your `~/.config/sxhkd/sxhkdrc`

```sh
# lockscreen
alt + shift + x
    betterlockscreen -l dim
```

### Lockscreen when suspended(systemd service)
```sh
# move service file to proper dir (the aur package does this for you)
cp betterlockscreen@.service /usr/lib/systemd/system/

# enable systemd service
systemctl enable betterlockscreen@$USER

# disable systemd service
systemctl disable betterlockscreen@$USER

# Note: Now you can call systemctl suspend to suspend your system
# and betterlockscreen service will be activated
# so when your system wakes your screen will be locked.
```

**Hint:** The systemd-unit expects betterlockscreen to be installed in "/usr/local/bin", so maybe you want to check or change this!

Resources and more informations:
 * https://gist.github.com/Raymo111/91ffd256b7aca6a85e8a99d6331d3b7b
 * https://github.com/Raymo111/i3lock-color/issues/174#issuecomment-687149213

---

### Countributing

Thanks to all the amazing people for all your wonderful PRs, issues and ideas!

[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/0)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/0)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/1)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/1)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/2)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/2)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/3)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/3)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/4)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/4)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/5)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/5)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/6)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/6)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/7)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/7)

## How can I support developers?

- Star our GitHub repo :star:
- Create pull requests, submit bugs, suggest new features or documentation updates :wrench:

## License

Betterlockscreen is under [MIT](https://github.com/pavanjadhaw/betterlockscreen/blob/master/LICENSE) license.

## Feel free to use and distribute

- Hat tip to anyone who's code was used
- Thanks to those who contributed to make it better
- Inspiration - [r/unixporn](https://www.reddit.com/r/unixporn)

[logo]: .github/hero.png
[website]: https://mdxjs.com
