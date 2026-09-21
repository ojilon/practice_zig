# Exercises — Educational Hash Map + Set

Create the module source file(s); register module `p02_map`.

## Must implement

```zig
pub fn HashMap(comptime K: type, comptime V: type) type
    // init(allocator: Allocator) Self      (stores allocator, like std.HashMap)
    // deinit(self: *Self) void
    // put(self: *Self, key: K, value: V) !void
    // get(self: *const Self, key: K) ?V
    // getPtr(self: *Self, key: K) ?*V        (or documented omission with reason)
    // remove(self: *Self, key: K) bool
    // contains(self: *const Self, key: K) bool
    // count(self: *const Self) usize
    // loadFactor(self: *const Self) f64      (or percentage u8 — document)
    // getOrPut(self: *Self, key: K, default: V) !V  (upsert helper)

pub fn Set(comptime K: type) type
    // init/deinit/add/remove/contains/count (+ union/intersect if trivial on your impl)
```

Required instantiation in tests: at least `HashMap(u32, u64)` AND one second pair (e.g. `u64→[]const u8`-borrowed or a small struct key with custom hash/eq you document). String-owned keys are STRETCH.

## Tests
- Basic: put/get/overwrite/remove/missing-key/empty-map-get; count accuracy across ops.
- Tombstone: insert A,B (colliding if you can force it), remove A, get B; reinsert A; iterate-count == live count.
- Resize: insert past load threshold, verify all earlier keys still get; record capacity before/after in the test comment.
- `getOrPut`: new key inserts default, existing key returns stored (no overwrite).
- Differential (fixed seed, ≥5k mixed ops vs `std.AutoHashMap` or `std.HashMap`): same `count`, same per-key `get`s, same final iteration cardinality. GPA-clean both sides.
- Failure: failing allocator on growth → error propagates, old contents intact and readable.

## STRETCH
- Owned-string keys: `put` dupes via stored allocator, `remove`/`deinit` frees; test double-insert + remove + leak-free. (This is the symbol-table prototype for Phase 8.)
- Probe-length histogram + BENCH.md: avg/max probe at 50% vs 80% load; your resize-threshold justification.
- `ensureTotalCapacity` pre-reserve API + test.

## Notes
Copy-key semantics required; owned-key semantics stretch. State your hasher + equality for each tested `K` at the top of the file.
