#!/bin/sh
export FIFO_UEBERZUG="/tmp/mpd-ueberzug-${PPID}"

cleanup() {
        kitten icat --clear 
}

cleanup
ncmpcpp
