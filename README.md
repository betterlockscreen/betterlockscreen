# multilockscreen

This is a fork of [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) with support for multiple monitors.

> simple, minimal lockscreen

Multilockscreen allows you to cache images with different filters and lockscreen with blazing speed.

## Example

> lockscreen with blurred effect

```sh
multilockscreen --lock blur
```

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png 'scrot2.png')

> [Watch some of the features of betterlockscreen in action](https://www.youtube.com/watch?v=9Ng5FZwnn6M&feature=youtu.be)

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

So multilockscreen was my attempt to solve this problem, as we dont need to change lockscreen background frequently
this script caches images with effect so overall experience is simple and as fast as native i3lock.

### How it works

The script takes image adds various effects and caches those images in special directory and then uses those
images as lockscreen background depending on argument provided by user.

### Requirements

> Note: Make sure your system has all dependencies satisfied

- [i3lock-color](https://github.com/PandorasFox/i3lock-color) - i3lock fork with additional features( >= 2.11-c )
- [imagemagick](https://www.imagemagick.org/script/index.php) - To apply effects to images
- [xdpyinfo](https://www.x.org/archive/X11R7.7/doc/man/man1/xdpyinfo.1.xhtml), [xrandr](https://www.x.org/wiki/Projects/XRandR/), [bc](https://www.gnu.org/software/bc/) and [feh](https://feh.finalrewind.org/) - To find screen resolution, set custom blur level and wallpaper handling.

### Installation

> manual installation

```sh
git clone https://github.com/jeffmhubbard/multilockscreen
cd multilockscreen
cp multilockscreen ~/.local/bin/
```

<p style="text-align: center">OR</p>

```sh
# or wget the script ~12KB
wget -O multilockscreen https://git.io/JeoAf
chmod u+x multilockscreen
cp multilockscreen ~/.local/bin/
```

```sh
# Add multilockscreen to PATH:
# (In your .bashrc, .zshrc etc)
export PATH="${PATH}:${HOME}/.local/bin/"
```

### Package Manager

#### Arch Linux

###### Installing dependencies(not required if using multilockscreen aur package)

`pacman -S imagemagick feh xorg-xrandr xorg-xdpyinfo`

- i3lock-color - `trizen -S i3lock-color`

#### Aur package

`multilockscreen` is available in the Arch User repos as `multilockscreen-git`.

- multilockscreen-git - `trizen -S multilockscreen-git`

### Configuration

You can customise various colors for multilockscreen, copy config file from examples directory to `~/.config/multilockscreenrc` and edit it accordingly.

If configuration file is not found then default configurations will be used.

If you have installed multilockscreen from AUR package, then you can copy default config from docs

```sh
cp /usr/share/doc/multilockscreen/examples/multilockscreenrc ~/.config
```

There are two new options for multi-monitor support:
  `display_on` controls which screen the indicator is displayed on (0 for all)
  `span_image` whether image should span multiple displays (true or false)

### Usage

Run `multilockscreen` and point it to either a directory (`multilockscreen -u "path/to/dir"`) or an image (`multilockscreen -u "/path/to/img.jpg"`) and that's all. `multilockscreen` will change update its cache with image you provided.

```sh
usage: multilockscreen [-u "path/to/img.jpg"] [-l "dim, blur, dimblur or pixel"]
						[-w "dim, blur, dimblur or pixel"] [-s "lockscreen and suspend"]
						[-t "custom text"] [-b "factor"] [--off <timeout>]
						[--display <0-9>] [--span]

multilockscreen - faster and sweet looking lockscreen for linux systems.

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
				dim, blur, dimblur or pixel

	-t, --text "custom text"
			set custom lockscreen text
	-b, blur 0.0 - 1.0
			set blur range
	-c, color <hex color> 
			set color for solid background
	--off, --off <timeout>
			sets custom monitor timeout (<timeout> in seconds)
	-d, --display 0-9
			screen to display loginbox (0 for all)
	--span
			span multiple screens


Usage examples:
1. Updating image cache(required)
multilockscreen -u ~/Pictures/Forests.png # caches given image
multilockscreen -u ~/Pictures             # caches random image from ~/Pictures directory

2. Custom blur range
multilockscreen -u path/to/directory -b 0.5

3. Lockscreen
multilockscreen -l dim                    # lockscreen with dim effect

4. Lockscreen with custom text
multilockscreen -l dim -t "custom lockscreen text"

5. Set desktop background
multilockscreen -w blur                   # set desktop background with blur effect

6. Lockscreen with custom monitor off timeout
multilockscreen --off 5 -l blur           # set monitor off lockscreen timeout (5 seconds)

7. Update image cache with login box on display 1
multilockscreen -u image.png -d 1         # cache images with loginbox on display 1
multilockscreen -u image.png -d 1 --span  # cache images that spans all displays

8. Lockscreen with login box on display 1
multilockscreen -l blur -d 1 --span       # lock screen with loginbox on display 1
```

### Set desktop background on startup

Add this line to `.xinitrc`.

```sh
# set desktop background with custom effect
multilockscreen -w dim

# Alternative (set last used background)
source ~/.fehbg
```

#### i3wm

Add this line to `~/.config/i3/config`

```sh
# set desktop background with custom effect
exec --no-startup-id multilockscreen -w dim

# Alternative (set last used background)
exec --no-startup-id source ~/.fehbg
```

### Keybindings

To lockscreen using keyboard shortcut

#### i3wm

Add this line to your `~/.config/i3/config`

```sh
bindsym $mod+shift+x exec multilockscreen -l dim
```

#### bspwm

Add this line to your `~/.config/sxhkd/sxhkdrc`

```sh
# lockscreen
alt + shift + x
    multilockscreen -l dim
```

### Lockscreen when suspended(systemd service)

```sh
# move service file to proper dir (the aur package does this for you)
cp multilockscreen@.service /etc/systemd/system/

# enable systemd service
systemctl enable multilockscreen@$USER

# disable systemd service
systemctl disable multilockscreen@$USER


# Note: Now you can call systemctl suspend to suspend your system
# and multilockscreen service will be activated
# so when your system wakes your screen will be locked.
```

---

### Countributing

Thanks to all the amazing people for all your wonderful PRs, issues and ideas!

[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/0)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/0)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/1)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/1)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/2)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/2)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/3)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/3)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/4)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/4)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/5)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/5)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/6)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/6)[![](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/images/7)](https://sourcerer.io/fame/pavanjadhaw/pavanjadhaw/betterlockscreen/links/7)

## How can I support developers?

- Star our GitHub repo :star:
- Create pull requests, submit bugs, suggest new features or documentation updates :wrench:

## License

multilockscreen is under [MIT](https://github.com/jeffmhubbard/multilockscreen/blob/multi-monitor/LICENSE) license.

## Feel free to use and distribute

- Hat tip to anyone who's code was used
- Thanks to those who contributed to make it better
- Inspiration - r/unixporn

