# better_lockscreen

A simple lock script for i3lock
Most of i3lock script out there converts your defined image to add blur, glitch or dim effect to image and it feels so slow and btw who needs dynamic lock background,
its not like I change lockscreen background every 5 minutes.
I wanted something that was fast and still should have all the effects I want for lockscreen background.
This script generates or already caches the variant for your custom images before hand so they can be later used any number of time as lockscreen backgroun,
without the need to apply same effect again and again

## Getting Started

Clone this repo, push this script somewhere handy or you can even copy this script to /usr/local/bin so that it can be used from your i3config without defining whole path.

### Prerequisites

Make sure you have following packages installed.

* [i3lock-color](https://github.com/PandorasFox/i3lock-color) - i3lock fork with additional features
* [imagemagick](https://www.imagemagick.org/script/index.php) - to apply effects to images
* [feh](https://feh.finalrewind.org/) - used to set custom wallpaper
* [background.jpg](https://unsplash.com/) - find your fav background image

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
```

well, now lockscreen (original image)

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

well, now set wallpaper (original image)

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


To set desktop background on startup, add following lines to your .xintrc after pushing script to your path or you can use absolute path to script too

```
exec lock.sh -w
```

If you are i3wm user, add following line to your i3config (~/.config/i3/config or ~/.i3/config)

```
exec --no-startup-id lock.sh -w
```

## Feel free to use and distribute

This is my first bash script so if you think this could be improved or if you have any suggestion. Feel free.

* Hat tip to anyone who's code was used
* Inspiration - r/unixporn
* etc

