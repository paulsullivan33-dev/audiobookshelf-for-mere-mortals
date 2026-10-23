# Libraries and Scanning

**Scope:** pointing the server at a
folder, running a scan, and reading
what the scan made of it — the two
fixture books, checked tag by tag
against what was written into them.
Transcripts t02 and t03 are the proof.

## A library is a folder plus a type

Creating a library names it, says what
kind of media it holds (`book`,
`podcast`, or ebook), gives it one or
more folders, and picks a *metadata
provider* — the online source used for
lookups (chapter 6). The lab created
three:

| Library | Type | Folder |
|---|---|---|
| Audiobooks | book | `media/Audiobooks` |
| Private Shelf | book | `media/PrivateShelf` |
| Podcasts | podcast | `media/Podcasts` |

via `POST /api/libraries`, as the root
user. One API wrinkle, met live:
`GET /api/libraries` answers with an
**object holding a `libraries` array**,
not a bare array — scripts written
against a bare list break on it.

## The fixture shelves

The Audiobooks folder held two invented
books, built by `examples/generate-fixtures.sh`:

- **The Lantern Keeper's Daughter** by
  Imogen Hartley — four mp3 files, one
  per chapter, each tagged with title,
  track number, album, artist, year.
- **A Field Guide to Tides** by Tomas
  Reyes — one m4b file with three
  chapters embedded in it.

Private Shelf held one single-file
book, **Quiet Hours** by Wren Okafor —
kept apart on purpose, for chapter 8's
fencing test.

## The scan

```
curl -X POST http://localhost:13378/api/libraries/<id>/scan \
  -H 'Authorization: Bearer <token>'
```

answers 200 `OK`, and the work happens
behind it: the server walks the folder,
groups files into books, reads every
file's tags and duration with ffprobe,
and writes the result into its
database. Scans are safe to repeat —
the lab re-ran them for the transcripts
and the server reported 0 added,
0 updated, 0 missing: it recognised its
own work.

**Check:** the library now lists items,
with the tags you wrote:

```
"The Lantern Keeper's Daughter" by Imogen Hartley — 480.13s
"A Field Guide to Tides" by Tomas Reyes — 135s
```

Four 120-second files make a 480.13s
book (the extra fraction is the real
encoded length of each file — the scan
measures files, it doesn't trust
round numbers). The single m4b reads
back at exactly its 135s.

## How files become a book

The grouping rule that matters: **one
folder, one book**, with the files
inside it as its parts, ordered by
track tag and then by filename. The
arrangement that works everywhere is:

```
Author Name/
  Book Title/
    01 - Chapter One.mp3
    02 - Chapter Two.mp3
```

A single file alone in its folder is a
single-file book, like the Tides m4b
and Quiet Hours. Loose files straight
in the library root are the arrangement
most likely to group in ways you
didn't mean; give every book its
folder.

## What a scan does not do

- It does not move or rename your
  files. The folder after a scan is the
  folder before it.
- It does not fix bad tags. A book
  whose files say nothing about
  themselves arrives as a near-blank
  item; chapter 6 covers the lookups
  that can dress it, and their limits.
- It does not re-read unchanged files
  forever: rescans are quick because
  the server tracks what it has seen.

New files dropped into a watched
folder are picked up on the next scan;
you can ask for one from the web page
or the API whenever you add a book.
