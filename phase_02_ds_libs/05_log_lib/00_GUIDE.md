# 05 — Tiny Logging Library

> Modules: exposes `p02_log`. Reads: `std/log.zig` (scope/level design), new-IO writer notes (`std/Io/Writer.zig` header).

## Why this exists
Every Phase 4+ tool needs the same three things: leveled output, a severity
filter, and a testable sink. Building it once — as a library with no global
state — kills a dozen future `std.debug.print` sprinkles and teaches
writer-based (not string-building) output discipline.

## Steps (simple → complex)
1. `Level` enum (`debug < info < warn < err`, ordered) + `Logger` holding a minimum level, a prefix/scope string, and a writer sink. No globals: callers construct `Logger` explicitly.
2. `log(level, comptime fmt, args)` filtering below-minimum without formatting work when possible (document what "without work" means in Zig — comptime format + early return).
3. Convenience `debug/info/warn/err` wrappers + one structured helper (e.g. `logValue(level, key, value)` or `k=v` pair line — your choice, tested).
4. Testable sink: log into a fixed buffer / `ArrayList(u8)` writer in tests; assert filtering, ordering, prefix, and truncation-or-error policy on full buffer.
5. Read `std/log.zig` scopes + levels; compare your explicit-`Logger` design to std's global/comptime design in 5 lines.

## Constraints
- No global logger state in the library. (Apps may hold one in `main` — that is their choice, not yours.)
- No allocation in the log path by default: formatting goes to the caller's writer/buffer. If any helper allocates, its name must say so (e.g. `allocLogLine`) and take `gpa`.
- Level filtering is exact and tested at every boundary (each level as min-level × each level as message-level).

## Done when
- `log.zig` exposes the required symbols; tests prove filtering matrix + prefix + sink behaviour, with zero GPA dependency in the core path (or a documented `alloc*` exception).
- A demo constructs two loggers (different min-levels, same sink) and shows one message passing one but filtered by the other.
- Phase 4 tools can import `p02_log` without modification.

## Resources
- Local source: `std/log.zig`, `std/Io/Writer.zig`, `std/fmt.zig`.
- Growth hooks: T4 (build-option default level), T7 (file sink via `std.Io.File`).
