# Exercises — Testing Style

Create `testing_demo.zig` in this folder (or retrofit the Phase 1 suite in place — state your choice in answers).

## Must implement / demonstrate

1. Edge-table tests for one pure helper (e.g. `countWords` or `trimAsciiSpaces`): ≥6 cases in a table loop with behavioural test name.
2. GPA-clean test for one allocating helper (e.g. `buildSquares` or `Stack.push` sequence): explicit leak assert, `expectEqualSlices` on content.
3. Injected-failure test: same helper driven by a failing/tiny allocator; `expectError(error.OutOfMemory, ...)` (or your documented error) and proof of clean state (second call works / GPA clean / no partial ownership).
4. `expectError` coverage for every error arm of `tryParseU64`-class helpers (Empty, InvalidDigit, Overflow each triggered).
5. Phase 1 audit: list ≥3 test improvements you made to folders 02/04/05/06 (renamed test, added edge case, added leak assert, added failure path — be specific).

## Tests about tests (meta)
- Show `zig build test -Dtest-filter="<substring>"` selecting exactly your new tests (paste command + resulting test count).
- Every `test` name in this folder must read as a behaviour sentence.

## STRETCH
- Table-driven random-ish test: N pseudo-random inputs (fixed seed, e.g. `std.Random.DefaultPrng` seeded constant) asserting an invariant (e.g. `dedupSorted` output is sorted + shorter-or-equal). Fixed seed = reproducible.
- First `BENCH.md`: time one helper at two sizes with `std.time.Timer`; 3 lines of interpretation.
- Write the failing-allocator helper as a reusable snippet you will copy into Phase 2 (document where it will live).

## Notes
This folder is graded on the suite, not on new data structures. A strong audit of old folders beats a shiny new file with weak tests.
