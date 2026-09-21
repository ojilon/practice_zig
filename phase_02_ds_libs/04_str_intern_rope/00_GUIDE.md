# 04 — String Interner + Rope-ish Builder

> Modules: exposes `p02_str`. Reads: `std/HashMap` string variants, `std/io` buffered writer notes, `core_notes/04_collections.md`.

## Why this exists
Real tools dedup strings (keywords, paths, symbols) and assemble output
without quadratic copies. The interner gives you **identity-by-ID** (the
symbol-table primitive Phase 8 needs); the builder gives you chunked,
bounded-copy string assembly (the report/log builder Phase 4/5 need). Both
force you to answer "who owns these bytes?" for variable-length data.

## Steps (simple → complex)
1. `Interner`: `intern(s) -> ID (u32)`, `lookup(id) -> []const u8`. Same content → same ID; stored bytes owned by the interner (dupe on first insert), slices returned are borrowed.
2. Empty-string + large-input behaviour: define and test both (empty interns to a stable ID; 1MB string works or errors by documented policy).
3. `RopeBuilder` (rope-*ish*, honest scope): `append(chunk)`, `appendByte`, `len`, `toOwnedSlice(gpa)` / `writeTo(writer)`. Chunked storage internally (list of parts), single flatten at the end — no tree rebalancing in this folder.
4. Fuzz: random bytes/chunks roundtrip — interner never panics, builder flatten always equals naive concatenation (differential vs `ArrayList(u8)` appends).
5. Ownership map: one comment block showing lifetimes — interner owns pool, lookup borrows, builder parts owned until flatten transfers.

## Constraints
- Interner stores allocator at `init` (map-like lifetime); builder takes `gpa` per append OR stores it — document and be consistent with your map/ring choices.
- IDs stable across further interns (no renumbering on grow — test it).
- `lookup` on bad ID: return `?[]const u8` (null) or `error.InvalidId` — pick one, test it. No panic.

## Done when
- `strpool.zig` exposes both types with dedup, empty, bad-ID, builder-flatten, and fuzz-roundtrip tests, GPA-clean.
- A demo interns ~10 strings (with repeats), prints IDs proving dedup, builds one report string via the builder.
- You can state which Phase 8 structure imports the interner unchanged.

## Resources
- Local source: `std/hash_map.zig` (string-key ownership), `std/array_list.zig`.
- Growth hooks: T5 (bytes fuzz), T1 (arena-backed interner variant timing).
