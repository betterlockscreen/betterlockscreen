#!/bin/bash

# Function to apply the blur effect with custom blur strength
apply_custom_blur() {
    blur_strength="$1"  # Get user-specified blur intensity
    image="$2"          # Input image
    output_image="$3"   # Output image

    # Apply the blur effect using ImageMagick
    convert "$image" -blur 0x"$blur_strength" "$output_image"
}

# Default values
blur_strength=8  # Default blur strength if not provided

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --lock)
            lock_screen=true
            shift
            ;;
        --blur-strength)
            blur_strength="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

# Example lockscreen logic
if [ "$lock_screen" = true ]; then
    # Set the input and output images
    input_image="/path/to/cached_image.png"  # Cached lockscreen image
    output_image="/path/to/lockscreen_output.png"

    # Apply the custom blur effect
    apply_custom_blur "$blur_strength" "$input_image" "$output_image"

    # Lock the screen using i3lock
    i3lock -i "$output_image"
fi
