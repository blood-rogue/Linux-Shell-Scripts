cat << EOM
    ____                      __                __
   / __ \____ _      ______  / /___  ____ _____/ /__  _____
  / / / / __ \ | /| / / __ \/ / __ \/ __ \`/ __  / _ \/ ___/
 / /_/ / /_/ / |/ |/ / / / / / /_/ / /_/ / /_/ /  __/ /
/_____/\____/|__/|__/_/ /_/_/\____/\__,_/\__,_/\___/_/

                                           By: Bismit Panda

EOM

video_patt="(https?:)\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)\.(mp4|m4a|mkv|webm|mov|flv|3gp)"
audio_patt="(https?:)\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)\.(pcm|wav|aiff|aac|ogg|mp3)"

if [[ -d tmp ]]; then
    rm -r tmp
fi
mkdir tmp

read -p "Enter link: " link
echo "Downloading '$link'"
wget $link -O tmp/out -q

grep -o -P $video_patt tmp/out > tmp/video_urls
grep -o -P $audio_patt tmp/out > tmp/audio_urls

read -p "Found $(cat tmp/video_urls | wc -l) videos. Do you want to download them? (y/n) " dv

if [[ $dv == "y" ]]; then
    mkdir -p videos

    while read url
    do
        echo "Downloading '$url' to 'videos'"
        wget $url -P videos -q
    done < ./tmp/video_urls
fi

read -p "Found $(cat tmp/audio_urls | wc -l) audios. Do you want to download them? (y/n) " da

if [[ $da == "y" ]]; then
    mkdir -p audios

    while read url
    do
        echo "Downloading '$url' to 'audios'"
        wget $url -P audios -q
    done < ./tmp/audio_urls
fi

rm -r tmp