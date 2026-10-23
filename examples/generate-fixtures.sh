#!/usr/bin/env bash
# generate-fixtures.sh — make the invented media this guide's lab used.
#
# Every file is synthesised with ffmpeg: sine tones with fades and
# silence tails, tagged as invented books by invented authors.
# No commercial audio is involved anywhere.
#
#   ./generate-fixtures.sh <output-folder>
#
# Produces:
#   <out>/Audiobooks/Imogen Hartley/The Lantern Keeper's Daughter/
#       01..04 - Chapter ....mp3     a four-chapter book, one file each
#   <out>/Audiobooks/Tomas Reyes/A Field Guide to Tides/
#       A Field Guide to Tides.m4b   one file, three embedded chapters
#   <out>/PrivateShelf/Wren Okafor/Quiet Hours/
#       Quiet Hours.mp3              a single-file book
#   <out>/feed/
#       feed.xml, ep1.mp3, ep2.mp3   a two-episode podcast RSS feed
#                                    (serve the folder over HTTP and the
#                                    feed URL is http://<host>/feed.xml)
set -euo pipefail
OUT="${1:?usage: generate-fixtures.sh <output-folder>}"
FF="ffmpeg -hide_banner -loglevel error -y"
MONO="-ac 1 -ar 44100"
MP3="-c:a libmp3lame -b:a 64k -id3v2_version 3"

# one chapter: <seconds of tone> at <hz>, 2s fade in, then silence to <total>
chapter () { # freq tone_secs total out
  $FF -f lavfi -i "sine=frequency=$1:duration=$2" \
    -af "afade=t=in:st=0:d=2,apad,atrim=0:$3,afade=t=out:st=$(( $3 - 2 )):d=2" \
    $MONO $MP3 "$4"
}

BOOK="$OUT/Audiobooks/Imogen Hartley/The Lantern Keeper's Daughter"
mkdir -p "$BOOK"
common=(-metadata album="The Lantern Keeper's Daughter"
        -metadata artist="Imogen Hartley"
        -metadata album_artist="Imogen Hartley"
        -metadata genre="Audiobook" -metadata date="2024"
        -metadata composer="Imogen Hartley")
chapter 220 116 120 "$BOOK/01 - Chapter One.mp3"
chapter 262 116 120 "$BOOK/02 - Chapter Two.mp3"
chapter 330 116 120 "$BOOK/03 - Chapter Three.mp3"
chapter 392 116 120 "$BOOK/04 - Chapter Four.mp3"
# tags differ per file, so they are applied after generation:
for n in One Two Three Four; do :; done
ffmpeg -hide_banner -loglevel error -y -i "$BOOK/01 - Chapter One.mp3" \
  "${common[@]}" -metadata title="Chapter One" -metadata track="1/4" \
  -codec copy "$BOOK/.t.mp3" && mv "$BOOK/.t.mp3" "$BOOK/01 - Chapter One.mp3"
ffmpeg -hide_banner -loglevel error -y -i "$BOOK/02 - Chapter Two.mp3" \
  "${common[@]}" -metadata title="Chapter Two" -metadata track="2/4" \
  -codec copy "$BOOK/.t.mp3" && mv "$BOOK/.t.mp3" "$BOOK/02 - Chapter Two.mp3"
ffmpeg -hide_banner -loglevel error -y -i "$BOOK/03 - Chapter Three.mp3" \
  "${common[@]}" -metadata title="Chapter Three" -metadata track="3/4" \
  -codec copy "$BOOK/.t.mp3" && mv "$BOOK/.t.mp3" "$BOOK/03 - Chapter Three.mp3"
ffmpeg -hide_banner -loglevel error -y -i "$BOOK/04 - Chapter Four.mp3" \
  "${common[@]}" -metadata title="Chapter Four" -metadata track="4/4" \
  -codec copy "$BOOK/.t.mp3" && mv "$BOOK/.t.mp3" "$BOOK/04 - Chapter Four.mp3"

# --- a single-file .m4b with three embedded chapters -------------------
TIDES="$OUT/Audiobooks/Tomas Reyes/A Field Guide to Tides"
mkdir -p "$TIDES"
$FF -f lavfi -i "sine=frequency=294:duration=135" \
  -af "afade=t=in:st=0:d=2,afade=t=out:st=132:d=3" $MONO "$TIDES/.base.wav"
cat > "$TIDES/.chapters.txt" <<'EOF'
;FFMETADATA1
title=A Field Guide to Tides
artist=Tomas Reyes
album=A Field Guide to Tides
genre=Audiobook
date=2023
[CHAPTER]
TIMEBASE=1/1000
START=0
END=45000
title=Reading the Water
[CHAPTER]
TIMEBASE=1/1000
START=45000
END=90000
title=The Turning
[CHAPTER]
TIMEBASE=1/1000
START=90000
END=135000
title=What the Shore Keeps
EOF
$FF -i "$TIDES/.base.wav" -i "$TIDES/.chapters.txt" \
  -map_metadata 1 -map_chapters 1 -c:a aac -b:a 64k "$TIDES/A Field Guide to Tides.m4b"
rm "$TIDES/.base.wav" "$TIDES/.chapters.txt"

# --- a single-file book for the second library -------------------------
QUIET="$OUT/PrivateShelf/Wren Okafor/Quiet Hours"
mkdir -p "$QUIET"
chapter 196 176 180 "$QUIET/Quiet Hours.mp3"
ffmpeg -hide_banner -loglevel error -y -i "$QUIET/Quiet Hours.mp3" \
  -metadata title="Quiet Hours" -metadata album="Quiet Hours" \
  -metadata artist="Wren Okafor" -metadata album_artist="Wren Okafor" \
  -metadata genre="Audiobook" -metadata date="2025" -metadata track="1/1" \
  -codec copy "$QUIET/.t.mp3" && mv "$QUIET/.t.mp3" "$QUIET/Quiet Hours.mp3"

# --- podcast episodes + RSS feed ---------------------------------------
FEED="$OUT/feed"
mkdir -p "$FEED"
chapter 262 236 240 "$FEED/ep1.mp3"
chapter 294 236 240 "$FEED/ep2.mp3"
ffmpeg -hide_banner -loglevel error -y -i "$FEED/ep1.mp3" \
  -metadata title="Episode One - Departures" -metadata album="The Night Ferry" \
  -metadata artist="The Almanac Workshop" -codec copy "$FEED/.t.mp3" \
  && mv "$FEED/.t.mp3" "$FEED/ep1.mp3"
ffmpeg -hide_banner -loglevel error -y -i "$FEED/ep2.mp3" \
  -metadata title="Episode Two - The Crossing" -metadata album="The Night Ferry" \
  -metadata artist="The Almanac Workshop" -codec copy "$FEED/.t.mp3" \
  && mv "$FEED/.t.mp3" "$FEED/ep2.mp3"
EP1_SIZE=$(stat -c%s "$FEED/ep1.mp3"); EP2_SIZE=$(stat -c%s "$FEED/ep2.mp3")
# HOSTPORT is where you will serve this folder, e.g. 127.0.0.1:8899
HOSTPORT="${HOSTPORT:-127.0.0.1:8899}"
cat > "$FEED/feed.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
  <channel>
    <title>The Night Ferry</title>
    <link>http://$HOSTPORT/</link>
    <description>A slow podcast about crossings, timetables, and the
    people who keep the lights on. Invented for this guide's lab.</description>
    <language>en-us</language>
    <itunes:author>The Almanac Workshop</itunes:author>
    <itunes:explicit>false</itunes:explicit>
    <item>
      <title>Episode One - Departures</title>
      <description>Every crossing starts at a ticket window.</description>
      <pubDate>Mon, 06 Oct 2025 06:00:00 GMT</pubDate>
      <guid isPermaLink="false">night-ferry-ep1</guid>
      <itunes:duration>240</itunes:duration>
      <enclosure url="http://$HOSTPORT/ep1.mp3" length="$EP1_SIZE" type="audio/mpeg"/>
    </item>
    <item>
      <title>Episode Two - The Crossing</title>
      <description>Four minutes of water, weather, and a steady tone.</description>
      <pubDate>Mon, 13 Oct 2025 06:00:00 GMT</pubDate>
      <guid isPermaLink="false">night-ferry-ep2</guid>
      <itunes:duration>240</itunes:duration>
      <enclosure url="http://$HOSTPORT/ep2.mp3" length="$EP2_SIZE" type="audio/mpeg"/>
    </item>
  </channel>
</rss>
EOF
echo "fixtures written under $OUT"
