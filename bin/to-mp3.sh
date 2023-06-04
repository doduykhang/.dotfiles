#!/bin/bash

ffmpeg -i $1 -acodec libmp3lame -metadata TITLE="$1" "$1.mp3"
