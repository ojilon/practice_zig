# 01 — Hello and Build

> Prerequisite: `core_notes/01_build.md`

## Why this exists
Confirm that Zig and the build system work, and establish the habit of a proper `build.zig` from the first day.

## Steps
1. Create a minimal project with `build.zig` that builds an executable.
2. Print a greeting from `main`.
3. Add a simple test and run it with `zig build test`.
4. Make sure `zig build run` works cleanly.

## Constraints
- Prefer the standard build API over ad-hoc scripts.
- Keep the project small and readable.

## Done when
- `zig build`, `zig build run`, and `zig build test` all succeed.
- You understand where the executable and test steps are declared.
