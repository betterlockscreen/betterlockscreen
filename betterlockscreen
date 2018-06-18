#!/usr/bin/env bash

# Author : Pavan Jadhaw
# Github Profile : https://github.com/pavanjadhaw
# Project Repository : https://github.com/pavanjadhaw/betterlockscreen

# find your resolution so images can be resized to match your screen resolution
res=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')

init_filenames() {
	#$1 resolution

	# create folder in ~/.cache/i3lock directory
	res_folder="$HOME/.cache/i3lock/$1"
	folder="$HOME/.cache/i3lock/current"
        echo "Got" $@ $res_folder
	if [ ! -d  $folder -o -n "$2" ]
	then
	    rm $folder
	    ln -s $res_folder $folder
	fi

	# ratio for rectangle to be drawn for time background on lockscreen
	# Original Image
	orig_wall="$folder/wall.png"

	# Versions (from here)
	# You can use these images to set different versions as wallpaper
	# lockscreen background.
	resized="$folder/resized.png" # resized image for your resolution

	# images to be used as wallpaper
	dim="$folder/dim.png" # image with subtle overlay of black
	blur="$folder/blur.png" # blurred version
	dimblur="$folder/dimblur.png"

	# lockscreen images (images to be used as lockscreen background)
	l_resized="$folder/l_resized.png"
	l_dim="$folder/l_dim.png"
	l_blur="$folder/l_blur.png"
	l_dimblur="$folder/l_dimblur.png"
}

init_filenames $res

prelock() {
    if [ ! -z "$(pidof dunst)" ] ; then
        pkill -u "$USER" -USR1 dunst
    fi
}

lock() {
	#$1 image path
	letterEnteredColor=d23c3dff
	letterRemovedColor=d23c3dff
	passwordCorrect=00000000
	passwordIncorrect=d23c3dff
	background=00000000
	foreground=ffffffff
	i3lock \
		-t -i "$1" \
		--timepos="x+110:h-70" \
		--datepos="x+135:h-45" \
		--clock --datestr "Type password to unlock..." \
		--insidecolor=$background --ringcolor=$foreground --line-uses-inside \
		--keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
		--insidevercolor=$passwordCorrect --insidewrongcolor=$passwordIncorrect \
		--ringvercolor=$foreground --ringwrongcolor=$foreground --indpos="x+280:h-70" \
		--radius=20 --ring-width=4 --veriftext="" --wrongtext="" \
		--verifcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground" \
		--noinputtext="" --force-clock $lockargs
}

postlock() {
    if [ ! -z "$(pidof dunst)" ] ; then
        pkill -u "$USER" -USR2 dunst
    fi
}

rec_get_random() {
	dir="$1"
	if [ ! -d "$dir" ]; then
		user_input="$dir"
		return
	fi
	dir=($dir/*)
	dir=${dir[RANDOM % ${#dir[@]}]}
	rec_get_random "$dir"
}

lockselect() {
	case "$1" in
		"")
			# default lockscreen
			prelock
			lock "$l_resized" && $2
			postlock
			;;

		dim)
			# lockscreen with dimmed background
			prelock
			lock "$l_dim" && $2
			postlock
			;;

		blur)
			# set lockscreen with blurred background
			prelock
			lock "$l_blur" && $2
			postlock
			;;

		dimblur)
			# set lockscreen with dimmed + blurred background
			prelock
			lock "$l_dimblur" && $2
			postlock
			;;
	esac
}

usage() {

		echo "Important: Update the image cache (e.g. betterlockscreen -u path/to/image.jpg)."
		echo "	Image cache must be updated to initially configure or update wallpaper used"
		echo
		echo
		echo "See: https://github.com/pavanjadhaw/betterlockscreen for additional info..."
		echo
		echo
		echo "Options:"
		echo
		echo "	-h --help"

		echo "		For help (e.g. betterlockscreen -h or betterlockscreen --help)."
		echo
		echo
		echo "	-u --update"
		echo "		to update image cache, you should do this before using any other options"
		echo "		E.g: betterlockscreen -u path/to/image.png when image.png is custom background"
		echo "		Or you can use betterlockscreen -u path/to/imagedir and a random file will be selected."
		echo
		echo
		echo "	-l --lock"
		echo "		to lock screen (e.g. betterlockscreen -l)"
		echo "		you can also use dimmed or blurred background for lockscreen."
		echo "		E.g: betterlockscreen -l dim (for dimmed background)"
		echo "		E.g: betterlockscreen -l blur (for blurred background)"
		echo "		E.g: betterlockscreen -l dimblur (for dimmed + blurred background)"
		echo
		echo
		echo "	-s --suspend"
		echo "		to suspend system and lock screen (e.g. betterlockscreen -s)"
		echo "		you can also use dimmed or blurred background for lockscreen."
		echo "		E.g: betterlockscreen -s dim (for dimmed background)"
		echo "		E.g: betterlockscreen -s blur (for blurred background)"
		echo "		E.g: betterlockscreen -s dimblur (for dimmed + blurred background)"
		echo
		echo
		echo "	-w --wall"
		echo "		you can also set lockscreen background as wallpaper"
		echo "		to set wallpaper (e.g. betterlockscreen -w or betterlockscreen --wall)"
		echo "		you can also use dimmed or blurred variants."
		echo "		E.g: betterlockscreen -w dim (for dimmed wallpaper)"
		echo "		E.g: betterlockscreen -w blur (for blurred wallpaper)"
		echo "		E.g: betterlockscreen -w dimblur (for dimmed + blurred wallpaper)"
		echo
		echo
		echo "	-r --resolution"
		echo "		to be used after -u"
		echo "		used to set a custom resolution for the image cache."
		echo "		E.g: betterlockscreen -u path/to/image.png -r 1920x1080"
		echo "		E.g: betterlockscreen -u path/to/image.png --resolution 3840x1080"
		echo
		echo
		echo "	-b --blur"
		echo "		to be used after -u"
		echo "		used to set blur intensity. Default to 1."
		echo "		E.g: betterlockscreen -u path/to/image.png -b 3"
		echo "		E.g: betterlockscreen -u path/to/image.png --blur 0.5"
}

# Options
case "$1" in
	"")
		if [ ! -f $l_dim ]; then
			echo "Important: Update the image cache (e.g. betterlockscreen -u path/to/image.jpg)."
			echo
			echo "		Image cache must be updated to initially configure or update wallpaper used"
			echo
			echo "See also: For other set of options and help use help command."
			echo "E.g. betterlockscreen -h or betterlockscreen --help"

			echo
			echo "See: https://github.com/pavanjadhaw/betterlockscreen for addition info..."
			exit 1
		else
			echo
			echo "Seems you havent provided any argument, see below for usage info"
			echo
			echo "See also: For other set of options and help use help command."

			echo "E.g. betterlockscreen -h or betterlockscreen --help"

			echo
			echo "See: https://github.com/pavanjadhaw/betterlockscreen for addition info..."
			echo
			exit 1
		fi
		;;

	-h | --help)

	usage
		;;

	-l | --lock)
		lockargs="-n"
		lockselect "$2"
		;;

	-s | --suspend)
		lockselect "$2" "systemctl suspend"
		;;

	-w | --wall)
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

			dimblur)
				# set dimmed + blurred image as wallpaper
				feh --bg-fill $dimblur
				;;
		esac
		;;

	-u | --update)
		background="$2"
		shift 2

		# default blur level
		blur_level=1

		# parse update arguments
		while [ $# -gt 0 ]; do
			case "$1" in
			-r | --resolution )
				res="$2"
				init_filenames $res force
				shift 2
				;;
			-b | --blur )
				blur_level="$2"
				shift 2
				;;
			*)
				shift ;;
			esac
		done

		rectangles=" "
		SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
		for RES in $SR; do
			SRA=(${RES//[x+]/ })
			CX=$((${SRA[2]} + 25))
			CY=$((${SRA[1]} - 30))
			rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
		done

		# User supplied Image
		user_image="$folder/user_image.png"

		# create folder
		if [ ! -d $folder ]; then
			echo "Creating '$folder' directory to cache processed images."
			mkdir -p "$folder"
		fi

		# get random file in dir if passed argument is a dir
		rec_get_random "$background"

		# get user image
		cp "$user_input" "$user_image"
		if [ ! -f $user_image ]; then
			echo "Please specify the path to the image you would like to use"
			exit 1
		fi

		# replace orignal with user image
		cp "$user_image" "$orig_wall"
		rm "$user_image"

		echo "Generating alternate images based on the image you specified,"
		echo "please wait this might take few seconds..."

		# wallpapers

		echo
		echo "Converting provided image to match your resolution..."
		# resize image
		convert "$orig_wall" -resize "$res""^" -gravity center -extent "$res" "$resized"

		echo
		echo "Applying dim and blur effect to resized image"
		# dim
		convert "$resized" -fill black -colorize 40% "$dim"

		# blur
		blur_shrink=$(echo "scale=2; 20 / $blur_level" | bc)
		blur_sigma=$(echo "scale=2; 0.6 * $blur_level" | bc)
		convert "$resized" \
			-filter Gaussian \
			-resize "$blur_shrink%" \
			-define "filter:sigma=$blur_sigma" \
			-resize "$res^" -gravity center -extent "$res" \
			"$blur"

		# dimblur
		convert "$dim" \
			-filter Gaussian \
			-resize "$blur_shrink%" \
			-define "filter:sigma=$blur_sigma" \
			-resize "$res^" -gravity center -extent "$res" \
			"$dimblur"

		# lockscreen backgrounds

		echo
		echo "Caching images for faster screen locking"
		# resized
	convert "$resized" -draw "fill rgba(0, 0, 0, 0.4) $rectangles" "$l_resized"

		# dim
		convert "$dim" -draw "fill rgba(0, 0, 0, 0.4) $rectangles" "$l_dim"

		# blur
		convert "$blur" -draw "fill rgba(0, 0, 0, 0.4) $rectangles" "$l_blur"

		# blur
		convert "$dimblur" -draw "fill rgba(0, 0, 0, 0.4) $rectangles" "$l_dimblur"
		echo
		echo "All required changes have been applied"
		;;

	*)
		echo "invalid argument"
		;;
esac
