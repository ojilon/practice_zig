# Testing Style (read before `07_testing_style`)

## Standard assertions
- `std.testing.expect(cond)`, `expectEqual(a, b)`, `expectEqualSlices(T, a, b)`, `expectError(err, expr)`, `expectString`.
- Tests are blocks: `test "name" { ... }`. Run subsets with `zig build test -Dtest-filter="substring"`.
- Name tests by behaviour: `"ring.pop empty returns null"`, not `"test1"`.

## Allocator-aware tests (non-negotiable in this dojo)
- Happy-path tests use GPA and assert no leak:
```zig
var gpa_state: std.heap.DebugAllocator(.{}) = .init; // `GeneralPurposeAllocator` pre-0.16
defer _ = gpa_state.deinit(); // panics/fails if leaked (use expectEqual(.ok, ...) for explicitness)
const gpa = gpa_state.allocator();
```
- One failure-path test per structure: a `FailingAllocator` (fails on Nth alloc) or `FixedBufferAllocator` with a tiny buffer must produce the documented error, with no leak after cleanup.
- Log the GPA result explicitly rather than discarding it where the harness allows.

## Style rules
- Every container/parse test covers: empty input, single element, boundary (full/empty transition), and error/edge (OOM, malformed, truncated).
- Keep tests next to the code they exercise; a `tests/` split is only for integration-style tests.
- Later: `b.addFuzz` for parser fuzzing (GROWTH_TRACKS.md T5). Start the habit now with table-driven random-ish cases.

## Resources
- Local source: `std/testing.zig`, `std/heap.zig` (GPA), `std/heap/fixed_buffer_allocator.zig`.
