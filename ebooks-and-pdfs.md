# Ebooks and PDFs

**Scope:** the server's smaller second
job — libraries of ebook files, read in
the browser or sent to an e-reader.
This chapter is **documented-only**: the
lab built no ebook fixture and ran
none of this; it is written from the
project's documentation and labelled
in `criteria.md`. It is here because a
guide that pretended the feature
didn't exist would be less useful than
one that marks its own boundary.

## What the feature is

A library whose type is ebook holds
files — EPUB, PDF, and their kin —
instead of audio. The shape is the
same as an audiobook library: point it
at a folder, scan, and the files appear
as items with their own metadata
(title, author, cover where the format
carries one). Mixed folders can hold a
book and its ebook together in some
arrangements; the project's
documentation draws those lines.

## Reading

The web client includes a reader:
EPUBs open in the browser as pages, and
PDFs render there too. Reading
progress is tracked the way listening
progress is — the progress record the
lab read in transcript t05 carries
ebook fields (`ebookLocation`,
`ebookProgress`) alongside the audio
ones, which is the one piece of this
chapter the lab did touch: the fields
exist in the real record, empty for an
audiobook, waiting for an ebook.

There is also a "send to device" route
for e-readers by email in the
project's feature set. It depends on
mail settings this guide doesn't
cover and the lab didn't configure.

## Honest assessment

For most households this feature is a
companion, not the main event: the
server's centre of gravity is audio,
and dedicated ebook tools (a calibre
library, a standalone reader app) go
deeper on libraries of thousands of
books. Where Audiobookshelf's ebooks
earn their place is the small shelf —
the PDF of the manual, the EPUB that
goes with the audiobook — kept in the
same house, under the same accounts,
with the same progress keeping. Judge
it as that, and it is genuinely handy.
Judge it as a calibre replacement and
you'll be disappointed, which is a
matter of aim, not quality.
