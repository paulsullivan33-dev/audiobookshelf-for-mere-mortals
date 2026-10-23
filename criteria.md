# Writing Criteria

Every guide in this repo is written to the same
standard. If you're adding or editing a guide —
human or AI — hold it to these.

1. **Plain words, real ideas.** Simple language,
   never dumbed-down concepts. Explain jargon on
   first use; collect terms in the glossary.
2. **No hype.** No marketing adjectives, no
   "revolutionary," no promises about what
   something will do for the reader.
3. **Honest about limits.** Say what the thing
   *can't* do. State uncertainty instead of
   smoothing it over. Validation notes include
   what remains unverified.
4. **No invented numbers.** Benchmarks, defaults,
   and specs are either measured or qualified with
   "depends on your setup." If it wasn't tested,
   say so.
5. **Checkable.** Commands are meant to be run,
   with "Check:" blocks showing what success looks
   like. Sources are linked, not asserted.
6. **Respect the reader's setup.** Call out
   Windows/Mac/Linux differences. Don't assume a
   GPU, a budget, or prior experience.
7. **Safety isn't skipped.** Real risks get
   stated plainly, not buried.
8. **Scoped.** Each guide says what it covers and
   points elsewhere for the rest. No guide
   pretends to be the whole subject.
9. **Structure over prose.** Tables, before/after
   examples, symptom → fix. Scannable beats essay.

## Verification notes for this guide

Built and verified 2026-10-22 (lab clock) against
**Audiobookshelf v2.37.1** (GitHub release
published 2026-09-29, the current release on
build day).

**Install source, checked:** the official `.deb`
from the project's own package repository
(`advplyr.github.io/audiobookshelf-ppa`),
`audiobookshelf_2.37.1_amd64.deb`, SHA-256
`25804f60fa14c29c36dca43ec68f8191b4c702e44218ab6f1ee50a6473cdcb2a`
verified against the repository's Packages index
before install. The build machine's sandbox has
no container runtime and no systemd, so the
package's program was run directly with its
environment set by hand — the deviation chapter 3
declares. All media and people are invented:
books and episodes synthesised with ffmpeg as
tagged tones (`examples/generate-fixtures.sh`),
listeners invented, the podcast feed authored by
the lab and served from localhost.

**Ran for real** (transcripts in
`audiobookshelf-lab/transcripts/`):

- t00 — `GET /status` → `serverVersion: 2.37.1`,
  `isInit: true`; the web UI serves, title
  "Audiobookshelf."
- t01 — first (root) account created through
  `POST /init` on the empty server (plain-text
  `OK`; re-run after init → 500); `POST /login`
  returns a working token and
  `serverSettings.version: 2.37.1`.
- t02 — two book libraries and one podcast
  library created; scans run; re-scan reports
  0 added / 0 updated / 0 missing. Items read
  back with the fixture tags (titles, authors,
  years 2024 and 2023) and measured durations
  (480.13s multi-file book; 135s m4b).
- t03 — chapters both ways: the m4b's three
  embedded chapters read back exactly
  (0–45 / 45–90 / 90–135, titles intact); the
  four-file book's chapters synthesised by
  tiling, 0 → 480.13s.
- t04 — streaming: full chapter file served at
  960,708 bytes, SHA-256 identical to the file
  on disk; a `Range: bytes=10000-10999` request
  answered 206 with the byte-identical slice.
- t05 — progress: play session opened,
  `currentTime 185.0` synced and closed;
  `GET /api/me/progress/<id>` shows
  currentTime 185, progress 0.3853 of 480.13s,
  `isFinished: false`.
- t06 — the server process was killed and
  restarted; the same progress record read back
  unchanged on the fresh server.
- t07 — second user (`user`, not root) fenced:
  sees only the library granted; the private
  library's item and item list answer **403
  Forbidden**. Found live: new users default to
  `accessAllLibraries: true`; the admin had to
  turn it off first.
- t08 — podcast feed parsed from a local fixture
  RSS (after whitelisting 127.0.0.1 against the
  server's SSRF filter, which blocked it by
  default). Found live: adding a podcast does
  not backfill older episodes, and the create
  call's `episodesToDownload` is silently
  ignored in v2.37.1.
- t09 — both episodes downloaded via
  `POST /api/podcasts/<id>/download-episodes`;
  episode one streamed back SHA-256-identical
  to the downloaded file. Measured: the
  downloaded file is 341 bytes larger than the
  feed enclosure — the server rewrites episode
  ID3 tags on download.
- t10 — `POST /api/backups` produced a real
  backup file in the metadata folder
  (21,609 bytes).

Also measured along the way: the server rejects
any ffmpeg/ffprobe but **5.1.x** (the system
8.1.2 was refused as "not a valid version"); on a
normal install it self-downloads the right
builds, which the sandbox blocked, so the lab
supplied the official 5.1.1 static builds and
libnusqlite3 via `FFMPEG_PATH` / `FFPROBE_PATH` /
`NUSQLITE3_PATH`. `GET /api/authorize` returns
404 in v2.37 (auth changed in 2.26).

**Documented only** (labelled in the chapters
that touch them):

- **The Docker route** — no container runtime on
  the bench; chapter 3 writes it from the
  project's own install documentation. The
  server binary it would run is the one the lab
  ran.
- **The iOS and Android apps** — no phone on the
  bench. Everything the apps depend on (login
  tokens, sessions, streaming, range requests,
  server-side progress) was proven through the
  API they speak.
- **Online metadata lookups for real books** —
  the fixtures are invented, so no catalogue can
  match them; a lookup test could only prove a
  miss. Chapter 6 says what to expect.
- **Ebook and PDF libraries** (chapter 10) — no
  ebook fixture was built; written from the
  project's documentation. The progress record's
  ebook fields were seen, empty, in t05.
- **Chromecast and receiver playback** — no
  receiver on the bench.
- **Restore from backup** — backups were created
  and inspected; no restore was performed.
- **Root password reset** — noted as existing in
  chapter 4; not performed.
