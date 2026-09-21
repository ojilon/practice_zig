# 05 — Comptime Intro

> Prerequisite: `core_notes/05_comptime.md`

## Why this exists
Comptime is how Zig does generics, table generation, and zero-cost dispatch. You need just enough now to write reusable containers (Phase 2) and later lexers/VMs (Phase 8) — without turning everything into clever compile-time soup.

## Steps (simple → complex)
1. `comptime` values: generate a small lookup table (e.g. hex-digit values for 256 bytes) in a `comptime` block; verify entries with `comptime` asserts and runtime tests.
2. Generic container: `fn Stack(comptime T: type) type` with `push/pop/peek/len`, allocator-aware (per-op `gpa`, unmanaged storage).
3. Introspection: `fn describe(comptime T: type) void`-style helper using `@typeInfo` that prints struct field names (or returns them); use it on your `02_basics` domain type.
4. `StaticStringMap` dispatch: map 3–5 command words to an enum; compare (in comments) against a runtime hash map for this size.
5. Read `std/static_string_map.zig` + `std/meta.zig` headers; note build-time cost discipline (when comptime helps vs hurts).

## Constraints
- Generics take `comptime T: type` explicitly; no `anytype` in public container APIs (use `anytype` only for tiny private helpers, and say why).
- Keep comptime tables small and asserted. No giant unrolled codegen in this folder.
- Allocator rules still apply inside generic containers.

## Done when
- `comptime_demo.zig` exposes the required symbols; tests instantiate `Stack` with at least two different `T` (e.g. `u32`, `[]const u8` or a custom struct).
- A demo prints the table spot-checks, the `describe` output, and one `StaticStringMap` dispatch result.
- You can state one case where you would *not* use comptime.

## Resources
- Language reference: `comptime`, `@typeInfo`, generics. Local: `std/static_string_map.zig`, `std/meta.zig`, `std/enums.zig`.
- Growth hook: T2 (comptime dojo) — table gen and unit-system challenge live there.
