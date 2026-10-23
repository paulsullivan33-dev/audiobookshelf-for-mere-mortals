# First Admin and Login

**Scope:** the first five minutes —
creating the first (root) account,
signing in, and what the token you get
back actually is. Everything here was
run against the real server; transcript
t01 is the proof.

## The first account is the root account

A fresh server has no users at all —
`/status` says `"isInit":false`. The
first account is created through a
one-time door: the `/init` call (the
web page shows the equivalent form the
first time you open it).

```
curl -X POST http://localhost:13378/init \
  -H 'Content-Type: application/json' \
  -d '{"newRoot":{"username":"maren","password":"..."}}'
```

Two quirks, both met live:

- The answer is **plain text** — the
  body is the word `OK` — not the JSON
  everything else on this server speaks.
- The door locks behind you. Run the
  same call again once an admin exists
  and the server answers **500**. That
  is the correct behaviour — `/init` is
  for the first account only — but the
  blunt error surprises people.

The account it makes has type `root`:
the administrator. It can create other
users, change server settings, and see
every library. Later accounts are
ordinary `user`s unless made otherwise
(chapter 8).

**Check:** `/status` now says
`"isInit":true`.

## Logging in

```
curl -X POST http://localhost:13378/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"maren","password":"..."}'
```

The answer has two halves worth
knowing:

```json
{
  "user": {"id": "...", "username": "maren",
           "type": "root", "token": "..."},
  "serverSettings": {"version": "2.37.1", ...}
}
```

- The **token** is your key. The web
  page stores it in the browser; the
  apps store it on the phone; scripts
  send it as an `Authorization: Bearer`
  header. Whoever holds the token is,
  as far as the server is concerned,
  that user — treat it like the
  password it replaces.
- `serverSettings.version` confirms,
  from inside a signed-in answer, the
  version the lab claims: **2.37.1**.

Transcripts redact tokens, and you
should too: they don't belong in
screenshots, scripts committed to
repositories, or chat messages.

## Losing the root password

Because the server is yours, so is the
way back in: the accounts live in the
config folder's store on your disk,
and the project's documentation covers
resetting a forgotten root password by
working on that store directly. This
guide didn't need it and didn't test
it — it is noted here so you know the
door exists before you need it, not
after.

## What to do next

Sign in through the web page once, with
the same account, and look around:
an empty server is a row of empty
shelves. The next chapter puts books
on them.
