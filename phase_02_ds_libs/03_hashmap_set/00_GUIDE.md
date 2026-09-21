# 03 — Educational Hash Map + Set

> Modules: exposes `p02_map`. Reads: `std/hash_map.zig` (esp. `HashMap`, `getOrPut`, `AutoHashMap`), `std/hash/` (Wyhash/FNV notes).

## Why this exists
Maps are the first structure where **hashing, probing, deletion, and resize**
interact. Building a small open-addressing map yourself — then
differential-testing it against `std.HashMap` — teaches more than any chapter.
The set wrapper and the fuzz harness transfer directly to symbol tables
(Phase 8) and dedup indexes (Phase 3/4).

## Steps (simple → complex)
1. `HashMap(K, V)` with linear probing, fixed hasher story: `std.hash.Wyhash` or FNV for integers/strings — document the choice. Store the allocator at `init` (like `std.HashMap`), since maps do dozens of ops per lifetime.
2. Tombstones for deletion: `put/get/remove/contains/count`, `loadFactor()`-driven grow. Reinsert-after-remove must work — test it explicitly.
3. `Set(K)` wrapper over the map (value `void` or a private map instantiation); `add/remove/contains`, union/intersection helpers if cheap.
4. Differential test vs `std.HashMap`/`AutoHashMap` on the same random op stream (fixed seed): same gets, same counts, same iteration cardinality.
5. Read `std/hash_map.zig` `getOrPut` + growth policy; compare probe behaviour and write the takeaway.

## Constraints
- Open addressing with documented probe + tombstone + resize policy (e.g. grow at 70% incl. tombstones, rehash on tombstone ratio — your numbers, tested).
- Key ownership documented: for `K = u32`-style copy keys vs `[]const u8` string keys, state who dupes/frees. Simplest honest choice: copy-key map required; string-key support is STRETCH with explicit dupe rules.
- No silent rehash failure: growth OOM propagates, old table stays valid (test it).

## Done when
- `map.zig` exposes map + set with insert/get/remove/reinsert/resize/missing-key tests plus a ≥5k-op differential test, all GPA-clean.
- A demo inserts N keys, removes half, reinserts, and prints count + load factor + one `getOrPut`-style upsert.
- You can explain tombstones vs backward-shift deletion and why you picked one.

## Resources
- Local source: `std/hash_map.zig`, `std/hash/*.zig`.
- Growth hooks: T5 (differential fuzz is the deliverable), T6 (probe-length BENCH), T10 read-std quest.
