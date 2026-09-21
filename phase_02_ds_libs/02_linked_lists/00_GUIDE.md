# 02 — Linked Lists

> Modules: exposes `p02_list`. Reads: `std/SinglyLinkedList.zig`, `std/DoublyLinkedList.zig` (design only — re-implement, don't copy).

## Why this exists
Lists teach **node ownership** — the hardest memory idea before graphs, ASTs,
and arenas (Phase 8). Every node is individually allocated; every removal must
free exactly once; iteration must survive removal. Get this right with GPA
watching and later structures feel easy.

## Steps (simple → complex)
1. `SinglyLinkedList(T)`: nodes hold `data: T` + `next`. `prepend`, `popFirst`, `find`, `len`. Nodes allocated with the passed `gpa`, freed on removal/`deinit`.
2. `DoublyLinkedList(T)`: `append`, `prepend`, `remove(node)`, forward/backward iteration. Document who may hold a `*Node` and for how long.
3. Removal-during-iteration demo: delete matching nodes in one pass without use-after-free (the classic bug — prove with GPA + a dedicated test).
4. Ownership doc: a comment block stating allocator flow, `deinit` contract, and whether `T` itself may own memory (and what that implies for `deinit`).
5. Compare with `std.SinglyLinkedList` / `DoublyLinkedList` source: one stolen idea, one deliberately rejected idea.

## Constraints
- Re-implement the mechanics yourself; reading std for design is required, copying bodies is not.
- Allocator per mutating operation (`prepend(gpa, ...)`, `deinit(gpa)`); store nothing global. If `T` owns memory, document whether the list frees it (and how the caller says so).
- No length caching lies: either maintain `len` exactly or compute it — state which and test it across removals.

## Done when
- `lists.zig` exposes both list types with empty/single/multi/remove-head-middle-tail tests, all GPA-clean.
- A demo builds a list, removes during iteration, and prints before/after with lengths.
- You can explain why arenas make lists easier — and why this folder still uses GPA (foreshadows Phase 8 arena usage).

## Resources
- Local source: `std/SinglyLinkedList.zig`, `std/DoublyLinkedList.zig`.
- Growth hooks: T1 (GPA vs arena-backed list timing), T3 (errdefer on multi-node build failure).
