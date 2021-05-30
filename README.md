# betterlockscreen

> simple, minimal lockscreen

Betterlockscreen allows you to cache images with different filters and lockscreen with blazing speed.

## Example

> lockscreen with blurred effect

```sh
betterlockscreen --lock blur
```

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png 'scrot2.png')

> [Watch some of the features of betterlockscreen in action](https://youtu.be/9Ng5FZwnn6M)

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

### Configuration

You can customise various colors for betterlockscreen, copy config file from examples directory to `~/.config/betterlockscreenrc` and edit it accordingly.

If configuration file is not found then default configurations will be used.

```ini
# default options
display_on=0
span_image=false
lock_timeout=300
fx_list=(dim blur dimblur pixel dimpixel color)
dim_level=40
blur_level=1
pixel_scale=10,1000
solid_color=333333

# theme options
loginbox=00000066
loginshadow=00000000
locktext="Type password to unlock..."
font="sans-serif"
ringcolor=ffffffff
insidecolor=00000000
separatorcolor=00000000
ringvercolor=ffffffff
insidevercolor=00000000
ringwrongcolor=ffffffff
insidewrongcolor=d23c3dff
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
verifcolor=ffffffff
timecolor=ffffffff
datecolor=ffffffff
wallpaper_cmd="feh --bg-fill --no-fehbg"
time_format="%H:%M:%S"
```
If you have installed betterlockscreen from AUR package, then you can copy default config from docs

```sh
cp /usr/share/doc/betterlockscreen/examples/betterlockscreenrc ~/.config
```

### Usage

Run `betterlockscreen` and point it to either a directory (`betterlockscreen -u "path/to/dir"`) or an image (`betterlockscreen -u "/path/to/img.jpg"`) and that's all. `betterlockscreen` will change update its cache with image you provided.

```sh
Usage: betterlockscreen [-u <PATH>] [-l <EFFECT>] [-w <EFFECT>]

  -u --update <PATH>
      Update lock screen image

  -l --lock <EFFECT>
      Lock screen with cached image

  -w --wall <EFFECT>
      Set wallpaper with cached image

Additional arguments:

  --display <N>
      Set display to draw loginbox

  --span
      Scale image to span multiple displays

  --off <N>
      Turn display off after N minutes

  --fx <EFFECT,EFFECT,EFFECT>
      List of effects to apply

  -- <ARGS>
      Pass following arguments to i3lock

Effects arguments:

  --dim <N>
      Dim image N percent (0-100)

  --blur <N>
      Blur image N amount (0.0-1.0)

  --pixel <N,N>
      Pixelate image with N shrink and N grow (unsupported)

  --color <HEX>
      Solid color background with HEX
```


#### Usage examples:
1. Update image cache with random image
`betterlockscreen -u ~/Wallpapers`

2. Update image cache with only dim and pixel effects
`betterlockscreen -u ~/Wallpapers/image.png --fx dim,pixel`

3. Update image cache with random image, multiple monitors, login on 1, spanning
`betterlockscreen -u ~/Wallpapers/Dual/ --display 1 --span`

4. Update image cache with solid background only (ignore errors)
`betterlockscreen -u . --fx color --color 5833ff`

5. Update image cache with different background images
`betterlockscreen -u ~/Wallpapers/image1.png -u ~/Wallpapers/image2.png`

6. Lock screen with blur effect
`betterlockscreen --lock blur`

7. Lock screen with multiple monitors, spanning
`betterlockscreen -l dimblur --display 1 --span`


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