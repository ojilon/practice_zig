# Roadmap — 12 to 18 Month Zig Systems Journey

**Project goal (read this carefully — future agents need this context):**

Become highly effective with Zig by building a progressive collection of real, usable systems artifacts. The end state is not one perfect program; it is a toolkit and a set of experiences that prove you can:

- Use Zig’s language features, allocators, and error model fluently
- Drive the build system (`build.zig`) for non-trivial projects
- Write libraries and internal tools that other projects depend on
- Parse and understand real document and media formats from specs
- Read research papers and classic systems literature and turn them into working code
- Build TUI tools and low-level applications that are actually useful
- Reach an advanced stage where a small language and/or compiler components are realistic
- Ship critical, functional tools you would trust to run on real data

Heavy emphasis on **adventure reading + implementation** (papers, RFCs, format specs, classic systems papers).

Times assume ~1–2 focused hours most days. Adjust freely.

---

## High-level arc

| Months | Phase | Focus |
|--------|-------|-------|
| 0–2    | 0–2   | Language core, allocators, build.zig basics, first data structures |
| 2–4    | 3–4   | Algorithms, paper adventures, first format parsers, solid tools |
| 4–6    | 5–6   | Deeper systems, TUI foundation, more parsers, internal tooling |
| 6–9    | 7     | Substantial low-level apps & libraries; stronger paper work |
| 9–12   | 8     | Advanced: small language / interpreter / compiler components |
| 12–15  | 9     | Critical systems tools, integration, dogfooding |
| 15–18  | 10+   | Productization, harder papers, capstones |

---

## Phase 0 — Setup & Mindset (Day 0)

- [ ] Read `HOW_TO_PRACTICE.md`
- [ ] Read `EXPLORATION.md`
- [ ] Read `BUILD_CHAIN.md`
- [ ] Read `SCAFFOLD_FOR_FUTURE_AGENTS.md`
- [ ] Install / confirm Zig works (`zig version`)
- [ ] Create a minimal project with `build.zig` that prints and runs
- [ ] Skim `core_notes/00_INDEX.md`

---

## Phase 1 — Language Core + Allocators + Build (Weeks 1–5)

| # | Folder | Focus |
|---|--------|-------|
| 01 | `phase_01_core/01_hello_and_build` | project layout, `build.zig`, run/test steps |
| 02 | `phase_01_core/02_basics` | types, functions, structs, enums, error unions |
| 03 | `phase_01_core/03_memory` | allocators (GPA, arena, fixed buffer), `defer`, ownership |
| 04 | `phase_01_core/04_slices_arrays_lists` | slices, ArrayList, managed vs unmanaged |
| 05 | `phase_01_core/05_comptime_intro` | basic comptime, type introspection, simple generics |
| 06 | `phase_01_core/06_packages_modules` | modules, `@import`, build dependencies |
| 07 | `phase_01_core/07_testing_style` | `std.testing`, test filters, intentional failure cases |

Memory and the build system appear early — both are central to real Zig work.

---

## Phase 2 — Data Structures & Small Libraries (Weeks 6–9)

Build classic structures with explicit allocator parameters:

- dynamic array helpers beyond ArrayList where useful
- linked lists, stacks, queues, ring buffers
- hash maps / sets (educational implementations)
- simple string interning or rope-like experiments
- a tiny logging library
- a config / flags helper

Each library should be usable from other packages via the build system.

---

## Phase 3 — Algorithms + Paper Adventures + Format Parsers (Weeks 10–16)

**Algorithms**
- Sorting, searching, basic graph algorithms
- String matching / simple text algorithms

**Paper / systems adventures** (1–4 days each, documented)
- Classic OS / systems papers (e.g. ideas from “The UNIX Time-Sharing System”, allocator papers, etc.)
- Simple concurrent or lock-free ideas (carefully scoped)
- Numerical or geometric algorithms from short papers
- Any paper whose core idea fits in a few hundred lines of Zig

**Document & media format parsers** (practical, spec-driven)
- Minimal XML / HTML subset
- Simple PDF object model / trailer / xref reader (read-only subset)
- WAV / basic audio frame understanding
- RIFF or simplified ISO BMFF / container concepts
- JSON (streaming or stricter variant)
- A tiny binary format of your own design + its parser

Every adventure ends with a short “what I learned / what I simplified” note and a runnable demo.

---

## Phase 4 — Real Tools on Your Stack (Months 4–5)

Command-line and library tools that compose earlier work:

- CLI framework or solid argument + config + log combination
- File processors that use your format parsers
- A project/build helper that understands your own conventions
- Static analysis or lint-style tool for a tiny language subset
- One tool you would actually use on real files

---

## Phase 5 — TUI Foundation (Months 5–6)

- Terminal control, raw mode, alternate screen
- Input handling, simple event loop
- Basic widgets: list, text view, status bar, input field
- A small but usable TUI application (file browser, log viewer, or simple editor pane)

Study existing Zig TUI experiments and classic libraries (design ideas only).

---

## Phase 6 — Deeper Systems & Low-Level Apps (Months 6–8)

- Virtual memory / custom page allocators where useful
- Process / OS interaction beyond the basics
- Networking primitives or a tiny protocol
- One “critical path” tool: something that must be correct and robust on real input (e.g. a format validator, a safe file transformer, a reliable log shipper prototype)
- Cross-compilation practice via the build system

---

## Phase 7 — Substantial Libraries & Paper Depth (Months 8–10)

- Larger, well-documented libraries extracted from earlier work
- Harder paper re-implementations (still scoped to be finishable)
- A more complete format tool (better PDF subset, structured document walker, audio metadata tool, etc.)
- Performance measurement and intentional optimization passes

---

## Phase 8 — Small Language / Compiler Components (Months 10–13)  ★ advanced

Progressive path (do not jump to a full compiler):

1. Lexer / tokenizer for a tiny language
2. Parser (recursive descent or Pratt) producing an AST
3. Interpreter or simple bytecode VM
4. Optional: basic type checking or a single optimization pass
5. Optional: emit C or a simple IR, or target a very small backend

Resources: classic compiler texts (selective chapters), “Crafting Interpreters” ideas, Zig’s own compiler source as inspiration (not for copying), papers on parsing and VMs.

**Shippable definition:** a language small enough to write real programs in, with a working interpreter or VM, and clear documentation of what was intentionally left out.

---

## Phase 9 — Integration, Dogfooding & Critical Tools (Months 13–15)

- Use your own tools and libraries in larger combinations
- Harden at least one tool until you would trust it on important data
- Internal tooling that supports the rest of the practice (project runner, test harness helpers, format validators)
- Continuous improvement based on real friction

---

## Phase 10+ — Productization & Capstones (Months 15–18)

- Extract strongest libraries into clean, versioned, documented repositories
- Proper build.zig packages, examples, and tests
- More ambitious paper or systems re-implementations
- Capstone choices (examples):
  - A small but real systems utility used daily
  - A more complete compiler / language experiment
  - A specialized parser or media tool
  - A TUI application of real personal utility
- Living best-practices and “lessons from papers” document

---

## Cross-cutting quests (whole journey)

- **Q-BUILD:** Every non-trivial project has a clear `build.zig` and can be built/tested with standard Zig commands.
- **Q-ALLOC:** Allocations are intentional; prefer arenas and clear lifetimes; use GPA + leak detection in tests.
- **Q-PAPER:** Regular paper / spec adventures with written takeaways.
- **Q-FORMAT:** Multiple real format parsers (documents, media, structured data).
- **Q-REUSE:** Later work imports earlier libraries through the build system.
- **Q-SHIP:** At major milestones produce something with a README that a stranger could build and run.
- **Q-CRITICAL:** At least one tool is hardened enough that you would run it on data you care about.

---

## Completion mindset

A phase is done when the artifacts run, demonstrate the intended capability, and can be reused.  
Perfection is not required. Deep understanding, correct memory behaviour, and shipping are.
