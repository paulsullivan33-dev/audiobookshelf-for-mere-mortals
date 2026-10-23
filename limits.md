# Limits

**Scope:** what Audiobookshelf can't
do, won't do, or does thinly — stated
plainly, so the rest of the guide can
be trusted where it praises.

- **It sources nothing.** No shop, no
  catalogue, no ripping. Files arrive
  by your hand, from your own sources.
- **DRM stays locked.** Books bound to
  a shop's DRM won't play here, and the
  server makes no attempt at them. It
  serves files that are actually
  playable files.
- **Metadata lookups are a
  convenience, not a truth.** Online
  matches can be wrong, and are
  unavailable in principle for books no
  catalogue knows (chapter 6). Thin or
  odd collections will need hand edits.
- **The ffmpeg rule is strict.**
  Version 5.1.x or the server refuses
  the tools (chapter 2). Installs that
  supply their own ffmpeg outside the
  official image or package can trip on
  this in ways that look like other
  bugs.
- **The API moves.** v2.37 changed
  shapes the lab relied on finding —
  an ignored field in podcast creation,
  a differently shaped item view, an
  auth endpoint gone (chapter 15).
  Scripts pinned to old examples will
  break across upgrades; the current
  API documentation is the reference.
- **Progress is per account, full
  stop.** Two people sharing one login
  share one place in every book. There
  is no sub-profile inside an account.
- **One server, one household,
  roughly.** It is a single program
  with a file database: right-sized
  for a home and a small circle, not
  a public service for thousands.
- **Offline listening belongs to the
  apps.** The server itself doesn't
  sync files to devices outside its
  own apps' downloads (documented,
  chapter 7).
- **Receivers and casting** —
  Chromecast and friends — are
  client features, vary by app, and
  are documented-only in this guide;
  the lab had no receiver to prove
  them against.
- **The ebook side is a companion,**
  not a deep library tool (chapter
  10): honest for a small shelf,
  outclassed by dedicated ebook
  software at scale.
- **Backups are split by design.**
  The server's backup holds state, not
  media (chapter 11). Anyone who
  believes the one file is the whole
  backup will learn otherwise on the
  worst day.
