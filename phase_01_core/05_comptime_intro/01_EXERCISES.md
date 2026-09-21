# Exercises — Comptime Intro

Create `comptime_demo.zig` in this folder.

## Must implement

1. `hexValTable: [256]u8` (or `i8` with `-1` sentinel) built at comptime mapping `"0".."9","a".."f","A".."F"` to values; plus `fn hexVal(c: u8) ?u8` reading the table. `comptime`-assert at least the entries for `'0'`, `'9'`, `'a'`, `'F'`, and one invalid char.
2. `fn Stack(comptime T: type) type` — struct with unmanaged `ArrayList(T)`-or-slice storage internally; required methods:
   - `push(self: *Self, gpa: Allocator, v: T) !void`, `pop(self: *Self) ?T`, `peek(self: *const Self) ?T`, `len(self: *const Self) usize`, `deinit(self: *Self, gpa: Allocator) void`.
   - Works for at least `u32` and one other `T` in tests.
3. `fn fieldCount(comptime T: type) usize` using `@typeInfo` (structs only; `@compileError` otherwise) + test on two structs.
4. Command dispatch with `StaticStringMap`: `const Cmd = enum { help, run, version };` + map from `"help"|"run"|"version"` to `Cmd`; `fn parseCmd(s: []const u8) ?Cmd`.

## Tests
- Table spot-checks (valid + invalid nibbles). Stack push/pop/peek/empty-pop for two `T`s with GPA leak asserts. `fieldCount` on two structs. `parseCmd` on known + unknown words.

## STRETCH
- `fn describe(comptime T: type) []const u8`-style comptime string or debug-print of field names (T2 ladder).
- Benchmark `StaticStringMap` vs `std.StringHashMap` for your 3–5 keys; one-line comment on when each wins.
- comptime `assert` that `Stack(u32)` has the five required decls via `@hasDecl`.

## Notes
Public APIs use `comptime T: type`, not `anytype`. Keep the table small and proven.
