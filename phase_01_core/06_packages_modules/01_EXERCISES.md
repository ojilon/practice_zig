# Exercises — Packages & Modules

Create `lib.zig` + `main.zig` in this folder (plus build wiring — folder-local `build.zig` or an extension block in the root one; document your choice at the top of `00_GUIDE.md` answers).

## Must implement

1. `lib.zig` exposing at least:
   - `pub fn greeting(name: []const u8, buf: []u8) []u8` (writes into caller buffer, returns used slice — no allocation), and
   - `pub fn countWords(text: []const u8) usize` (borrowed slice, no allocation).
2. `main.zig` importing via `@import("p01_demo")` (module name — exact name your `build.zig` registers) and printing one `greeting` + one `countWords` result with `std.debug.print`.
3. Build wiring: module `p01_demo` → `lib.zig`; executable `p01_demo_exe` (or similar) → `main.zig` + `addImport("p01_demo", ...)`; test target covering `lib.zig`.
4. One boolean or enum build option (e.g. `-Dverbose`) that toggles extra demo output. Document the flag and default in a comment.

## Tests
- `countWords`: empty, single word, multiple spaces, leading/trailing whitespace.
- `greeting`: exact-fit buffer, truncation-or-error on too-small buffer (your documented choice), empty name.

## STRETCH
- Second importer: a second tiny exe or test that imports `p01_demo` without touching `main.zig`.
- Cross-compile record: paste the `zig build -Dtarget=...` command + result (pass/fail + one-line why).
- `b.option` string mode (`fast|thorough`) instead of boolean.

## Notes
Relative cross-folder `@import` is a fail for this folder. If your `main.zig` contains `"../"`, rewire it.
