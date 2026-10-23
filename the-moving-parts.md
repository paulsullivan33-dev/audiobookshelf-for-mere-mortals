# The Moving Parts

**Scope:** the pieces an Audiobookshelf
install is made of — one server program,
two data folders of its own, the media
folders it watches, and the two helper
tools it refuses to run without — and
what breaks when each piece stops.

## The short list

| Part | What it is | What it holds |
|---|---|---|
| The server | one program, `audiobookshelf` | serves the web page, the API, and the streams |
| Config folder | its settings store | users, libraries, server settings |
| Metadata folder | its working store | the library database, covers, backups, logs |
| Media folders | *your* folders | the book and episode files themselves |
| ffmpeg / ffprobe | helper tools, version 5.1 | reading durations and chapters; transcoding |

Compared with some of this series'
other subjects, this is a short list,
and that is a genuine virtue: there is
one program to start, and if it is
running, everything is running.

## The server

The server is a single self-contained
program. It serves the web client,
answers the API the apps speak, scans
libraries, downloads podcast episodes,
and streams audio — all of it. There is
no separate database server to install:
the library database is a file (SQLite)
inside the metadata folder, opened by
the server itself.

It listens on one port — **13378** is
the usual one inside Docker; the Linux
package uses the port you configure.
Everything, web page and API alike,
comes through that one door.

**Check:** a running server answers
without any login at all:

```
curl http://localhost:13378/status
{"app":"audiobookshelf","serverVersion":"2.37.1","isInit":true,...}
```

(lab transcript t00 — the version is
the server's own report of itself.)

## The two data folders

The server keeps everything it knows in
two folders, given to it as
`CONFIG_PATH` and `METADATA_PATH`:

- **Config** — the settings: user
  accounts, library definitions, who may
  see what. Small, precious.
- **Metadata** — the working store: the
  database of items, chapters, and
  progress; downloaded cover art; the
  server's own backup files; its scan
  logs. Bigger, still precious — the
  progress of every listener lives here.

Neither folder contains your books.
That separation is the whole backup
story in miniature (chapter 11): the
state is two folders, the media is
yours, and they are backed up
differently.

## The media folders

A *library* points at a folder (or
several) on disk. The server reads the
folder; it does not own it. Books are
usually arranged one folder per book
under an author folder —
`Author/Book Title/track files` — and
chapter 5 covers the arrangements the
scanner understands. The server writes
into media folders in exactly one
ordinary case: podcast episodes it
downloads land there (chapter 9).

## ffmpeg and ffprobe — with a version rule

To read a file's duration and chapters,
and to transcode when a player can't
play a file directly, the server uses
the standard tools **ffmpeg** and
**ffprobe** — and v2.37 insists on
exactly **version 5.1.x** of them.

The lab learned this the direct way:
the build machine had ffmpeg 8.1.2
installed, and the server rejected it
as "not a valid version" and would not
start cleanly. On a normal install this
solves itself — where the server finds
no acceptable ffmpeg, it downloads the
right static builds on first run (and
the Docker image simply bundles them).
The lab's sandbox blocked that
download, so the lab placed the 5.1.1
static builds where the server looks
and pointed `FFMPEG_PATH` and
`FFPROBE_PATH` at them. The rule itself
is worth remembering on any install:
if a scan reports nonsense durations,
or playback won't start, check the
ffmpeg version first. Chapter 15 lists
it as a symptom.

A third small library rides along:
the server also manages its own copy of
**libnusqlite3**, the SQLite build it
uses, in the same self-installing way.

## What breaks when a piece stops

- **Server stopped:** nothing plays,
  nothing syncs — but nothing is lost.
  Progress is in the metadata folder,
  not in the running program. The lab
  stopped and restarted the server
  mid-book and read the same position
  back (transcript t06).
- **Media folder unplugged:** items
  show as missing; progress is kept.
  Plug it back and rescan.
- **Metadata folder lost:** the real
  disaster — users, libraries, and
  every listener's place. That's what
  the backup in chapter 11 is for.
