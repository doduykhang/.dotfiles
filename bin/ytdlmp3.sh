#!/bin/bash

yt-dlp --embed-thumbnail -f bestaudio -x --audio-format mp3 --audio-quality 320k $1
