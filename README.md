# better_lockscreen

A simple lock script for i3lock
Most of i3lock script out there converts your defined image to add blur, glitch or dim effect to image and it feels so slow and btw who needs dynamic lock background,
its not like I change lockscreen background every 5 minutes.
I wanted something that was fast and still should have all the effects I want for lockscreen background.
This script generates or already caches the variant for your custom images before hand so they can be later used any number of time as lockscreen background,
without the need to apply same effect again and again

## Screenshots

Screenshots or it didnt happen... :P

![scrot1](https://github.com/pavanjadhaw/betterlockscreen/raw/master/demo/scrot1.png "scrot1.png")

![scrot2](https://github.com/pavanjadhaw/betterlockscreen/raw/master/demo/scrot2.png "scrot2.png")

### demo.mp4

* [demo.mp4](https://www.youtube.com/watch?v=9Ng5FZwnn6M&feature=youtu.be) - youtube.com

## Getting Started

Clone this repo, push this script somewhere handy or you can even copy this script to /usr/local/bin so that it can be used from your i3config without defining whole path.

### Prerequisites

Make sure you have following packages installed.

* [i3lock-color](https://github.com/PandorasFox/i3lock-color) - i3lock fork with additional features
* [imagemagick](https://www.imagemagick.org/script/index.php) - to apply effects to images
* [feh](https://feh.finalrewind.org/) - used to set custom wallpaper
* [background.jpg](https://unsplash.com/) - find your fav background image

### Arch users

To install required packages

Install feh and imagemagick

```
pacman -S imagemagick feh
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

Clone this repo

```
git clone https://github.com/pavanjadhaw/betterlockscreen
```

navigate to cloned repository

```
cd betterlockscreen
```

grab your fav image for lockscreen background

```
./lock.sh -u path/to/image.img

# OR use wallaper.jpg supplied from this repo

./lock.sh -u wallaper.jpg
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
exec lock.sh -u ~/.wall.png &

exec lock.sh -w
```

If you are i3wm user, add following line to your i3config (~/.config/i3/config or ~/.i3/config)

```
# custom keybinding to lockscreen, use --lock dim or --lock blur below for different backgrounds
bindsym $mod+shift+x exec lock.sh --lock
# bindsym $mod+shift+x exec lock.sh --lock dim
# bindsym $mod+shift+x exec lock.sh --lock blur

# Update image cache
exec --no-startup-id lock.sh -U ~/.wall.png

# Set last used image as desktop background, comment out below line if you use different desktop background utility
exec --no-startup-id lock.sh -w
```

---

## Feel free to use and distribute

This is my first bash script so if you think this could be improved or if you have any suggestion. Feel free.

* Hat tip to anyone who's code was used
* Inspiration - r/unixporn
* etc

