# Exercises — Slices, Arrays, Lists

Create `slices.zig` in this folder.

## Must implement

1. `reverseInPlace(items: []u32) void` — no allocation; empty/single-element safe.
2. `dedupSorted(items: []u32) usize` — in-place dedup of sorted input; returns new length. Document precondition (sorted) in a doc comment.
3. `splitFirst(text: []const u8, delim: u8) struct { head: []const u8, tail: ?[]const u8 }` — borrowed slices, no allocation; empty-input safe.
4. `buildSquares(gpa: std.mem.Allocator, n: usize) error{OutOfMemory}![]u64`
   - Uses `ArrayList(u64)` unmanaged idiom internally, reserves with `ensureTotalCapacity`, returns owned slice via `toOwnedSlice(gpa)`. Caller owns the result (document it).
5. `buildSquaresReserved vs buildSquaresNaive` — keep both, or parameterize; the demo must show both paths produce identical output.

## Tests
- Reverse/dedup/split: empty, single, two-element, already-(reversed|deduped), longer-than-buffer analogues where relevant.
- `buildSquares`: `n = 0`, small N exact-content check with `expectEqualSlices`, GPA leak assert.
- Failure path: drive `buildSquares` (or a bounded variant) with a tiny `FixedBufferAllocator`; expect `error.OutOfMemory` and no partial leak.

## STRETCH
- `indexOf`-style `findByte(haystack: []const u8, needle: u8) ?usize` + differential test vs `std.mem.indexOfScalar`.
- Time naive vs reserved for N = 100k with `std.time.Timer`; one-paragraph comment on the result (first BENCH.md habit).
- Skim `MultiArrayList` docs; write 3 lines on when you would reach for it.

## Notes
Signatures are requirements; bodies are yours. Keep allocation confined to function #4.
