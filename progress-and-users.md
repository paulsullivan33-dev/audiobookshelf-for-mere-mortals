# Progress and Users

**Scope:** the feature the product is
loved for — listening progress kept on
the server, per person — proved end to
end, including across a restart; and
the user accounts it hangs from,
including the fencing test and the one
trap in creating a user.
Transcripts t05, t06, and t07.

## Progress, proved

The lab opened a playback session for
the Lantern book, reported a position
of **185 seconds** part-way into the
book, closed the session, and read the
progress back:

```
POST /api/items/<id>/play            -> 200
POST /api/session/<id>/sync   {currentTime: 185.0} -> 200
POST /api/session/<id>/close  {currentTime: 185.0} -> 200
GET  /api/me/progress/<id>           -> 200

  "duration":    480.130612,
  "currentTime": 185,
  "progress":    0.38531182…
  "isFinished":  false
```

The arithmetic is plain: 185 / 480.13 =
0.3853 of the book heard. That record —
not the player — is what "continue
listening" is built from, and any
player that signs in as you sees it.

## It survives a restart

Then the lab stopped the server
process entirely and started it again,
and read the position back on the
fresh server (transcript t06): same
record, same 185 seconds, same
fraction.

This is the whole argument for a
server in one small proof. Progress
that lives in an app dies with the
phone; progress that lives in a file
on a player dies with the player.
Progress in the server's database is
just there, for every device, after
every restart, until you mark the book
finished.

## Users

The root account (chapter 4) creates
the household's accounts. Each user
has:

- a **type** — `root`, `admin`, or
  ordinary `user`;
- a list of **libraries they may use**;
- their **own progress, bookmarks, and
  shelves** — two listeners never share
  a place in a book unless they share
  an account, which is why everyone
  gets their own.

## The fencing test

The lab created a second user, **theo**,
an ordinary `user`, allowed into the
Audiobooks library only — and then
tried to walk him through the fence
(transcript t07):

```
theo GET /api/libraries            -> 200: ["Audiobooks"]
theo GET Audiobooks items          -> 200: 2 items
theo GET the Private Shelf book    -> 403 Forbidden
theo GET Private Shelf items       -> 403 Forbidden
```

The fencing is a flat **403**, worth
noting precisely: the server doesn't
pretend the book doesn't exist (a 404);
it says no. For a household shelf that
is the right behaviour — and it means
a mistyped link fails loudly rather
than silently.

## The trap in creating a user

Found live: a newly created user
arrives with **`accessAllLibraries`
set to true**, whatever library list
you created them with. Until an admin
turns that off (the lab did it with a
`PATCH` to the user), the per-library
list means nothing and the new user
sees everything.

So the safe order for a restricted
account is: create the user, turn off
access-all, then check the library
list — and then *verify as that user*,
as the lab did, before handing the
account over. A permission you haven't
tested as the person it binds is a
hope, not a setting.
