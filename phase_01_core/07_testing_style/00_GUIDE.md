# 07 — Testing Style

> Prerequisite: `core_notes/07_testing.md`
> Capstone of Phase 1: applies to every folder you already did.

## Why this exists
Zig has no test framework to hide behind — `test` blocks + `std.testing` + allocator discipline *is* the framework. This folder turns "writes a test" into "tests like a systems programmer": behavioural names, edge tables, leak asserts, failure injection.

## Steps (simple → complex)
1. Behavioural names + edge tables: retitle any vague tests you wrote in `02/04/05` and add the missing empty/single/boundary cases.
2. GPA leak asserts: every happy-path test that touches allocation asserts clean teardown (explicit `expectEqual(.ok, ...)` on `gpa.deinit()` where the harness allows, else documented `defer _ =`).
3. Failure injection: one test per allocating helper using a failing or tiny fixed-buffer allocator; assert the exact error and clean state.
4. Filters + workflow: demonstrate `zig build test -Dtest-filter="substring"` selecting a subset; document your naming convention so filters stay useful.
5. Audit: revisit folders 01–06, fix one weak test each, and log the fixes in PROGRESS.md.

## Constraints
- No test that allocates may silently discard the GPA check.
- At least one `expectError` per error-returning helper.
- Test names describe behaviour (`"dedupSorted keeps first of run"`), never `"test3"`.

## Done when
- `testing_demo.zig` (or your retrofitted suite) shows all four test kinds: pure logic, slice-edge table, GPA-clean happy path, injected-failure path.
- `zig build test -Dtest-filter=` demonstrably selects subsets (paste two commands + counts in answers).
- Phase 1 audit logged: what you changed in earlier folders and why.

## Resources
- Local source: `std/testing.zig`, `std/heap.zig`, `std/heap/fixed_buffer_allocator.zig`.
- Growth hooks: T5 (fuzz/differential), T6 (BENCH.md habit starts here).
