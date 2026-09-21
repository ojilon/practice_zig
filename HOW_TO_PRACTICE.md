# How To Practice (READ THIS FIRST)

This is a long-term Zig systems dojo. You learn by writing code, driving the build system, managing memory deliberately, reading papers and specifications, and shipping tools that actually work on real input.

The journey is designed for **12–18 months**. Early months give language + allocator + build fluency; later months produce parsers, TUI tools, substantial libraries, and (optionally) language/compiler components.

---

## 1. Core rules

### 1a. Build system is part of the craft
Almost every package should be reachable through a `build.zig`. Learn to add modules, tests, executables, and dependencies cleanly. The build system is not an afterthought.

### 1b. Memory is explicit
- Prefer passing allocators explicitly.
- Use arenas for clear lifetime scopes.
- Use `std.heap.DebugAllocator` (`GeneralPurposeAllocator` pre-0.16) with leak detection in tests and debug runs.
- Document ownership for any non-trivial structure.

### 1c. Who writes what
- Guides and scaffolds are written by assistants / future agents.
- **You** write all the Zig code.
- Study real code and papers; re-implement ideas rather than large copy-paste.

### 1d. Reuse and composition
Later tools and libraries should import earlier ones through the build system. A parser used by a CLI tool, a data structure used by a TUI, a library used by a small language runtime — that chain is intentional.

---

## 2. Folder layout

```
ROADMAP.md
HOW_TO_PRACTICE.md
BUILD_CHAIN.md
EXPLORATION.md
SCAFFOLD_FOR_FUTURE_AGENTS.md
PROGRESS.md
core_notes/                     # language, memory, build reference
phase_01_core/                  # language + allocators + build
phase_02_ds_libs/               # data structures & small libraries
phase_03_algo_papers_formats/   # algorithms, papers, format parsers
phase_04_tools/                 # real CLI / library tools
phase_05_tui/                   # terminal UI foundation
phase_06_systems/               # deeper systems & critical tools
phase_07_libraries_papers/      # substantial libs + harder papers
phase_08_language/              # small language / compiler components
phase_09_integration/           # dogfooding & hardening
phase_10_product/               # extraction, capstones
```

Fully-specified exercise folders typically contain:
- `00_GUIDE.md`
- `01_EXERCISES.md`
- `02_QUESTIONS.md`
- plus the `.zig` files you create

---

## 3. Daily / weekly rhythm

- Most days: one focused folder or clear sub-goal.
- Early: heavy practice with allocators and `build.zig`.
- Weekly: one exploration (paper, format spec, or real Zig codebase).
- At milestones: ship something with a README and a working build.

---

## 4. What to create vs avoid

**Do**
- Create packages and wire them in `build.zig`.
- Write tests that exercise both success and failure paths.
- Keep ownership and allocator usage obvious.
- Document paper/spec takeaways.

**Avoid**
- Hidden allocations or “it works on my machine” memory behaviour.
- Skipping the build system.
- Large uncredited copy-paste from other projects.

---

## 5. How to run

Typical pattern:

```bash
zig build
zig build run
zig build test
zig build test -Dtest-filter="name"
```

For a single-file experiment you can still use `zig run file.zig`, but prefer proper packages early.

### 5a. Zig 0.16 survival notes (Sept 2026)

- `ArrayList(T)` is unmanaged: `var l: std.ArrayList(T) = .empty; try l.append(gpa, x); defer l.deinit(gpa);`. If a blog shows `ArrayList.init(gpa)`, it is pre-0.15 — translate it.
- `build.zig` uses `root_module`: `b.addExecutable(.{ .name = "...", .root_module = b.createModule(.{ .root_source_file = b.path("..."), .target = target, .optimize = optimize }) })`. Same for `b.addTest`.
- `std.io.getStdOut()` / `std.fs` helpers from old tutorials are gone or moved. Use `std.debug.print` for scratch output and `std.Io.File.stdout()` + buffered `Writer` for real tools (see GROWTH_TRACKS.md T7).
- When stuck on a std API, read the local source first: `zig env` gives you `std_dir`; `Select-String` over `array_list.zig`, `hash_map.zig`, `Build.zig` beats guessing.

---

## 6. Done = verifiable + usable

A folder is done when:
1. Required types and functions exist and behave correctly.
2. Tests pass (including intentional error cases where relevant).
3. Memory behaviour is clean under the GPA leak detector for the happy path.
4. The package can be imported by later work via the build system.
5. Reflection / answer boxes are filled.

Larger milestones are done when they meet the shippable definition in the roadmap.

---

## 7. Long-term mindset

- Zig rewards clarity and explicitness. Prefer straightforward code.
- The build system is a skill, not boilerplate.
- Papers and format specifications are first-class learning material.
- Aim to produce tools you would actually run on real data.
- Future agents will expand later phases using the scaffolds provided.
