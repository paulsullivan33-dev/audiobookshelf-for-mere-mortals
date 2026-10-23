# Installing

**Scope:** the two honest ways to put
Audiobookshelf on a machine — the
Docker route most people take, and the
Linux package the lab ran — what each
leaves on your disk, and the lab's
declared deviation.

## Before you start

You need one machine that stays on
while anyone listens — a small home
server, a NAS, a spare laptop. The
server itself is light: the program and
its database are small, and the disk
space that matters is your media's.
You also need your audio files
somewhere the machine can read them.

## Route 1: Docker (the usual way)

*Documented — the lab's bench had no
container runtime, so this route is
written from the project's own install
documentation and labelled as such in
`criteria.md`. The server it installs
is the same program the lab ran.*

The project publishes an official
image, `ghcr.io/advplyr/audiobookshelf`,
and a compose file in its
documentation. The shape is the usual
one:

```yaml
services:
  audiobookshelf:
    image: ghcr.io/advplyr/audiobookshelf:latest
    ports:
      - 13378:80
    volumes:
      - /path/to/audiobooks:/audiobooks
      - /path/to/podcasts:/podcasts
      - /path/to/config:/config
      - /path/to/metadata:/metadata
```

Four mounts, each doing one job from
chapter 2: your media folders in, the
server's two data folders out to real
folders on your disk so they survive
the container. Inside the container the
server listens on port 80; the compose
file publishes it as 13378. The image
bundles the right ffmpeg, which is one
good reason this is the route most
people take.

```
docker compose up -d
curl http://localhost:13378/status
```

**Check:** `/status` answers with the
version and `"isInit":false` — false,
because no admin exists yet. Chapter 4
fixes that. Pinning the image to a
version (`audiobookshelf:2.37.1`)
instead of `latest` is the cautious
choice: upgrades then happen when you
choose, not when a container restarts.

## Route 2: the Linux package (the lab's way)

*Ran for real — this is the install
every transcript in this guide came
from.*

The project also publishes a `.deb`
from its own package repository. The
lab fetched **audiobookshelf
2.37.1** — `audiobookshelf_2.37.1_amd64.deb`
— and checked the download's SHA-256
against the repository's own package
index before installing
(`25804f60…cdcb2a`, recorded in
`examples/lab-notes.txt`). Checking a
hash against the publisher's index is
a habit worth keeping for any package
that doesn't come from your
distribution.

The package is spare: one program file
and a systemd unit. On a normal machine
you would install it and start the
service:

```
sudo apt install ./audiobookshelf_2.37.1_amd64.deb
sudo systemctl start audiobookshelf
```

and then set the two data folders and
the port in its environment (the
package's defaults live in
`/etc/default/audiobookshelf`). The
server creates what it needs inside
the folders on first run.

### The lab's deviation, declared

The lab's sandbox is not a normal
machine: no systemd, and no route for
the server's first-run downloads. So
the lab unpacked the package and ran
the same program file directly, with
the environment set by hand:

- `CONFIG_PATH` and `METADATA_PATH`
  pointed at folders in the lab;
- `PORT=13378`;
- `FFMPEG_PATH` / `FFPROBE_PATH` pointed
  at the static **5.1.1** builds the
  server requires (chapter 2 explains
  the version rule), because the system
  ffmpeg 8.1.2 was rejected and the
  server's own download was blocked;
- `NUSQLITE3_PATH` likewise, for its
  SQLite library.

Same program, same version, same API —
started by hand instead of by systemd,
with its self-install step done for it.
Every claim in this guide rests on
that server; nothing about the
deviation changes what the API proved.

There is also a Windows installer and
there are community packages for
several NAS lines; this guide doesn't
cover them beyond noting they exist —
the server and the API are the same
once any of them is running.

## After it starts

However you installed it, the sequence
from here is one chapter each: make
the first account (chapter 4), add a
library and scan it (chapter 5), and
listen (chapter 7). If `/status` won't
answer at all, chapter 15 starts with
the short list of reasons.
