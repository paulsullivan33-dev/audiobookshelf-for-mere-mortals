# Troubleshooting

**Scope:** symptom → likely cause →
fix. Every entry here was either hit
for real in this guide's lab or follows
directly from something it proved;
the lab ones say so.

## The server won't answer at all

**Symptom:** `curl .../status` refused
or times out.
**Cause:** the server isn't running, or
isn't on the port you think.
**Fix:** check the process (or
`docker compose ps`); the port is 13378
published by the compose route, and
whatever `PORT` says on the package
route. Until `/status` answers, no
other troubleshooting means anything.

## Scans finish but durations are zero or nonsense

**Symptom:** items appear with missing
or absurd durations; the log complains
about ffmpeg. *(Lab: hit for real.)*
**Cause:** the ffmpeg/ffprobe on the
machine is not **version 5.1.x**, and
v2.37 rejects other versions outright —
the lab's 8.1.2 was refused as "not a
valid version."
**Fix:** let the server use its own
bundled tools (the Docker image does);
on a package install, point
`FFMPEG_PATH` / `FFPROBE_PATH` at 5.1.x
builds. Check the version before
blaming the files.

## /init answers 500

**Symptom:** creating the first
account fails with a bare 500.
*(Lab: hit for real.)*
**Cause:** an admin already exists —
`/init` is a one-time door and this is
its locked face.
**Fix:** log in as the existing root
user, or reset the root password by
the project's documented route
(chapter 4). Don't reinstall over it.

## A new user can see every library

**Symptom:** you restricted a user to
one library, but they see them all.
*(Lab: hit for real.)*
**Cause:** new users are created with
`accessAllLibraries = true`, which
overrides the list you set.
**Fix:** turn access-all off on the
user, then verify by signing in *as
them* (chapter 8). This is the single
most likely permissions surprise on a
new install.

## A podcast feed won't parse

**Symptom:** adding a feed fails; the
server log says a call to 127.0.0.1 (or
another internal address) is blocked.
*(Lab: hit for real.)*
**Cause:** the SSRF request filter is
doing its job — it refuses to fetch
internal addresses.
**Fix:** for a genuinely internal feed,
add the host to
`SSRF_REQUEST_FILTER_WHITELIST` and
restart. For a public feed failing
this way, suspect the URL: it may be
redirecting somewhere internal.

## The podcast exists but has no episodes

**Symptom:** created the podcast, got
no episodes, and "check for new" finds
none either. *(Lab: hit for real,
twice over.)*
**Cause:** two separate behaviours —
adding a podcast doesn't backfill
episodes older than the add, and in
v2.37.1 the create call's
`episodesToDownload` list is silently
ignored.
**Fix:** fetch episodes explicitly with
`POST /api/podcasts/<id>/download-episodes`
(or the web page's download controls).
New episodes from then on arrive by
the normal check.

## A downloaded episode's size doesn't match the feed

**Symptom:** the episode file is a few
hundred bytes larger than the
enclosure. *(Lab: measured — 341
bytes.)*
**Cause:** the server rewrites the
episode's tags on download. Expected.
**Fix:** none. Compare against the file
on disk, not the enclosure, when
checking streams (t09 shows both).

## A script breaks against the API

**Symptom:** code written from an old
example throws on a response's shape,
or a call 404s that "used to work."
*(Lab: hit for real, three times.)*
**Cause:** the API has changed across
versions: `GET /api/libraries` returns
an object holding the array, the
expanded item view's fields differ
from the compact one, and
`GET /api/authorize` no longer exists
in v2.37 (the auth system changed in
2.26).
**Fix:** code against the current API
documentation for your server's
version; read one real response before
writing the parser.

## Chapters show as filenames, or the book is one blob

**Symptom:** chapter list reads
`track03`, or a multi-file book shows
a single entry with no seams.
**Cause:** the files carry no title or
track tags, or the book's files aren't
in one folder (chapter 5's grouping
rule).
**Fix:** tag the files once (title,
track, album, artist), one folder per
book, rescan.

## Your place in a book moved by itself

**Symptom:** progress jumps to a point
you never reached.
**Cause:** almost always a shared
account — someone else listened as
you. Progress is per account
(chapter 8).
**Fix:** one account per listener.
There is no version of the server
setting that separates two people
sharing one login.
