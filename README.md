# Science Mayhem

A live science quiz race for the classroom, built from the Math Mayhem times table game. Everyone races on the same questions, wrong answers show the right one, and anyone who falls behind gets easier questions to catch up.

- Live rooms with a 4-letter code, solo practice, a racetrack, live standings and a comeback boost for players who fall behind.
- 90-second rounds, multiple choice (press 1 to 4 on a keyboard or tap).
- Every student has a **topic** and a **stage**, which the teacher sets in Teacher tools:
  - Topics: The periodic table, Periodic table: names and symbols (a quick drill, worth 80% of the points), States of matter, Plant and animal cells, and Mixed (a bit of everything from the three main topics).
  - Stages: Lower secondary (10 points per answer) and IGCSE (15 points per answer).
  - The comeback boost uses easier questions from the student's own stage. The biggest boost uses the easiest lower-secondary questions.
- Profiles, class lists, a leaderboard and teacher tools (PIN protected), same as the maths game.

## How it is built
- `index.html` is the whole game in one file. It talks to its own Supabase project (`science-mayhem`) using the public key, and can only call the game's `sci_*` functions.
- `database/1_setup.sql` creates the tables and functions. Run it once in the Supabase SQL Editor.
- `database/2_teacher.sql` makes you the teacher. Put your own PIN in it and run it once.
- `database/3_add_symbols.sql` adds the names and symbols topic to the allowed topics. Run it once.

## The questions
All 492 questions are in `index.html`, in the `BANK_TEXT` block in `index.html` (search for it), one per line:

`stage+difficulty | question | right answer | wrong 1 | wrong 2 | wrong 3`

The codes are `k1` and `k2` (lower secondary, easier and harder) and `i1` and `i2` (IGCSE, easier and harder). Easier questions (`k1`, `i1`) are what the comeback boost uses. Add a line to add a question. Question numbers (`pt12`, `st5`, `ce40`) come from the order of the lines in each topic, so add new questions at the end of a topic, not in the middle, or students' saved "tricky questions" will point at the wrong ones.

To add a new topic, add it to `TRACKS`, `TOPICS`, `TOPIC_PRE` and `BANK_TEXT` in `index.html`, and add its id to the allowed-topic list in the three SQL functions (`sci_admin_import`, `sci_admin_set_level`, `sci_profile_apply_round`).

## Publishing
Turn on GitHub Pages for this repo (Settings, Pages, deploy from branch `main`, folder `/`). Then edit `index.html` and push to `main`; the site republishes within a minute.
