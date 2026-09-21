# 04 — Slices, Arrays, Lists

> Prerequisite: `core_notes/04_collections.md`
> Builds on: `02_basics` (error sets), `03_memory` (GPA + leak detection).

## Why this exists
Zig code is slice plumbing plus a growable buffer. This folder makes the unmanaged-`ArrayList` idiom automatic and teaches OOM-safe habits before Phase 2 containers.

## Steps (simple → complex)
1. Borrowed-slice ops: reverse in place, dedup of sorted input, split-without-allocating. Zero allocation, return counts/lengths.
2. `ArrayList` core loop: `var l: ArrayList(T) = .empty; defer l.deinit(gpa); try l.append(gpa, x);` plus `ensureTotalCapacity` before a bulk fill and `toOwnedSlice(gpa)` transfer with ownership documented.
3. Error-path test: drive one builder with a failing/small fixed-buffer allocator; assert the documented error and clean state.
4. Read `std/array_list.zig` growth + `std/mem.zig` helpers; note one thing you will steal and one you will avoid.
5. (Bridge to Phase 2) Write the ownership doc comment your future ring buffer / hash map will copy.

## Constraints
- Unmanaged idiom only (`.empty`, per-op `gpa`, `deinit(gpa)`). `Managed`/`init(gpa)` is deprecated — do not use it.
- Every allocating function takes an `Allocator` parameter; no global allocators.
- Tests use GPA with explicit leak asserts on the happy path (see `core_notes/07_testing.md`).

## Done when
- `slices.zig` exposes the required symbols with edge-case tests (empty, single, full-boundary).
- A demo builds N items twice (naive vs `ensureTotalCapacity`-reserved) and prints both results; optional timing note in comments.
- You can port any pre-0.15 `ArrayList.init` snippet to the new API on sight.

## Resources
- Local source: `std/array_list.zig`, `std/mem.zig`.
- Growth hooks: T1 (allocator lab timing), T5 (invariant tests), T11 (katas).
