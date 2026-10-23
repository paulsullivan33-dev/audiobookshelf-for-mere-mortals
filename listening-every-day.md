# Listening Every Day

**Scope:** the ordinary act the whole
machine exists for — pressing play in
the web player, how the audio actually
travels, seeking, and the direct-play
versus transcoding choice. The
streaming proofs are transcript t04;
the apps' side of it is chapter 8's
progress story.

## The web player

Open the server's page, sign in, pick a
book, press play. Under that plain
surface, three things happen that are
worth understanding, because every
other player — the phone apps included —
does the same three things through the
same API:

1. The player asks the server to open a
   **playback session** for the item
   (`POST /api/items/<id>/play`), saying
   what it is and what formats it can
   play directly.
2. The server streams the audio files
   to the player.
3. As you listen, the player reports
   your position back to the session,
   and the server keeps it (chapter 8).

## Streaming, verified byte for byte

The stream is the file. The lab asked
the API for the Lantern book's first
chapter file and compared:

```
HTTP 200, 960708 bytes, Content-Type: audio/mpeg
sha256 of served bytes : 6e040970…e1be
sha256 of file on disk : 6e040970…e1be
identical: True
```

No re-encoding, no wrapper: the bytes
served are the bytes on disk. (The full
hashes are in transcript t04.)

## Seeking: range requests

Skipping to the middle of a chapter
doesn't download the first half. The
player asks for a byte range, and the
server answers with exactly that slice:

```
Range: bytes=10000-10999
-> HTTP 206, 1000 bytes,
   Content-Range: bytes 10000-10999/960708
   slice identical to disk: True
```

This is the ordinary web mechanism for
seeking, and the lab verified the
server honours it precisely. On slow
connections it is the difference
between resuming in a second and
waiting a minute.

## Direct play versus transcoding

In the lab's session the server
reported **direct play**: the player
could play mp3, so the server simply
sent the file. When a player can't
play a file's format, the server can
instead **transcode** — convert on the
fly with ffmpeg — which is the other
job the version-5.1 ffmpeg of chapter 2
is kept for. Direct play costs the
server almost nothing; transcoding
costs CPU for as long as the book
plays. The practical advice follows:
a shelf of ordinary mp3/m4b files makes
a small server feel fast.

## Speed, sleep, and the small mercies

The web player offers the controls
daily listening actually uses: playback
speed, a sleep timer, chapter skipping,
and a bookmark button. Bookmarks are
yours per book and live server-side
like progress does. Their details are
the player's furniture rather than the
server's machinery, and this guide
leaves them to the five minutes of
pressing buttons that teaches them
better than a chapter can.

## Downloading for offline

The apps can download a book or episode
to the device for offline listening —
on a plane, say — and progress made
offline is reported back when the app
next reaches the server. That behaviour
belongs to the apps, which the lab had
no phone to run; it is documented here
and labelled as such in `criteria.md`.
What the lab proved is the server half
the apps rely on: sessions, streams,
and stored progress, all through the
API the apps speak.
