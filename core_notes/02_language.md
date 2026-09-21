# Language Core (read before `02_basics`)

Types, functions, control flow, and Zig's error model in one page.

## Types you must be fluent in
- Ints: `u8/i32/usize/isize` — `usize` for lengths/indices. Know `@intCast`, `@truncate` exist; never silently narrow.
- Floats: `f32/f64`. Bool, `void`, `noreturn`.
- `?T` (optional) and `error!T` / `error{A,B}!T` (error unions). Payload with `try`, `catch`, `orelse`, `if (x) |v|`.
- Structs, enums (plain + tagged union via `union(enum)`), arrays `[N]T`, slices `[]T`, pointers `*T`.

## Functions & control
- `fn name(a: T, b: T) RetType { ... }`. `pub` only what other modules need.
- `switch` is exhaustive — the compiler enforces it. `while` with `else`/`break` value, `for` with index.
- `defer` runs at scope exit; `errdefer` only on error return. Use `errdefer` for partial-cleanup paths from here on.

## Error model (the 30-second version)
- Errors are values: `error.OutOfMemory`, custom `error{BadInput, Overflow}` sets.
- `try expr` returns the error to the caller; `catch |e| ...` handles it.
- `try` + `errdefer` is the standard pair: acquire, `errdefer` release, proceed.
- Avoid `catch unreachable` unless you can prove unreachability in a comment.
- `anyerror` is a smell in libraries — narrow error sets where callers benefit (see GROWTH_TRACKS.md T3).

## Resources
- Zig language reference: errors, optionals, switch, tagged unions.
- `std/meta.zig` for later introspection; `std/testing.zig` for `expectError`.
