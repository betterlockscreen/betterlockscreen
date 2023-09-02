<img src="./logo.svg" height="200" alt="BLS-Logo" />

# Betterlockscreen
> fast and sweet looking lockscreen for linux systems with effects!

<div align="center">
  <a href="https://github.com/betterlockscreen/betterlockscreen/releases"><img alt="GitHub release (latest by date including pre-releases)" src="https://img.shields.io/github/v/release/betterlockscreen/betterlockscreen?include_prereleases&label=latest&style=for-the-badge"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/releases"><img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/betterlockscreen/betterlockscreen?label=Stable&style=for-the-badge"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/actions/workflows/main.yml?query=branch%3Amain"><img alt="GitHub Workflow Status (main)" src="https://img.shields.io/github/actions/workflow/status/betterlockscreen/betterlockscreen/main.yml?branch=main&label=main&style=for-the-badge"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/actions/workflows/main.yml?query=branch%3Anext"><img alt="GitHub Workflow Status (next)" src="https://img.shields.io/github/actions/workflow/status/betterlockscreen/betterlockscreen/main.yml?branch=next&label=next&style=for-the-badge"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/milestone/2"><img alt="GitHub milestone" src="https://img.shields.io/github/milestones/progress/betterlockscreen/betterlockscreen/2?style=for-the-badge"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/compare/v4.2.0...next"><img alt="GitHub commits since latest release (by date) for a branch" src="https://img.shields.io/github/commits-since/betterlockscreen/betterlockscreen/v4.2.0/next?style=for-the-badge"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/blob/main/LICENSE"><img src="https://img.shields.io/github/license/betterlockscreen/betterlockscreen.svg?style=for-the-badge"></a>
</div>

<div align="center">
  <h2>You want to support us?</h2>

  <div>
    <a href="https://github.com/betterlockscreen/betterlockscreen/discussions/366">We are searching a new Maintainer!</a>
  </div>

  <br />
  
  <a href="https://github.com/betterlockscreen/betterlockscreen/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/betterlockscreen/betterlockscreen?style=social"></a>
  <a href="https://github.com/betterlockscreen/betterlockscreen/fork"><img alt="GitHub forks" src="https://img.shields.io/github/forks/betterlockscreen/betterlockscreen?style=social"></a>
  <a href="https://www.codetriage.com/betterlockscreen/betterlockscreen"><img src="https://www.codetriage.com/betterlockscreen/betterlockscreen/badges/users.svg"></a>
</div>
<br />

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png 'scrot2.png')
<br />

## Table of Contents

- [About](#about)
- [How it works](#how-it-works)
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Background](#background)
- [Keybinding](#keybindings)
- [Lockscreen on sleep/suspend with systemd](#systemd)

## About

Most of i3lock wrapper-scripts out there take an image, add some effect(s) then lock with the modified image as locker-background. Overall experience doesn't feel natural given delay of 2-3 seconds.

> Who would like a delay of 2-3 seconds while locking screen?

So Betterlockscreen was my attempt to solve this problem, as we dont need to change lockscreen background frequently this script caches images with effect so overall experience is simple and as fast as native i3lock.

## How it works

The script takes a directory or image, adds various effects and caches the images in special directory. Those cached images will be used as locker-background depending on configuration provided by user.

## System Requirements

* [i3lock-color](https://github.com/Raymo111/i3lock-color) `>= 2.13.c.3`
* [ImageMagick](https://imagemagick.org/)
* xdpyinfo, xrandr, xrdb and xset from [X.Org](https://www.x.org/)
* (Optional) [Dunst](https://dunst-project.org/)
* (Optional) [feh](https://feh.finalrewind.org/) for wallpaper-functionality

> Note: Make sure your system has all dependencies satisfied

## Installation
### Package Manager

<a href="https://repology.org/project/betterlockscreen">
  <img src="https://repology.org/badge/vertical-allrepos/betterlockscreen.svg" alt="Packaging status" align="right">
</a>

Betterlockscreen is available via package manager on some linux-distributions, if you miss your favorite one you can follow along with our [installation-script](#installation-script) or [manual-installation](#manual-installation).

If you are using **Arch Linux**, you can install the AUR package
[betterlockscreen](https://aur.archlinux.org/packages/betterlockscreen/) to get the latest
version, or [betterlockscreen-git](https://aur.archlinux.org/packages/betterlockscreen-git/) for the most up-to-date (unstable) changes.

If you are using **Gentoo Linux**, you can install `betterlockscreen` from Gentoo's [GURU overlay](https://wiki.gentoo.org/wiki/Project:GURU) using `emerge x11-misc/betterlockscreen`.

If you are using **NixOS**, [betterlockscreen](https://search.nixos.org/packages?query=betterlockscreen) is available in both the [stable](https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/misc/screensavers/betterlockscreen/default.nix) and [unstable](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/misc/screensavers/betterlockscreen/default.nix) channels and can be installed using `nix-env -iA nixos.betterlockscreen`.

If you are using **Void Linux**, you can install [betterlockscreen](https://github.com/void-linux/void-packages/blob/master/srcpkgs/betterlockscreen/template) using `xbps-install -S betterlockscreen`.

### Installation Script

We have created an automatic [install-script](https://github.com/betterlockscreen/betterlockscreen/blob/main/install.sh) for Betterlockscreen. The script is very simple and takes three parameters:
  * `<install-mode>`: (string) 'user' installs to '~/.local/bin/', 'system' installs to '/usr/local/bin'
  * `[<version>]`: (string) defaults to 'latest' which will determinate the latest tag from git or specified branch/tag
  * `[<systemd-service>]`: (boolean) defaults to 'false' - Whether to copy and enable system-service.

For system-installation:
```sh
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
```

For user-installation:
```sh
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user
```

### Manual Installation

Ỳou can download the latest release [here](https://github.com/betterlockscreen/betterlockscreen/releases), please ensure to fullfill the [system-requirements](#system-requirements)!

You will need to copy "betterlockscreen" to you desired binary-directory, if you want to use the systemd-service you will need to copy the service-file from "system/" to the desired location on your system.

Example (Ubuntu):
```sh
wget https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip main.zip

cd betterlockscreen-main/
chmod u+x betterlockscreen
cp betterlockscreen /usr/local/bin/

cp system/betterlockscreen@.service /usr/lib/systemd/system/
systemctl enable betterlockscreen@$USER
```

## Configuration

You can customize Betterlockscreen for your needs, copy the config file from the examples-directory to the user-configuration directory `~/.config/betterlockscreen/` and edit it accordingly.

```sh
mkdir -p ~/.config/betterlockscreen/
cp /usr/share/doc/betterlockscreen/examples/betterlockscreenrc ~/.config/betterlockscreen/
```

If no configuration-file is found, then the default configurations (which is equal to the example but hardcoded) will be used.

### Custom script's on pre/post-lock
If present in user-configuration directory (see above) the "custom-(pre|post).sh" gets sourced at the appropriate time. This can be used to pause notification (not needed for dunst!), switch keyboard-layout on pre/post-lock etc.

## Usage

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
      Turn display off after N seconds

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

#### Examples
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

#### AwesomeWM - naughty
It has been discovered that the integrated notification-system "naughty" which is included and enabled by default, causes issue with dunst when running parallel.

If dunst is not installed, there should be no issue, if dunst is installed (even not running) our integration will try to pause dunst on lock/resume on unlock, which lead to a DBus reply timeout.

To fix this, please add the following line to your `rc.lua`:
```
package.loaded["naughty.dbus"] = {}
```

Source: #284 (thanks to @nullbyto), https://github.com/awesomeWM/awesome/issues/1285

## Background

Add this line to `.xinitrc`.

```sh
# set desktop background with custom effect
betterlockscreen -w dim

# Alternative (set last used background)
source ~/.fehbg
```

### i3wm

Add this line to `~/.config/i3/config`

```sh
# set desktop background with custom effect
exec --no-startup-id betterlockscreen -w dim

# Alternative (set last used background)
exec --no-startup-id source ~/.fehbg
```

## Keybindings

To lockscreen using keyboard shortcut

### i3wm

Add this line to your `~/.config/i3/config`

```sh
bindsym $mod+shift+x exec betterlockscreen -l dim
```

### bspwm

Add this line to your `~/.config/sxhkd/sxhkdrc`

```sh
# lockscreen
alt + shift + x
    betterlockscreen -l dim
```

<h2 id="systemd">Systemd-Service: Lockscreen after sleep/suspend</h2>

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

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Betterlockscreen is under [MIT](https://github.com/betterlockscreen/betterlockscreen/blob/main/LICENSE) license.

### Feel free to use and distribute

- Hat tip to anyone who's code was used
- Thanks to those who contributed to make it better
- Inspiration - [r/unixporn](https://www.reddit.com/r/unixporn)

### Supported by
<a href="https://jb.gg/OpenSourceSupport">
  <img src="https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.png" height="100" alt="JetBrains Logo (Main) logo" />
</a>
