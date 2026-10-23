# Backing Up

**Scope:** keeping an Audiobookshelf
safe — the server's own one-file
backup, why it is only half the job,
and the order to restore in. The backup
file itself was made and inspected
live (transcript t10); a full restore
was not performed and is labelled as
such.

## The half the server does for you

The server will pack its whole state
into a single file:

```
curl -X POST http://localhost:13378/api/backups \
  -H 'Authorization: Bearer <token>'
```

and the file lands in the metadata
folder:

```
<METADATA_PATH>/backups/
  2026-10-23T0045.audiobookshelf   (21,609 bytes)
```

Small, because of what is in it: the
database — users, libraries, items,
and every listener's progress — and
the server's settings. The web page
offers the same action, and backups
can be scheduled in the server's
settings. **Check:** make one, look in
the folder, see the file. If that
folder is empty on a server that's
been running a month, nobody has ever
backed this server up, whatever the
intention was.

## The half it doesn't

The backup file contains **no media**.
Not the books, not the downloaded
podcast episodes, not the covers
folder's full bulk. That is not a flaw
— the media are ordinary files in
ordinary folders, and ordinary file
backup is the right tool for them —
but it means "I have the backup on"
is half a sentence. The whole sentence
is:

- the server's backup file (or the
  config and metadata folders whole),
  **plus**
- the media folders, backed up as
  files.

Your books were probably the expensive
half to gather; treat them that way.

## Restoring

*Documented — the lab made and verified
backups but did not perform a restore,
and says so.*

Restoring is the reverse of the split:
install the server fresh, put the
media folders back where the library
definitions expect them, and restore
the backup from the server's settings
page (or place the config and metadata
folders before first start). The order
that matters: state first, scan second
— give the restored server its
database before asking it to look at
the shelves, so it recognises its own
library instead of building a new one
beside it.

Then do the check nobody does: sign in
as a listener — not the admin — and
confirm a half-finished book is still
half-finished. Progress is the thing
you were protecting; verify the thing,
not the file.

## A schedule that fits

Backups earn their keep when they are
boring: the server's scheduled backup
for its state, your ordinary file
backup sweeping the media folders, and
both going somewhere that isn't the
same disk. Chapter 12's fifth recipe
writes one down end to end.
