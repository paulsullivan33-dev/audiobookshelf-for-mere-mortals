# Chapters and Metadata

**Scope:** where a book's chapter list
and its tidy title page come from —
the two chapter sources the lab proved,
the metadata that travels inside
files, and an honest word about the
online lookups.

## Chapters, two ways

A long book needs seams. The lab's two
books had them in the two ways real
books do, and the server read both
correctly (transcript t03).

**Embedded chapters.** The Tides m4b
carried its chapter marks inside the
file — written there as part of the
file's own structure. The scan read
them back exactly:

```
"Reading the Water"    0 -> 45
"The Turning"         45 -> 90
"What the Shore Keeps" 90 -> 135
```

This is how well-made single-file
audiobooks arrive, and it is the best
outcome: titles and timings both
yours, preserved to the second.

**One file per chapter.** The Lantern
book had no embedded marks — just
four files. The server synthesised the
chapter list by tiling the files end
to end, taking each chapter's title
from the file's title tag:

```
"Chapter One"       0       -> 120.03
"Chapter Two"       120.03  -> 240.07
"Chapter Three"     240.07  -> 360.10
"Chapter Four"      360.10  -> 480.13
```

So a folder of well-tagged chapter
files needs nothing more. A folder of
*untagged* files still tiles — but the
chapters inherit bare filenames, which
is the difference between tags done
once, properly, and a shelf of
`track03.mp3`s. The server can also
hold chapter lists from other sources
(a `.cue`-style description or an
online match) in some flows; the lab
proved the two above and claims only
those.

## Metadata: the file is the source

Everything on the book's page — title,
author, narrator, year, series,
description, cover — starts from what
the files carry:

- **Title and author** from the album
  and artist tags (the lab's fixtures
  used album = book title, artist =
  author, and the scan agreed).
- **Year** from the date tag: 2024 and
  2023 read back exactly as written.
- **Duration** measured, not tagged:
  ffprobe's reading of the real files.
- **Cover** from an image embedded in
  the file, or an image file sitting in
  the book's folder.

In the expanded item view the lab
noticed the author list arrives as
structured `authors[]` entries whose
display name field sits elsewhere than
in the compact view — an API detail,
but the kind that breaks scripts
written from old examples. Prefer the
current API documentation over blog
posts: this server's API has changed
shape across versions (chapter 15
returns to this).

## The online lookups — documented, with a caveat

A book with thin tags can be *matched*
against an online provider (the lab's
libraries used the default, Google
Books; Audible and others are offered)
to fill in description, cover, and
series from the provider's catalogue.
That is a real feature and the web
page makes it two clicks — but this
guide labels it **documented-only**,
for an honest reason: the lab's books
are invented. "The Lantern Keeper's
Daughter" by Imogen Hartley exists
nowhere in any catalogue, so a lookup
could only ever miss or, worse, match
someone else's real book to the
fixture. On your real shelf, expect
the lookups to be good for well-known
books and patchy for obscure ones —
and check a match before accepting
it, because a wrong match dresses
your book in another book's clothes
until you fix it by hand.

## Editing by hand

The web page lets an admin edit every
field the scan filled — title, author,
series and position, description,
cover. Hand edits live in the server's
database; the files' tags are not
rewritten to match. Remember which is
the copy and which is the original:
if you ever rebuild the library from
scratch, the tags are what a fresh
scan will believe.
