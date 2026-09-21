# Comptime Basics (read before `05_comptime_intro`)

## Mental model
- `comptime` code runs at compile time. Types are values: `comptime T: type` is a generic parameter.
- `inline for`, `inline while`, and `comptime var` unroll/generate code per variant.
- `@typeInfo(T)` + `std.meta` let you reflect over structs/enums/unions — field names, tags, child types.

## Patterns you will reuse constantly
- Generic container: `fn Stack(comptime T: type) type { return struct { ... }; }`.
- Compile-time table: build `[256]u8` hex nibble table or CRC table in a `comptime` block; verify with a `comptime assert`.
- `StaticStringMap(V)` for keyword/command dispatch — zero-hash, zero-alloc alternative to a runtime map for small fixed sets.
- `std.enums` helpers (`EnumMap`, `EnumSet`) for exhaustive enum-indexed data.

## Limits (important)
- Keep comptime work bounded and debuggable: huge unrolled tables slow builds and bloat binaries.
- Prefer a small `comptime` core (table gen, type dispatch) + runtime logic over "everything at comptime".
- When a generic fails, read the compiler's instantiation trace top-down: the first user-frame mention is usually yours.

## Resources
- Language reference: `comptime`, `@typeInfo`, generics.
- Local source: `std/static_string_map.zig`, `std/meta.zig`, `std/enums.zig`.
- Growth: GROWTH_TRACKS.md T2 (comptime dojo) — the unit-system challenge is the graduation test.
