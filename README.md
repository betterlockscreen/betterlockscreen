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

### Demo

* [Demonstration](https://www.youtube.com/watch?v=9Ng5FZwnn6M&feature=youtu.be) - youtube.com

## Features

```
# Lock screen
betterlockscreen -l | --lock [modifier]
# Set wallpaper
betterlockscreen -w | --wall [modifier]
# Suspend system
betterlockscreen -s | --suspend [modifier]
# Update image cache
betterlockscreen -u | --update (path/to/image.png | path/to/directory) [-r | --resolution <resolution>] [-b | --blur <factor>]

Modifiers:
dim
blur
dimblur

Example update image cache:
betterlockscreen -u path/to/directory -r 1920x1080 -b 0.5
In this case a random image from the directory is chosen, and converted to a 1920x1080 resolution with the blur factor set to 0.5
```


## Installation via AUR package

### [release](https://aur.archlinux.org/packages/betterlockscreen/)  
recommended if you want to spend less on bandwidth(less than 10kb) 
```
pacaur -S aur/betterlockscreen
```
```
yaourt -S betterlockscreen
```

### [dev](https://aur.archlinux.org/packages/betterlockscreen-git/)  
latest features but includes git history so 8mb+ of downloading.
```
pacaur -S aur/betterlockscreen-git
```
```
yaourt -S betterlockscreen-git
```

## Manual Installation

Clone this repo, push this script somewhere handy or you can even copy this script to /usr/local/bin so that it can be used from your i3config without defining whole path.

```
git clone https://github.com/pavanjadhaw/betterlockscreen 
# optionally copy the script to /usr/local/bin so you can execute it everywhere
cp betterlockscreen/betterlockscreen /usr/local/bin/betterlockscreen
```

OR

If you dont want to clone the repo and save some bandwidth and diskspace you can do the following

```
wget https://raw.githubusercontent.com/pavanjadhaw/betterlockscreen/master/betterlockscreen
chmod u+x betterlockscreen
```

### Prerequisites

Make sure you have following packages installed.

* [i3lock-color](https://github.com/PandorasFox/i3lock-color) - i3lock fork with additional features (currently supported versions are 2.10.1c and 2.10.1-1-c due to a wip rewrite of it)
* [imagemagick](https://www.imagemagick.org/script/index.php) - to apply effects to images
* [xdpyinfo](https://www.x.org/archive/X11R7.7/doc/man/man1/xdpyinfo.1.xhtml) - find your screen resolution (to resize images accordingly)
* [xrandr](https://www.x.org/wiki/Projects/XRandR/) - depends for xdpyinfo
* [bc](https://www.gnu.org/software/bc/) - used for setting the blur level
* [feh](https://feh.finalrewind.org/) - used to set custom wallpaper

*Note: systemd is required for the suspend feature.*

### Arch users

To install required packages

Install feh, imagemagick, xrandr and xdpyinfo (currently used to find screenresolution)
If anyone knows better way so that these dependencies could be minimized, please open issue.

```
pacman -S imagemagick feh xorg-xrandr xorg-xdpyinfo
```

Install i3lock-color from AUR

Pacaur Users
```
pacaur -S aur/i3lock-color
```

Yaourt users
```
yaourt -S i3lock-color
```
---

To set desktop background on startup, add following lines to your .xintrc after pushing script to your path or you can use absolute path to script too

```
exec betterlockscreen -w
```

If you are i3wm user, add following line to your i3config (~/.config/i3/config or ~/.i3/config)

*custom shortcut to lockscreen*
```
# custom keybinding to lockscreen, use --lock dim or --lock blur below for different backgrounds
bindsym $mod+shift+x exec betterlockscreen --lock
```

*set last cached image as desktop background*
```
# Set last used image as desktop background
exec --no-startup-id betterlockscreen -w
```

*set the image cache to a random image from a directory of your choice on each startup*
```
# where Pictures/Wallpapers is the directory you would want to get random wallpapers from
exec --no-startup-id betterlockscreen -u ~/Pictures/Wallpapers

# add this only if you want to use same random image as desktop background too
# it might not work as it takes few seconds for images to be cached,
# try adding delay of 5 seconds if thats the case
exec --no-startup-id betterlockscreen -w
```

---

## Feel free to use and distribute

This is my first bash script so if you think this could be improved or if you have any suggestion. Feel free.

* Hat tip to anyone who's code was used
* Thanks to those who contributed to make it better
* Inspiration - r/unixporn
