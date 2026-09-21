# Growth Tracks — Ideas That Keep The Dojo Interesting

`ROADMAP.md` gives you the linear arc (Phase 0 → 10). These tracks run
**orthogonal** to the phases: pick one when you want depth, variety, or a
harder workout without advancing the main phase counter. Each track lists a
ladder from easy to genuinely hard.

Rule: a track item is done when there is a runnable demo + a short written
takeaway (what you learned / simplified / rejected). No demo, no credit.

---

## T1 — Allocator Lab (runs all journey, starts Phase 1)

Zig's superpower. Don't just use allocators — *feel* them.

1. `FixedBufferAllocator` with an intentionally-too-small buffer. Record the exact error path.
2. Arena-per-request: parse N inputs, one arena each, `deinit` per iteration. Prove with GPA that nothing leaks.
3. Rate test: push 1M `u32` into `ArrayList(u32)` with GPA vs arena vs `page_allocator`. Time with `std.time.Timer`, record max RSS qualitatively.
4. Write a counting/wrapping allocator that logs bytes allocated/freed. Use it to assert "this function allocates at most once".
5. Design an ownership table for one of your Phase 2 structures: who allocates, who frees, can it outlive the scope?

Primary sources: `std.mem.Allocator`, `std.heap.*` source.

## T2 — Comptime Dojo (starts Phase 1.05, pays off in Phase 8)

1. `comptime` lookup table generation (e.g. hex table, CRC table).
2. Type introspection: write a function that prints field names of any struct (`@typeInfo`, `std.meta`).
3. Tiny generic container: `Stack(comptime T: type)` with no code duplication.
4. Compile-time string map: `StaticStringMap` for commands; compare to runtime hash map.
5. Challenge: a `comptime` unit system or fixed-point type that rejects mismatched units at compile time.

## T3 — Error-Handling Discipline (starts Phase 1)

1. Convert every `catch unreachable` in your code into a deliberate decision with a comment.
2. Build an error set hierarchy for a parser: `ParseError || AllocError || IoError`. Practice `errdefer` cleanup on each path.
3. Failing-allocator test: inject an allocator that fails on the Nth allocation; prove your code cleans up (no leak reported by GPA).
4. `anyerror` audit: find one place you used `anyerror` and narrow it.

## T4 — Build-System Dojo (starts Phase 1, deepens every phase)

1. Per-exercise `build.zig`: one executable + one test target per folder.
2. Shared module: expose a Phase 2 data structure as `b.addModule("ds", ...)` and import it from a Phase 3/4 tool. No relative `@import` hacks.
3. Build options: `-Dlog-level=`, `-Dtarget=` experiments; cross-compile to at least one other triple (`zig build -Dtarget=x86_64-linux` or `aarch64-macos`) and note what breaks.
4. `zig fetch` a real dependency (e.g. a small arg-parser or test helper) and pin its hash. Document why you would / would not depend on it.

Zig ≥ 0.15 note: executables and tests take `root_module` now:
`b.addExecutable(.{ .name = "...", .root_module = b.createModule(.{ .root_source_file = b.path("src/main.zig"), .target = target, .optimize = optimize }) })`.
`ArrayList(T)` is unmanaged now: `var l: ArrayList(T) = .empty; try l.append(gpa, x); defer l.deinit(gpa);`.

## T5 — Fuzz + Property Lab (starts Phase 2)

1. Invariant tests: after every random op on your ring buffer / hash map, assert `len`, `capacity`, iteration count.
2. Differential test: your educational hash map vs `std.HashMap` on the same random key stream.
3. Text fuzz: feed random bytes to your string interner / Phase 3 tokenizer; it must never panic, only return errors.
4. Later: `build.zig` fuzz step (`b.addFuzz`) for a parser.

## T6 — Benchmark + Perf Journal (starts Phase 2/3)

1. Keep a `BENCH.md` per structure: op, N, time, allocator. Re-measure after each optimization.
2. One intentional optimization pass: e.g. `ensureTotalCapacity` before a bulk append; open-addressing probe tuning; interner dedup threshold.
3. Learn to read the failure: benchmark with `--optimize ReleaseFast` vs `Debug` and explain the gap in one paragraph.

## T7 — IO & Filesystem Lab (starts Phase 2, needed for Phase 4/6)

1. New `std.Io` (Zig 0.16): open/read/close via `std.Io.File`, buffered `Writer`, `Dir` iteration. Port the old `std.fs`/`std.io` snippets you find online.
2. Atomic write: write temp file + rename. Prove crash-safety reasoning in comments.
3. Streaming parser: process a file larger than memory in chunks (ties into Phase 3 format work).
4. CLI ergonomics: stdin/stdout/stderr discipline, exit codes, `--help` text.

## T8 — C Interop & Systems Edges (Phase 6 prep, taste early)

1. `@cImport` a single-header C library (e.g. stb-style) for one experiment. Document ownership across the boundary.
2. Call one OS primitive directly (`mmap`-style via `std.os` / `std.posix`) and wrap it in a safe Zig API with `errdefer`.
3. Cross-compile a static binary and run it (VM, container, second machine). Note libc/static decisions.

## T9 — Concurrency Primer (carefully scoped, Phase 3+)

1. `std.Thread` spawn/join with explicit data ownership (who frees the thread arg?).
2. Atomic counter vs mutex counter: measure, then explain when you would use neither.
3. Single-producer/single-consumer ring: the *only* lock-free structure in the dojo until Phase 7. Everything else uses mutexes.

## T10 — Read-Std Quests (weekly, 30–60 min)

Pick one std file, read with a question in mind, write a 5-line takeaway:

- `std/array_list.zig` — how does growth work? What is `ensureTotalCapacityPrecise` for?
- `std/hash_map.zig` — open addressing? What does `getOrPut` return and why?
- `std/heap.zig`, `std/heap/arena_allocator.zig` — where does the arena keep its blocks?
- `std/log.zig`, `std/json.zig` — how do they avoid hidden allocation?
- `std/Build.zig`, `std/Build/Module.zig` — how are modules wired?

## T11 — Kata Series (15-minute warmups, any phase)

- Reverse a slice in place without allocating.
- `parseU64` with overflow + trailing-garbage errors.
- Split a path into segments without allocating (return slices).
- Deduplicate a sorted slice in place, return new length.
- Implement `startsWith`/`endsWith`/`trim` on `[]const u8` and prove with edge-case tests (empty, equal, longer-than-haystack).

## T12 — Spec-Parser Ladder (feeds Phase 3 directly)

Ordered by difficulty: length-prefixed strings → CSV with quoting → JSON subset → WAV/RIFF chunks → XML subset → PDF objects/xref → BMFF boxes. Each step reuses: arena lifetimes, error sets, fuzz corpus, and your Phase 2 structures.

## T13 — Paper Ladder (feeds Phase 3/7 directly)

Ordered by implementability in a few hundred lines:

1. Any classic allocator or ring-buffer description (implement + benchmark).
2. A sorting or string-matching paper core (e.g. a variant you can compare to `std.sort` / `std.mem.indexOf`).
3. A consensus / systems-idea sketch *as a simulator*, not a production system (e.g. a log replication toy with deterministic faults).
4. One VM / bytecode paper idea (direct runway into Phase 8).

Every paper ends with: what the paper claimed, what you built, what you deliberately left out.

---

## How to use this file

- Stuck or bored in the main arc? Pull one item from a track at your level.
- Log finished items in `PROGRESS.md` under "Growth tracks".
- If an item grows past ~3 days, promote it to a Phase folder with its own `00_GUIDE.md`.
