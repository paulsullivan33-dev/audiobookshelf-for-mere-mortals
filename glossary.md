# Glossary

The terms this guide uses, collected in
one place. Each is explained in the
chapter that leans on it; these are the
short versions.

**API** — the programming interface the
server offers: a set of web addresses
(`/api/...`) that the web page, the
phone apps, and this guide's lab all
talk to. If a player can do it, the API
can do it.

**Chapter** — a named stretch of a
book, with a start and end time. Either
embedded in a single file or derived
from one-file-per-chapter arrangements
(chapter 6).

**Direct play** — the server sends the
audio file as it stands, because the
player can play it. The opposite of
transcoding, and nearly free for the
server.

**Enclosure** — the file a podcast
feed's episode entry points at: the
actual mp3 the feed promises. What the
server stores may differ slightly —
it rewrites the tags (chapter 9).

**Feed (RSS)** — the file a podcast
publishes listing its episodes and
their enclosures. Audiobookshelf reads
the feed to learn what exists, then
downloads the enclosures it wants.

**ffmpeg / ffprobe** — the standard
open-source audio tools the server
uses to measure files and to transcode.
Audiobookshelf v2.37 requires version
5.1.x of them, exactly.

**Item** — one entry in a library: a
book, a podcast, or an ebook, together
with everything the database knows
about it. The files on disk are the
item's substance; the item is the
server's record of them.

**Library** — a named collection: a
type (book, podcast, ebook), one or
more folders on disk, and rules about
who may use it.

**Metadata** — the facts about a book
or episode: title, author, year,
chapters, description, cover. For
audio, the ground truth starts as the
tags inside the files.

**Metadata provider** — the online
catalogue (Google Books by default)
that lookups match your items against
to fill in prettier metadata.

**Progress** — the record of where a
listener is in an item: current time,
the fraction heard, finished or not.
Kept on the server, per user — the
feature chapter 8 is about.

**Range request** — a player asking
for one slice of a file ("bytes
10000–10999") instead of the whole.
How seeking works; the server answers
206 with exactly the slice.

**Root** — the first account on a
server, and its administrator type.
Created once, through `/init`
(chapter 4).

**Scan** — the server walking a
library's folders, reading tags and
durations, and updating its database
to match the disk.

**Session** — one act of listening: a
player opens a playback session, plays,
reports positions, closes it. Progress
is what sessions leave behind.

**SSRF filter** — the server's refusal
to fetch addresses inside your own
network when following feeds and
links, guarding against being tricked
into probing it. It blocks localhost
until whitelisted (chapter 9).

**Token** — the key a login hands
back. Players carry it instead of the
password; whoever holds it is treated
as that user.

**Transcoding** — converting audio on
the fly, by ffmpeg, when a player
can't play the file directly. Works,
but costs CPU for the whole listen.
