# Slices, Arrays, Lists (read before `04_slices_arrays_lists`)

## Slices & arrays
- `[N]T` is a value (copied on assign); `[]T` / `[]const u8` is pointer+length. `&arr` → slice via `arr[0..]`.
- Sentinel slices `[:0]u8` are for C interop; otherwise prefer plain slices + explicit length.
- `for (items, 0..) |x, i|` for indexed loops. `std.mem.eql`, `startsWith`, `indexOf` cover the common cases — don't hand-roll them in real code, but do hand-roll them once as a kata (GROWTH_TRACKS.md T11).
- In-place ops (reverse, dedup of sorted input) should take `[]T` and return lengths/counts, allocating nothing.

## `std.ArrayList` in Zig ≥ 0.15 (unmanaged — this is the current API)
```zig
var list: std.ArrayList(u32) = .empty;
defer list.deinit(gpa);
try list.append(gpa, 42);               // allocator passed per operation
try list.ensureTotalCapacity(gpa, 1024); // bulk-reserve before hot loops
const owned: []u32 = try list.toOwnedSlice(gpa); // caller now owns; list is empty
```
- `array_list.Managed` / `ArrayList.init(gpa)` are **deprecated**. Translate old tutorials to the form above.
- `deinit(gpa)` takes the allocator. Forgetting the `gpa` arg is the #1 compile error when porting old code.
- Growth doubles-ish; `ensureTotalCapacityPrecise` avoids over-reserve when you know the exact size.
- `MultiArrayList` exists for struct-of-arrays layouts — know it exists, use it in Phase 3+.

## OOM discipline
- Almost every append/resize returns `error.OutOfMemory`. Propagate with `try`; tests should cover the OOM path at least once via a failing allocator (see `07_testing_style`).
- Prefer bulk `ensureTotalCapacity` + `appendAssumeCapacity` inside measured hot loops; keep the safe path as default.

## Resources
- Local source: `std/array_list.zig` (read `Aligned.append`, `ensureTotalCapacity`, `toOwnedSlice`), `std/mem.zig` helpers.
