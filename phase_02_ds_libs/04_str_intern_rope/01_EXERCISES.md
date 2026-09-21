# Exercises — String Interner + Rope-ish Builder

Create the module source file(s); register module `p02_str`.

## Must implement

```zig
pub const Id = u32;
pub const Interner = struct {
    // init(gpa: Allocator) Self   (stores allocator)
    // deinit(self: *Self) void
    // intern(self: *Self, s: []const u8) !Id   (dupes bytes on first insert; same content -> same Id)
    // lookup(self: *const Self, id: Id) ?[]const u8
    // count(self: *const Self) usize
};

pub const RopeBuilder = struct {
    // init(gpa: Allocator) Self  (or per-op gpa — document; be consistent)
    // deinit(self: *Self) void   (frees un-flattened parts)
    // append(self: *Self, chunk: []const u8) !void
    // appendByte(self: *Self, b: u8) !void
    // len(self: *const Self) usize
    // toOwnedSlice(self: *Self) ![]u8   (caller owns; builder reset to empty)
};
```

## Tests
- Interner: same string twice → same ID; different strings → different IDs; empty string stable ID; `lookup` roundtrip for all; bad ID → null; ID stability after 1k+ further interns (no renumbering); GPA-clean.
- Builder: append chunks incl. empty chunks; `len` accuracy; flatten equals expected literal; `toOwnedSlice` transfers (builder empty after, caller frees); GPA-clean.
- Fuzz (fixed seed): 1k random chunk sequences → builder flatten `eql` naive `ArrayList(u8)` concatenation; random byte strings → interner never errors except OOM, lookups roundtrip.
- Failure: failing allocator on `intern`/`append` → error, prior IDs/parts intact.

## STRETCH
- `writeTo(writer)` streaming flatten (no intermediate big alloc) + test via fixed-buffer writer.
- Case-insensitive or normalized interning variant (`internNormalized` with documented normalization) — or explain in 3 lines why you refused it.
- Arena-backed interner: pool in arena, `deinit` = single free; benchmark vs GPA version (T1), one-paragraph note.
- `charAt(index)` / `sliceRange` over the builder without flattening.

## Notes
Borrowed-in, owned-inside, borrowed-out: callers lend `intern` their bytes; the pool owns copies; `lookup` lends back. State this in the file header.
