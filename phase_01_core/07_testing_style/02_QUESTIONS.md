# Questions — Testing Style

1. Paste the two `test -Dtest-filter=` commands you ran and how many tests each selected. What naming convention keeps filters useful?
   > Your answer:

2. How does your GPA test prove zero leaks (exact assert / defer pattern)? Why is discarding the `deinit()` result weaker?
   > Your answer:

3. What failing allocator did you use, what exact error did it produce, and how did you prove clean state afterward?
   > Your answer:

4. List your Phase 1 audit fixes (folder → before → after) — at least three.
   > Your answer:

5. Which test in your suite would catch a use-after-free or double-free first, and how?
   > Your answer (if none yet — say so, and name the Phase 2 folder where you will add it):

6. What invariant would you fuzz first in Phase 2, and what is the oracle (GPA? differential vs std? sorted-ness)?
   > Your answer:
