#! /usr/bin/env bash

music_library="$HOME/Music"
fallback_image="$HOME/.ncmpcpp/ncmpcpp-ueberzug/img/fallback.png"

padding_top=3
padding_bottom=2
padding_right=0
max_width=30
reserved_playlist_cols=30

main() {
        find_cover_image        >/dev/null 2>&1
        kitten icat --clear 
        compute_geometry
        kitten icat --place 14x50@"$x"x0 $cover_path
}

compute_geometry() {
    unset LINES COLUMNS # Required in order for tput to work in a script
    term_lines=$(tput lines)
    term_cols=$(tput cols)
    x=$(( term_cols - 14 ))
    y=$(( term_lines - 15 ))
}

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

main