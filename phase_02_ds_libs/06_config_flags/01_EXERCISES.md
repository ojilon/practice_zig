# Exercises — Config & Flags Helper

Create the module source file(s); register module `p02_cfg`.

## Must implement

```zig
pub const Config = struct {
    // init(gpa: Allocator) Self            (stores allocator for file-loaded values)
    // deinit(self: *Self) void
    // parseArgs(self: *Self, args: []const []const u8) !void   (see flag forms below)
    // loadEnv(self: *Self, prefix: []const u8) !void           (PREFIX_NAME -> key mapping, document)
    // loadFile(self: *Self, text: []const u8) !void            (key=value lines; # comments; blanks skipped)
    // get(self: *const Self, key: []const u8) ?[]const u8
    // getInt(self: *const Self, key: []const u8, default: u64) !u64
    // getBool(self: *const Self, key: []const u8, default: bool) !bool
    // help(self: *const Self, w: *Sink, declared: []const FlagDecl) void-or-!void  (every accepted flag listed)
};

pub const FlagDecl = struct { name: []const u8, kind: enum { str, int, boolean }, desc: []const u8 };
```

Flag forms: `--key value`, `--key=value`, `--flag` (boolean true), positional list capture (`positionals() []const []const u8`), `--` terminator. Unknown flag → `error.UnknownFlag` naming the flag; flag missing its value → `error.MissingValue`.

## Tests
- Each form: `--key value`, `--key=value`, boolean, positionals, `--` terminator, combined realistic argv.
- Errors: unknown flag (assert name in error path), missing value, invalid int (reuse-parser error surfaces), invalid bool (`"yes"` policy documented + tested).
- Layers: file sets X, env overrides file, CLI overrides env; default returned when absent everywhere. At least one test pins the full precedence chain.
- File loader: comments/blank lines skipped; malformed line → `error.MalformedLine` with line number; quoted-value policy documented + tested.
- `--help` text contains every declared flag name.
- GPA-clean (file-loaded values freed in `deinit`); failing-allocator load test → error, prior entries intact.

## STRETCH
- `parseProcessArgs(gpa)` convenience reading real `std.process.args*` on your Zig version (test via injected slice version, not real process args).
- Subcommand sketch (`tool <cmd> [flags]` dispatch) OR typed `getEnum` via `StaticStringMap` (comptime reuse from Phase 1.05).
- `p02_log` bridge: `applyLogLevel(cfg, logger)` helper mapping `--log-level` to `p02_log.Level` with invalid-level error test.
- Comparison note: 5 lines on a fetched arg-lib (T4) — what it buys vs this helper.

## Notes
Number/bool parsing must delegate to shared helpers, not second implementations. State the delegation target at the top of the file.
