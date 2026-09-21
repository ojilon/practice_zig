# Exercises — Tiny Logging Library

Create the module source file(s); register module `p02_log`.

## Must implement

```zig
pub const Level = enum { debug, info, warn, err }; // ordered debug < info < warn < err; provide order/compare helper

pub const Logger = struct {
    // init(min_level: Level, scope: []const u8) Self   (scope borrowed — document lifetime!)
    // setLevel(self: *Self, l: Level) void
    // log(self: *Self, w: *WriterOrSink, level: Level, comptime fmt: []const u8, args: anytype) void-or-!void
    // debug/info/warn/err wrappers with same sink+fmt shape
};
```

Sink type is your documented choice: `*std.Io.Writer`, a small `Sink` interface struct you define, or generic `anytype` writer — pick one, justify in 3 lines, test with at least two sinks (fixed-buffer + `ArrayList(u8)`-backed or equivalent on your Zig version).

## Tests
- Filtering matrix: min-level ∈ {debug, info, warn, err} × message-level ∈ same → assert emitted/suppressed exactly.
- Prefix/scope appears on every emitted line; suppressed messages write nothing (assert sink length unchanged).
- Format args render (`{d}`, `{s}` at minimum); multi-line or special-char message doesn't corrupt framing (your framing rule, tested).
- Full-sink policy: define (truncate / return error / drop-with-counter) and test with a tiny fixed buffer.
- No-alloc assertion: core `log` path test uses no GPA at all (or only the documented `alloc*` helper does).

## STRETCH
- Structured line: `logKv(level, key, value)` producing `level scope key=value` (or JSON-ish line) + test.
- Build-option default level (`-Dlog-level=warn`) threading into a demo without code change.
- Timestamp or sequence-number prefix (monotonic counter — document thread-safety non-guarantee).
- File sink demo via `std.Io.File` append (T7 bridge).

## Notes
Borrowed `scope`: the logger must not outlive the scope string. State this in the struct doc comment and test with a scoped block.
