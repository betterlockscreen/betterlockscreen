# multilockscreen
  
[About](#about) [Features](#features) [Requirements](#requirements) [Install](#install) [Usage](#usage)
  
![multilockscreen](https://camo.githubusercontent.com/bd90f582f8fea8467dc59b8b9c5f154aa1dff00f/68747470733a2f2f692e696d6775722e636f6d2f4a5a6139644c432e706e67)
  
### About
`multilockscreen` is a wrapper script for `i3lock-color`. It allows you to cache background images for `i3lock-color` with a variety of different effects and adds a stylish indicator.
  
Originally a fork of [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) with support for multiple monitors, `multilockscreen` has grown considerably. There are a tons of new and useful features.
  
### Features
- Support for multiple monitors with almost any layout
- Support for HiDPI monitors
- A bunch of cool image effects
- Apply one effect, all effects, or anything in between
- A stylish, themeable indicator
- Set desktop wallpaper to match
  
### Requirements
- [i3lock-color](https://github.com/PandorasFox/i3lock-color) - i3lock fork with additional features  
- [imagemagick](https://www.imagemagick.org/) - Image effects  
- [xrandr](https://www.x.org/) - Display info  
- [xdpyinfo](https://www.x.org/) - Display info & HiDPI support
- [feh](https://feh.finalrewind.org/) - Set wallpaper  
  
### Install
##### Manual Installation
```bash
git clone https://github.com/jeffmhubbard/multilockscreen
cd multilockscreen
sudo install -Dm 755 multilockscreen /usr/local/bin/multilockscreen
```
##### Arch Linux (AUR)
```bash
git clone https://aur.archlinux.org/multilockscreen-git.git
cd multilockscreen-git
less PKGBUILD
makepkg -si
```
  
### Usage
```bash
Usage: multilockscreen [-u <PATH>] [-l <EFFECT>] [-w <EFFECT>]

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
  
### Examples
Update image cache with random image  
`multilockscreen --update ~/Wallpapers`  

Update image cache with only dim and pixel effects  
`multilockscreen -u ~/Wallpapers/image.png --fx dim,pixel`  

Update image cache with multiple monitors, spanning  
`multilockscreen -u ~/Wallpapers/Dual/ --fx dimblur,color --display 1 --span`  

Update image cache with solid background only (ignore errors)  
`multilockscreen -u . --fx color --color 5833ff`  

Update image cache with different background images  
`multilockscreen -u ~/Wallpapers/image1.png -u ~/Wallpapers/image2.png --fx dimpixel --display 1`  

Lock screen with blur effect  
`multilockscreen --lock blur`  

Lock screen with multiple monitors, spanning  
`multilockscreen -l dimblur --display 1 --span`  
  
### Configuration
Copy the example config to `~/.config/multilock/config`  
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
```
  
### Issues
Feel free to open an Issue if you need help or have any question.

Before doing so, please look at both open and closed Issues to see if the issue has already been reported or solved.

Provide details. When submitting an issue, please give the exact command you trying to run. If you are using the config file, post that as well. Problems with `--update`, provide `convert --version` output. Problems with `--lock`, provide `i3lock --version` output.
  
### Contributing
Pull Requests are weclome! Please try to keep PRs as simple as possible. Add one feature, fix one issue, etc. The easier they are to review, the faster they get merged.

Please try stick with the format of the files (tabs, spacing, etc.). Don't make any "while I'm here" edits. And please document where appropriate.

New to Pull Requests? I suggest this [Pull Request Etiquette](https://gist.github.com/mikepea/863f63d6e37281e329f8) gist.
  
### Tips
Do not use systemd service. `xss-lock` is recommended instead  
```bash
# .xinitrc
xss-lock -l -- multilockscreen --lock blur &
```
  
### License
multilockscreen is under [MIT](https://github.com/jeffmhubbard/multilockscreen/blob/multi-monitor/LICENSE) license
