# better_lockscreen
*A simple lock script for i3lock*

Most of i3lock script out there converts your defined image to add blur, glitch or dim effect to image and it feels so slow and btw who needs dynamic lock background,
its not like I change lockscreen background every 5 minutes.
I wanted something that was fast and still should have all the effects I want for lockscreen background.

This script generates or already caches the variant for your custom images before hand so they can be later used any number of time as lockscreen background,
without the need to apply same effect again and again

## Screenshots

Screenshots or it didnt happen... :P

![scrot1](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot1.png "scrot1.png")

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png "scrot2.png")

### Demo

* [Demonstration](https://www.youtube.com/watch?v=9Ng5FZwnn6M&feature=youtu.be) - youtube.com

## Getting Started

Clone this repo, push this script somewhere handy or you can even copy this script to /usr/local/bin so that it can be used from your i3config without defining whole path.

### Prerequisites

Make sure you have following packages installed.

* [i3lock-color](https://github.com/PandorasFox/i3lock-color) - i3lock fork with additional features (use development branch while building from source for arch use i3lock-color-git from AUR)
* [imagemagick](https://www.imagemagick.org/script/index.php) - to apply effects to images
* [feh](https://feh.finalrewind.org/) - used to set custom wallpaper
* [xdpyinfo](https://www.x.org/archive/X11R7.7/doc/man/man1/xdpyinfo.1.xhtml) - find your screen resolution (to resize images accordingly)
* [xrandr](https://www.x.org/wiki/Projects/XRandR/) - depends for xdpyinfo
* [background.jpg](https://unsplash.com/) - find your fav background image

### Arch users

To install required packages

Install feh and imagemagick

```
pacman -S imagemagick feh
```

Install xrandr and xdpyinfo (currently used to find screenresolution)
If anyone knows better way so that these dependencies could be minimized, please open issue.

```
pacman -S xorg-xrandr xorg-xdpyinfo
```

Install i3lock-color-git from AUR

Pacaur Users
```
pacaur -S aur/i3lock-color-git
```

Yaourt users
```
yaourt -S i3lock-color-git
```

### How to get started

#### Clone this repo

```
git clone https://github.com/pavanjadhaw/betterlockscreen
```

navigate to cloned repository

```
cd betterlockscreen
```

---

#### If you dont want to clone the repo and save some bandwidth and diskspace you can do the following

```
wget https://raw.githubusercontent.com/pavanjadhaw/betterlockscreen/master/lock.sh

chmod +x lock.sh
```

---

### Load/Update the image cache

*Grab your favourite image for lockscreen background*

```
./lock.sh -u path/to/image.img
```

*if you want to use random image from specific directory*

```
./lock.sh -u path/to/imagedir
```

*set random image as desktop background too*

```
./lock.sh -u path/to/imagedir && ./lock.sh -w
```

---

### To lockscreen

Original image as background

```
./lock.sh -l
```

Use dimmed image as lockscreen background

```
./lock.sh -l dim
```

Use blurred image as lockscreen background

```
./lock.sh -l blur
```

Use dim + blurred image as lockscreen background

```
./lock.sh -l dimblur
```

---

### To set wallpaper

Original Image

```
./lock.sh -w
```

Use dimmed image as desktop background

```
./lock.sh -w dim
```

Use blurred image as desktop background

```
./lock.sh -w blur
```

Use dim + blurred image as desktop background

```
./lock.sh -w dimblur
```

---

To set desktop background on startup, add following lines to your .xintrc after pushing script to your path or you can use absolute path to script too

```
# below line no longer needed as cached images are now permanently stored
# exec lock.sh -u ~/.wall.png &

exec lock.sh -w
```

If you are i3wm user, add following line to your i3config (~/.config/i3/config or ~/.i3/config)

*custom shortcut to lockscreen*
```
# custom keybinding to lockscreen, use --lock dim or --lock blur below for different backgrounds
bindsym $mod+shift+x exec lock.sh --lock
```

*update image cache and set last cached image as desktop background*
```
# Update image cache
# no longer required as cached images are permanently stored
# exec --no-startup-id lock.sh -u ~/.wall.png

# Set last used image as desktop background
# comment out below line if you use different desktop background utility
exec --no-startup-id lock.sh -w
```

**OR**

*use following if you would like to be surprised by random wallpaper from directory of your choice on each startup*
```
# where Pictures/Wallpapers is the directory you would want to get random wallpapers from
exec --no-startup-id lock.sh -u ~/Pictures/Wallpapers

# add this only if you want to use same random image as desktop background too (you might want to)
# it might not work as it takes few seconds for images to be cached,
# try adding delay of 5 seconds if thats the case
exec --no-startup-id lock.sh -w
```

---

## Feel free to use and distribute

This is my first bash script so if you think this could be improved or if you have any suggestion. Feel free.

* Hat tip to anyone who's code was used
* Thanks to those who contributed to make it better
* Inspiration - r/unixporn
* etc

