# What Audiobookshelf Is

**Scope:** the mental model — a library
server for audiobooks and podcasts that
you run yourself, whose central trick is
remembering where every listener
stopped — plus what it is not, and the
lab this guide's claims rest on.

## The one-paragraph version

**Audiobookshelf** is open-source
software that turns a folder of audio
files on a computer in your house into
a proper listening library. It scans
the files, reads the tags inside them
— title, author, chapters — and serves
the result through a web page and phone
apps that feel like a small, private
Audible. Each person in the household
has their own account and their own
shelves. The difference from a shop's
app is where the books live and who
holds the keys: the files sit on your
disk as ordinary audio files, no
account with any company is involved,
and the listening progress — the thing
a shop locks inside its own app — is
yours, on your server.

That is the whole idea. The rest of
this guide is the fine print: the one
program that does it, the folders it
keeps, and the part people get wrong —
that progress, not playback, is the
feature worth having.

## The shape of the thing

Three pieces of the experience are
worth naming before any machinery:

- **Progress is the point.** Any player
  can play an mp3. What a ten-hour book
  needs is a bookmark that survives:
  stop in the kitchen, resume in the
  car, and the place is kept — per
  person, so two listeners can be at
  different chapters of the same book.
  Audiobookshelf keeps that place on
  the server and every player asks the
  server for it. Chapter 8 proves it,
  including across a server restart.
- **The files stay ordinary files.**
  Your books remain folders of mp3,
  m4a, or m4b files on a disk, readable
  by any program. Audiobookshelf reads
  them, indexes them, and streams them;
  it does not move them into a private
  format. If the server vanished
  tomorrow, the books would still be
  sitting there as files.
- **A library is a folder with rules.**
  You point the server at a folder and
  say what kind it is — audiobooks,
  podcasts, ebooks. Different folders
  can be shown to different people: a
  shared shelf for the house, a private
  shelf for one listener. Chapter 5
  builds them; chapter 8 fences them.

## What it is not

- **Not a shop.** It sells nothing and
  sources nothing. The books come from
  wherever you get audio files —
  rips of your own CDs, DRM-free shops,
  library sales — as files you place in
  a folder.
- **Not a tag editor, mostly.** It
  reads the tags in your files and can
  look up prettier metadata online, but
  the files' own tags are the ground
  truth it starts from. Chapter 6 is
  honest about what the lookups can do.
- **Not a sync tool.** It streams and
  it serves downloads to its apps; it
  does not keep folders in step between
  machines.

## The lab this guide rests on

The claims in these chapters were
checked against the real server:
**v2.37.1**, the project's current
release on build day (published
2026-09-29), installed from the
project's own Linux package. The bench
had no container runtime, so the
server ran directly from the package
rather than in Docker — the deviation
chapter 3 declares. The media was
invented for the purpose: four-chapter
and single-file books by authors who
don't exist, generated as tones with
correct tags by `examples/generate-fixtures.sh`,
and a two-episode podcast served from a
localhost feed. The listeners were
invented too. Transcripts of every
proof are in `audiobookshelf-lab/transcripts/`,
and `criteria.md` keeps the ledger of
what ran and what is documented only.
