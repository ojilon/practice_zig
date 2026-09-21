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
