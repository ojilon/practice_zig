# Exercises — Language Basics

Create `basics.zig` in this folder (learner-owned code). No solution code is provided; signatures below are requirements.

## Must implement

1. `tryParseU64(text: []const u8) error{ Empty, InvalidDigit, Overflow }!u64`
   - Rejects empty input, leading `+`/`-`, trailing garbage. No allocation.
2. `trimAsciiSpaces(s: []const u8) []const u8`
   - Returns a subslice (borrowed, no allocation). Handles empty / all-spaces.
3. A tagged-union domain model, e.g.:
   - `const Shape = union(enum) { circle: f64, rect: struct { w: f64, h: f64 }, point: void };`
   - `fn area(s: Shape) f64` with an exhaustive `switch`. Name yours freely but keep the three-variant shape (one scalar, one struct, one void).
4. `fn divide(a: f64, b: f64) error{DivisionByZero}!f64` plus a caller that uses `catch` to produce a fallback and a caller that uses `try` to propagate.
5. One function demonstrating `errdefer`, e.g. `fn makePair(...) error{...}!Pair` where the second acquisition step can fail and the first is released via `errdefer`.

## Tests (in the same file, `test` blocks)
- `tryParseU64`: valid, empty, invalid digit, overflow (`"18446744073709551616"`), trailing space.
- `trimAsciiSpaces`: empty, no spaces, all spaces, inner spaces preserved.
- `area`: one case per variant. `divide`: zero and non-zero divisor.

## STRETCH
- `startsWith` / `endsWith` on `[]const u8` with empty-haystack/needle edge tests (T11 kata).
- A tiny `Op` enum + `apply(op: Op, a: f64, b: f64) error{DivisionByZero, UnknownOp}!f64` evaluator.
- Replace one `catch unreachable` in your scratch code with a real decision + comment.

## Notes
Borrowed slices only. If you reach for an allocator here, you are in the wrong folder — go to `03_memory`.
