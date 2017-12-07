#!/usr/bin/bash

# ratio for rectangle to be drawn for time background on lockscreen
rectangles=" "
SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in $SR; do
  SRA=(${RES//[x+]/ })
  CX=$((${SRA[2]} + 25))
  CY=$((${SRA[1]} - 30))
  rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
done


# find your resolution so images can be resized to match your screen resolution
y_res=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
# echo " "
# echo " "
# echo "Your screen resolution is : $y_res"
# echo " "
# echo " "

# Original Image
orig_wall=$HOME/.wall.png

# create folder in /tmp directory
folder="/tmp/lock"

# User supplied Image
user_image="$folder/user_image.png"

# Versions (from here)
# You can use these images to set different versions as wallpaper
# lockscreen background.
resized="$folder/resized.png" # resized image for your resolution

# images to be used as wallpaper
dim="$folder/dim.png" # image with subtle overlay of black
blur="$folder/blur.png" # blurred version

# lockscreen images (images to be used as lockscreen background)
l_resized="$folder/l_resized.png"
l_dim="$folder/l_dim.png"
l_blur="$folder/l_blur.png"


# Options
case "$1" in
    "")


        if [ ! -f $l_dim ]; then
            echo "Important : Update the image cache, Ex. ./lock.sh -g path/to/image.jpg"
            echo
            echo "See also : For other set of options and help use help command."
            echo "Ex. ./lock.sh -h or ./lock.sh --help"
            echo
            echo "See : github.com/pavanjadhaw/better_lock for addition info..."
            exit 1
        fi

        ;;

    -h | --help)

        echo "Important : Update the image cache, Ex: ./lock.sh -g path/to/image.jpg"
        echo
        echo "See also : For other set of options and help use help command."
        echo "Ex. ./lock.sh -h or ./lock.sh --help"
        echo
        echo "See : github.com/pavanjadhaw/better_lock for additional info..."
        echo
        echo
	    echo "Options:"
        echo
	    echo "          -h --help"
	    echo "              For help. Ex: ./lock.sh -h or ./lock.sh --help"
	    echo
        echo
	    echo "          -u --update"
	    echo "              to update image cache, you should do this before using any other options"
	    echo "              Ex: ./lock.sh -u path/to/image.png when image.png is custom background"
        echo
        echo
	    echo "          -l --lock"
	    echo "              to lock screen, Ex. ./lock.sh -l"
        echo "              you can also use dimmed or blurred background for lockscreen"
        echo "              Ex: ./lock.sh -l dim (for dimmed background)"
        echo "              Ex: ./lock.sh -l blur (for blurred background)"
        echo
        echo
        echo "          -w --wall"
        echo "              you can also set lockscreen background as wallpaper"
        echo "              to set wallpaper. Ex ./lock.sh -w or ./lock.sh --wall"
        echo "              you can also use dimmed or blurred variants"
        echo "              Ex: ./lock.sh -w dim (for dimmed wallpaper)"
        echo "              Ex: ./lock.sh -w blur (for blurred wallpaper)"
	    echo
        ;;

    -l | --lock)


    case "$2" in

    "")

        # just lockscreen with dimmed wallpaper if no argument is provided by user.
        # stop dunst from showing notifications on lockscreen
        pkill -u "$USER" -USR1 dunst

        # you will need to have i3lock-color package availble on aur(arch user repository)
        i3lock \
        -n -i "$l_resized" \
        --timepos="x-90:h-ch+30" \
        --datepos="tx+24:ty+25" \
        --clock --datestr "type password to unlock..." \
        --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
        --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
        --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
        --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
        --radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
        --textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"

        # enable notifications once unlocked
        pkill -u "$USER" -USR2 dunst
        ;;


    dim)


        # Just lockscreen with dimmed wallpaper if no argument is provided by user.
        # stop dunst from showing notifications on lockscreen
        pkill -u "$USER" -USR1 dunst

        # you will need to have i3lock-color package availble on AUR(arch user repository)
        i3lock \
        -n -i "$l_dim" \
        --timepos="x-90:h-ch+30" \
        --datepos="tx+24:ty+25" \
        --clock --datestr "Type password to unlock..." \
        --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
        --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
        --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
        --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
        --radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
        --textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"

        # enable notifications once unlocked
        pkill -u "$USER" -USR2 dunst
        ;;

    blur)


        # Just lockscreen with dimmed wallpaper if no argument is provided by user.
        # stop dunst from showing notifications on lockscreen
        pkill -u "$USER" -USR1 dunst

        # you will need to have i3lock-color package availble on AUR(arch user repository)
        i3lock \
        -n -i "$l_blur" \
        --timepos="x-90:h-ch+30" \
        --datepos="tx+24:ty+25" \
        --clock --datestr "Type password to unlock..." \
        --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
        --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
        --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
        --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-70" \
        --radius=20 --ring-width=3 --veriftext="" --wrongtext="" \
        --textcolor="ffffffff" --timecolor="ffffffff" --datecolor="ffffffff"

        # enable notifications once unlocked
        pkill -u "$USER" -USR2 dunst
        ;;


    esac
    ;;

    -w | --wall)


        # w = set wallpaper
        case "$2" in
            "")
                # set resized image as wallpaper if no argument is supplied by user
                feh --bg-fill $resized
                ;;
            dim)
                # set dimmed image as wallpaper
                feh --bg-fill $dim
                ;;
            blur)
                # set blurred image as wallpaper
                feh --bg-fill $blur
                ;;

            esac

        ;;

    -u | --update)


        # create folder
        if ! [[ -d $folder ]]; then
            mkdir -p "$folder"
        fi

        # get user image
        cp "$2" "$user_image"
        if [ ! -f $user_image ]; then
            echo "Please specify the path to the image you would like to use"
            exit 1
        fi

        # replace orignal with user image
        cp "$user_image" "$orig_wall"
        rm "$user_image"

        echo "Generating alternate images based on the image you specified,"
        echo "please wait this might take few seconds..."


        # wallpapers {{{


        # resize image
        convert "$orig_wall" -resize "$y_res""^" -gravity center -extent "$y_res" "$resized"

        # dim
        convert "$resized" -fill black -colorize 40% "$dim"

        # blur
        convert "$resized" -blur 0x5 "$blur"


        # }}}


        # lockscreen backgrounds {{{


        # resized
        convert "$resized" -draw "fill black fill-opacity 0.4 $rectangles" "$l_resized"

        # dim
        convert "$dim" -draw "fill black fill-opacity 0.4 $rectangles" "$l_dim"

        # blur
        convert "$blur" -draw "fill black fill-opacity 0.4 $rectangles" "$l_blur"


        # }}}

        echo "All required images have been generated"
        ;;


esac

