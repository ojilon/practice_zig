# Exercises — Linked Lists

Create the module source file(s); register module `p02_list`.

## Must implement

```zig
pub fn SinglyLinkedList(comptime T: type) type // Node = struct { data: T, next: ?*Node }
    // prepend(self: *Self, gpa: Allocator, v: T) !void
    // popFirst(self: *Self, gpa: Allocator) ?T   (frees the node)
    // find(self: *const Self, needle: T) ?*Node  (requires T: comparable — document; or take an `eql` fn / predicate)
    // len(self: *const Self) usize
    // deinit(self: *Self, gpa: Allocator) void   (frees all nodes)

pub fn DoublyLinkedList(comptime T: type) type // Node = struct { data: T, prev/next: ?*Node }
    // prepend/append(self: *Self, gpa: Allocator, v: T) !void
    // remove(self: *Self, gpa: Allocator, node: *Node) T  (unlinks + frees, returns data)
    // popFirst/popLast(self: *Self, gpa: Allocator) ?T
    // len / deinit as above
```

Plus `fn removeWhere(self, gpa, predicate) usize` on at least one list (removal during iteration, returns removed count) — predicate as `fn (T) bool` or comptime callback, your documented choice.

## Tests
- Empty pop → null; single prepend→pop roundtrip; multi prepend order; remove head/middle/tail (doubly); `find` hit + miss.
- `removeWhere`: remove-none, remove-all, remove-alternating; verify surviving order + `len`; GPA-clean (the use-after-free catcher).
- Node-ownership: after `popFirst`/`remove`, GPA reports no leak and no double-free (double `deinit` safety: document whether `deinit` on emptied list is safe).
- Multi-node build failure: failing allocator mid-build → documented error, already-linked nodes freed (errdefer path tested).

## STRETCH
- Iterator type (`next() ?*Node` / values) supporting removal-safe traversal idiom.
- Arena-backed variant note: what changes if nodes come from an arena (who frees? what does `remove` do?).
- Intrusive-node sketch: 5 lines on when intrusive lists beat allocating lists.

## Notes
`find` needs an equality story for generic `T` — predicate, `eql` param, or `T == u32`-style constraint. Pick one, document it, test it.
