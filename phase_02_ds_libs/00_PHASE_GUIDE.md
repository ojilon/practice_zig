# Phase 2 — Data Structures & Small Libraries

> Roadmap: `ROADMAP.md` Phase 2. Conventions: `BUILD_CHAIN.md`, `GROWTH_TRACKS.md`.

Every folder here produces a **module** (`p02_ring`, `p02_list`, `p02_map`,
`p02_str`, `p02_log`, `p02_cfg`) importable via `build.zig` — no relative
cross-folder `@import`. Allocator rules from Phase 1 apply everywhere, with
GPA leak asserts and at least one injected-failure test per folder.

| # | Folder | Module | Delivers |
|---|--------|--------|----------|
| 01 | `01_ring_stack_queue` | `p02_ring` | generic Stack, Queue, RingBuffer |
| 02 | `02_linked_lists` | `p02_list` | singly + doubly linked lists |
| 03 | `03_hashmap_set` | `p02_map` | educational open-addressing map + set |
| 04 | `04_str_intern_rope` | `p02_str` | string interner + rope-ish builder |
| 05 | `05_log_lib` | `p02_log` | leveled logger |
| 06 | `06_config_flags` | `p02_cfg` | argv/env/file config |

## Phase capstone (do this last — it is the first BUILD_CHAIN link)

A CLI demo executable that imports **at least two** Phase 2 modules through
`build.zig` (recommended: `p02_cfg` + `p02_log` + one container). It must:

1. Parse real `argv` (a `--count N` / `--mode word` pair you define).
2. Log at two levels with the logger (not `std.debug.print` directly).
3. Exercise the container on real input and print a summary line.
4. Run via `zig build run-p02-demo -- --count 5 ...` (or your documented step name).

Suggested home: `phase_02_ds_libs/capstone_demo/` with its own `00_GUIDE.md`
written by you (3 lines: what it wires, how to run, what you learned).

## Folder order

01 → 02 → 03 → 04 can go in parallel after 01; do 05 + 06 before the capstone.
Growth feeds: T1 (allocator lab) in 01/03, T5 (fuzz/differential) in 03/04,
T10 read-std (`deque.zig`, `hash_map.zig`) alongside 01/03.
