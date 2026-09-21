# 06 — Packages & Modules

> Prerequisite: `core_notes/06_modules.md`

## Why this exists
From Phase 2 on, nothing is a lone file: libraries are modules wired through `build.zig` and imported by name. This folder establishes the one true pattern so reuse (BUILD_CHAIN.md) actually happens.

## Steps (simple → complex)
1. Split real code: move one helper from `02_basics` or `04_slices_arrays_lists` into `lib.zig` exposing a documented public API; keep a thin `main.zig` demo that imports it by module name.
2. Wire `build.zig` (folder-local or root): `b.addModule("p01_demo", ...)` + executable with `root_module` + `addImport`. No cross-folder relative `@import`.
3. Add a test target for the module and run it via `zig build test -Dtest-filter=...`.
4. Add one build option (e.g. `-Ddemo-mode=fast|thorough`) that changes demo behaviour via `@import("build_options")` or a comptime flag; document it in the guide header comment.
5. Cross-compile once (`zig build -Dtarget=x86_64-linux` or your second triple) and record the result in one paragraph.

## Constraints
- Import by module name (`@import("p01_demo")`), never `@import("../...")` across folders.
- `root_module` API (Zig ≥ 0.15) — `root_source_file` directly on executables/tests will not compile.
- The library must be importable without dragging the demo `main` along (separate files/targets).

## Done when
- `zig build`, `zig build run`, `zig build test` all pass for this folder's targets.
- Deleting the demo `main` still leaves a usable, tested module.
- You can add a second importer (a test or a second exe) in under 5 minutes.

## Resources
- Local source: `std/Build.zig`, `std/Build/Module.zig`.
- Growth hook: T4 (build-system dojo) — this folder is step 1–2 of that ladder.
