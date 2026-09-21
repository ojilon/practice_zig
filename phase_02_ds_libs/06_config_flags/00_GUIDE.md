# 06 — Config & Flags Helper

> Modules: exposes `p02_cfg`. Reads: `std/process.zig` (args), `std/env`-equivalents on your Zig version, `02_basics` parse helpers (reuse them!).

## Why this exists
Every tool from Phase 4 on parses `argv`, reads env, and loads a small config
file — with the precedence `CLI > env > file > default` and clean errors for
missing/invalid values. One tested helper here saves every future tool from
re-implementing (and re-breaking) flag parsing. It also forces reuse: import
your `02_basics` integer parsing and your `p02_log` logger instead of
rewriting them.

## Steps (simple → complex)
1. `ArgParser` over `[][*:0]u8`-style raw args (or `[]const []const u8` slices in tests): `--key value`, `--key=value`, boolean `--flag`, positional capture, `--` terminator, `--help` text generation.
2. Typed access: `get`, `getInt` (reuse `tryParseU64`-style helper — no duplicate parse code), `getBool` with defaults + `error{MissingValue, InvalidValue, UnknownFlag}`-style set.
3. Env + file layers: env lookup by `PREFIX_NAME` mapping; `key=value` file loader (comments `#`, blank lines, quoted values or documented rejection of them).
4. Merge with precedence CLI > env > file > default; unknown-flag and missing-value errors name the flag.
5. Capstone prep: pair with `p02_log` so `--log-level warn` actually sets the logger — the exact wiring the capstone demo needs.

## Constraints
- Zero-dependency parsing (no `zig fetch` here — that lesson is T4 later). Borrowed slices for arg text; owned copies only for file-loaded values (document who frees the loaded table).
- Reuse, don't rewrite: number parsing delegates to your Phase 1 helper (imported or copied with attribution + a note on which).
- `--help` output is a required feature, not stretch: every flag the parser accepts appears in it.

## Done when
- `config.zig` exposes parser + typed getters + env/file loaders with precedence, unknown/missing/invalid tests, GPA-clean.
- A demo parses a realistic argv (`--count 5 --mode fast input.txt`), prints the merged config, and prints `--help`.
- The capstone wiring (`p02_cfg` → `p02_log` level) is proven in at least one test or demo line.

## Resources
- Local source: `std/process.zig` (arg iteration), your own `02_basics` parser.
- Growth hooks: T4 (subcommands + `zig fetch` arg-lib comparison later), T11 (parse katas reused here).
