#!/bin/sh

music_library="$HOME/Music"
fallback_image="$HOME/.ncmpcpp/fallback.png"

find_cover_image() {

    # First we check if the audio file has an embedded album art
    ext="$(mpc --format %file% current | sed 's/^.*\.//')"
    if [ "$ext" = "flac" ]; then
        # since FFMPEG cannot export embedded FLAC art we use metaflac
        metaflac --export-picture-to=/tmp/mpd_cover.jpg \
            "$(mpc --format "$music_library"/%file% current)" &&
            cover_path="/tmp/mpd_cover.jpg" && return
    else
        ffmpeg -y -i "$(mpc --format "$music_library"/%file% | head -n 1)" \
            /tmp/mpd_cover.jpg &&
            cover_path="/tmp/mpd_cover.jpg" && return
    fi

    # If no embedded art was found we look inside the music file's directory
    album="$(mpc --format %album% current)"
    file="$(mpc --format %file% current)"
    album_dir="${file%/*}"
    album_dir="$music_library/$album_dir"
    found_covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f \
    -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\\(jpe?g\|png\|gif\|bmp\)" \; )"
    cover_path="$(echo "$found_covers" | head -n1)"
    if [ -n "$cover_path" ]; then
        return
    fi

    # If we still failed to find a cover image, we use the fallback
    if [ -z "$cover_path" ]; then
        cover_path=$fallback_image
    fi
}

update_cava() {
        cava_config=/home/khang/.config/cava/config_2
        palette=$(get_color_pallet $1 | awk '{ printf "gradient_color_%s = \"%s\"\n", NR, $1 }')
        echo "$(head -n -3 /home/khang/.config/cava/config_2)" > /home/khang/.config/cava/config_2
        echo "$palette" >> /home/khang/.config/cava/config_2
        kitty @ send-text --match 'title:^cava' "r \r"
}


main () {
        find_cover_image >/dev/null 2>&1
        kitty @ send-text --match 'title:^cover' "kitten icat --clear --place 57x57@0x0 $cover_path\r"
        # dominant_color=$(dominant_color_extractor $cover_path)
        # kitty @ set-colors color5=$dominant_color
        update_cava $cover_path
        notify-send "Now Playing" "$(mpc --format '%title% \n%artist% - %album%' current)" -i $cover_path -u low
}

main
