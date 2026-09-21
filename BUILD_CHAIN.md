# Build Chain — Use What You Built

Principle: **language + allocators + build system → data structures & small libs → parsers & tools → TUI & systems apps → substantial libraries → language/compiler components → hardened critical tools**.

---

## Layer 0 — Language, memory, build

Everything rests on:
- solid command of types, error unions, structs, comptime basics
- explicit allocators and clear lifetimes
- a working, idiomatic `build.zig` for every package

---

## Layer 1 — Data structures & small libraries

Lists, maps, queues, logging, config, string utilities — all allocator-aware and importable.

---

## Layer 2 — Algorithms, papers, format parsers

Educational algorithms plus real format readers (XML, PDF subset, audio containers, etc.) and short paper implementations. These become libraries that tools consume.

---

## Layer 3 — Tools

CLI and library tools that compose parsers, data structures, logging, and config. At least some of them should be tools you would run on real files.

---

## Layer 4 — TUI

Terminal applications built on your lower layers (data structures, config, any parsers needed for the domain).

---

## Layer 5 — Systems & critical apps

Lower-level or higher-stakes programs: validators, transformers, protocol pieces, cross-compiled utilities. Correctness and robust error handling matter more here.

---

## Layer 6 — Substantial libraries & deeper papers

Extracted, documented libraries and more ambitious paper work that other projects can depend on.

---

## Layer 7 — Language / compiler components

Lexer → parser → AST → interpreter or VM (and optional further stages). This layer consumes many earlier skills (data structures, comptime, careful memory, testing).

---

## Layer 8 — Integration & productization

Hardening, documentation, extraction into clean repositories, and real personal or practical use.

---

## Standing rules

1. Allocations are never invisible.
2. Prefer your own earlier packages when they fit; document deliberate use of std instead.
3. Every non-trivial artifact has a clear build and test path.
4. Paper and format work always ends with a runnable demonstration and short written takeaways.
