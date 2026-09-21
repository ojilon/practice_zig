# 02 — Language Basics

> Prerequisite: `core_notes/02_language.md`

## Why this exists
Everything downstream (allocators, containers, parsers, VMs) is structs + enums + error unions + slices composed carefully. Get fluent here or pay interest forever.

## Steps (simple → complex)
1. Scalars + control: integers of several widths, `usize` discipline, exhaustive `switch`, `while`/`for` with values.
2. Structs + methods: a small value type with `init`, pure helpers, and a `format`-friendly debug view via `std.debug.print`.
3. Enums + tagged unions: model one tiny domain (e.g. a calculator op, a tile/shape, a protocol message) as `union(enum)`.
4. Optionals + error unions: parse-like functions returning `?T` and `error{...}!T`; handle with `orelse`, `try`, `catch`, `errdefer` where cleanup exists.
5. `defer`/`errdefer` on purpose: at least one function where `errdefer` releases a partially-built result.

## Constraints
- No allocator work yet (that is `03_memory`). Slices you touch here are borrowed (`[]const u8`), never owned.
- Every `catch unreachable` needs a one-line proof comment. Otherwise handle or propagate.
- Narrow error sets for parsing-ish helpers; `anyerror` only in the scratch `main`.

## Done when
- A `basics.zig` module exposes the required symbols (see `01_EXERCISES.md`), with tests for happy + error paths.
- A scratch `main` demo prints each domain type and exercises one error path visibly.
- You can explain when you would use `?T` vs `error!T` vs `union(enum)` without hesitating.

## Resources
- Zig language reference: errors, optionals, switch, tagged unions.
- Growth hooks: T3 (error discipline), T11 (parseU64 / trim katas).
