#!/bin/bash

# Habilitate nullglob
shopt -s nullglob

# Put the location of VLC
vlc_path="/usr/bin/vlc"

current_dir=$(basename "$PWD")
dest_path="../${current_dir}mp3"
mkdir -p "$dest_path"

if [ -n "$1" ]; then
    dir_path="$1"
else
    echo "Please, put the route of the m4a files as an argument."
    exit 1
fi

cd "$dir_path"

for file in *.m4a; do
    clean_file=${file//\"/}
    clean_file=${clean_file//\'/}
    new_file="${dest_path}/${clean_file%.m4a}.mp3"
    
    "$vlc_path" --play-and-exit --sout "#transcode{vcodec=none,acodec=mp3,ab=384,channels=2,samplerate=44100}:file{dst='$new_file'}" "$file"
done
