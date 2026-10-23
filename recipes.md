# Recipes

**Scope:** five complete setups, each
written as steps with the check that
proves it worked. They assemble pieces
from the earlier chapters and say
which parts the lab ran and which are
the documented form.

## 1. The standing install

*For: one machine, a shelf of books,
listening in the browser.*

1. Install by Docker (chapter 3),
   media folder mounted in, config and
   metadata folders mounted out to real
   disk.
2. Create the root account (chapter 4).
3. Add the folder as a book library;
   scan (chapter 5).
4. Press play in the web player.

**Check:** `/status` names your
version, the scan lists your books with
their real durations, and a chapter
streams. The lab ran every step of
this except the container wrapper.

## 2. The household library

*For: a family, one shared shelf, some
private ones.*

1. Recipe 1, standing.
2. One library per audience: a shared
   `Audiobooks`, a private shelf per
   adult who wants one.
3. An account per person. For each
   restricted account, turn off
   `accessAllLibraries` *before*
   handing it over (chapter 8's trap).
4. Sign in as each person once
   yourself and look at their shelves.

**Check:** as a restricted user you
see only your libraries, and asking
for a book outside them answers 403 —
the lab's fencing test (t07), done on
your own names.

## 3. The podcast corner

*For: shows you want kept, not just
heard.*

1. A podcast library on its own
   folder.
2. Add each show by its feed URL
   (chapter 9). Remember: it collects
   from today forward — fetch older
   episodes explicitly if you want
   them.
3. Let episodes download to the
   library folder; they stream and
   keep progress like books.

**Check:** the show's folder holds
episode files, one per episode, and an
episode plays from the server. If a
feed on your own network won't parse,
chapter 15 has the SSRF entry.

## 4. The tidy shelf

*For: a folder of downloads becoming a
library.*

1. Arrange before you scan: one folder
   per book under its author
   (chapter 5), chapter files numbered.
2. Tag once, properly — title, track,
   album, artist — with the tag editor
   of your choice, *before* the first
   scan. Ten minutes of tags beats a
   season of fixing the shelf.
3. Scan, then read the shelf as a
   stranger: anything titled like a
   filename is a tag you skipped.

**Check:** every chapter list reads as
titles, not filenames (chapter 6), and
durations are sensible numbers, not
zeros — zeros mean chapter 15's ffmpeg
entry.

## 5. The Sunday backup

*For: never thinking about chapter 11
again.*

1. Turn on the server's scheduled
   backup in its settings.
2. Your machine's ordinary file backup
   sweeps three things: the metadata
   folder (or wherever the backup files
   land), the config folder, and every
   media folder.
3. Once, do chapter 11's listener
   check: sign in as a listener and
   confirm a place is kept.

**Check:** a backup file exists with a
recent date in the backups folder, and
your file backup's last run names the
media folders. Two checks, two halves,
whole sentence.
