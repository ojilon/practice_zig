# Scaffold for Future Agents

This file tells any future agent how to expand the later phases of `practice_zig`.

The overall project goal is stated in `ROADMAP.md`. Keep it in mind: the learner is building progressive systems fluency in Zig — language, allocators, build system, parsers, tools, TUI, papers, and eventually language/compiler components and hardened critical tools.

---

## What a complete exercise folder looks like

```
phase_XX_name/NN_shortname/
  00_GUIDE.md          # why, steps, constraints, done-when, resources
  01_EXERCISES.md      # concrete tasks, required symbols, allocator/build expectations
  02_QUESTIONS.md      # reflection / paper-takeaway / run-and-answer questions
  (learner creates the .zig files and wires them in build.zig)
```

Tone: direct, practical, no solution code, explicit about allocators and the build system.

---

## How to expand a phase

1. Read the phase description in `ROADMAP.md` and the relevant part of `BUILD_CHAIN.md`.
2. Create the folder structure and the three markdown files.
3. List concrete resources (Zig std source, papers, format specs, RFCs).
4. Define a minimal viable set of types/functions plus stretch goals.
5. Require explicit allocator usage and a clean build/test path.
6. Keep scope shippable.

---

## Phase-specific guidance

### Phase 1 (remaining)
- Finish language, allocator, comptime, and build.zig fundamentals.
- Every memory exercise should use leak detection in tests.

### Phase 2 — Data structures & small libs
- Allocator parameters on structures.
- Usable from other packages via `build.zig`.

### Phase 3 — Algorithms, papers, formats
- Keep paper and format adventures short and documented.
- Format work should reference a real specification or primary source.

### Phase 4 — Tools
- Real tools that compose earlier packages.
- At least one tool intended for real files.

### Phase 5 — TUI
- Practical terminal application, not just a widget demo.

### Phase 6 — Systems & critical tools
- Robustness and clear error handling matter.
- Cross-compilation practice is valuable.

### Phase 7 — Substantial libraries & deeper papers
- Extraction and documentation quality rise in importance.

### Phase 8 — Language / compiler components
- Progressive: lexer → parser → AST → interpreter/VM.
- Do not require a full optimizing compiler.
- Clear “intentionally omitted” list is part of the deliverable.

### Phase 9–10
- Hardening, integration, productization, learner-chosen capstones.

---

## Style rules

- Speak directly to the learner.
- Never write the solution implementation in the guides.
- Always surface allocator and build-system expectations.
- Always give a concrete “Done when” that includes a runnable demonstration.
- Prefer primary sources.

When you finish expanding a phase, update `ROADMAP.md` accordingly.

---

## Quality bar for new scaffolds (mandatory)

Every exercise folder you create must have:

1. `00_GUIDE.md` — why, steps (simple → complex), constraints, done-when, resources. Name the exact std files to read (e.g. `std/array_list.zig`, `std/hash_map.zig`) and the Zig-version API (`ArrayList = .empty` + per-op allocator; `root_module` in build.zig).
2. `01_EXERCISES.md` — concrete tasks with **required symbol names** (so tests can target them), allocator expectations per function, and stretch goals marked `STRETCH`. No solution code — signatures and behaviours only.
3. `02_QUESTIONS.md` — 4–7 reflection questions with `> Your answer:` boxes, including at least one ownership question, one failure-path question, and one reuse question ("which later phase will import this?").
4. Folder registered in `ROADMAP.md` (table row) and `PROGRESS.md` (checkbox).
5. Verified against the installed Zig (`zig version`): build API uses `root_module`, containers use the unmanaged idiom, no `std.io.getStdOut()`.

Scope rule: a folder is 1–3 focused days. If your draft needs more, split it.
Growth rule: each folder lists which `GROWTH_TRACKS.md` items it feeds (fuzz, bench, read-std) so the dojo compounds.
