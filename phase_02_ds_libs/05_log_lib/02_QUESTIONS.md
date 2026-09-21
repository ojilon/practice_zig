# Questions — Tiny Logging Library

1. Why does the library hold no global state? Who owns the `Logger` and the sink in a real app?
   > Your answer:

2. Who owns the `scope` string, and what happens if it dies before the logger? How did you test/document this?
   > Your answer:

3. What is your full-sink policy (truncate / error / drop-with-counter), and which real tool wants each one?
   > Your answer:

4. How does level filtering avoid formatting work for suppressed messages? (Point at the mechanism.)
   > Your answer:

5. What did `std/log.zig` do differently (global/comptime/scopes), and why is your explicit-`Logger` design better for this dojo's tools?
   > Your answer:

6. Which Phase 4 tool will import `p02_log` first, and what will its min-level default be?
   > Your answer:
