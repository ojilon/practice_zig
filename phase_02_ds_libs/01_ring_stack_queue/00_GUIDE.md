# 01 — Stack, Queue, Ring Buffer

> Modules: exposes `p02_ring`. Reads: `std/deque.zig`, `std/array_list.zig` (growth), `core_notes/04_collections.md`.

## Why this exists
Bounded and growable FIFO/LIFO structures underpin everything later: token
buffers (Phase 3), work queues (Phase 4 tools), input history and view
scrollback (Phase 5 TUI), packet/log staging (Phase 6). This folder makes
wrap-around indexing and full/empty discipline boring — which is exactly what
you want before parsers depend on it.

## Steps (simple → complex)
1. `Stack(T)`: growable LIFO over unmanaged `ArrayList(T)`. The easy warmup — port your Phase 1 `05` sketch into a real tested generic.
2. `Queue(T)`: growable FIFO. Pick your strategy up front (head-index + compaction vs chunked blocks) and document the amortized claim in one paragraph.
3. `RingBuffer(T)`: **fixed-capacity** circular buffer created with `init(gpa, capacity)`. Overwrite-or-error policy is yours — but document it, test the wrap-around explicitly, and never silently drop on the error path.
4. Allocator + failure tests: GPA-clean happy paths; one injected-failure test proving `Queue`/`Stack` growth failure leaves the structure usable (length unchanged, no leak).
5. Read `std/deque.zig` header; write a 5-line takeaway comparing its strategy to yours.

## Constraints
- Generics via `comptime T: type`. Allocator per operation (`push(gpa, ...)`, `deinit(gpa)`); the fixed-capacity ring stores its allocator from `init` (document why: bounded single allocation).
- No `anyerror` in public APIs — name the error sets (`error{OutOfMemory} || error{Full} || error{Empty}` as applicable).
- `pop` on empty returns `?T` (null), never panics. Full-ring `push` returns `error.Full` OR overwrites by documented policy — pick one, test it, never both-at-random.

## Done when
- `ring.zig` (or `stack.zig`/`queue.zig`/`ring.zig` trio) exposes the required symbols with wrap-around, full/empty, and failure tests green under GPA.
- A demo fills, drains, wraps, and overfills each structure, printing the observable transitions.
- You can state which structure backs a tokenizer buffer vs an undo stack vs a log tail — and why.

## Resources
- Local source: `std/deque.zig`, `std/array_list.zig`.
- Growth hooks: T1 (time stack-vs-ring for 1M pushes), T5 (random-op invariant test), T10 read-std quest.
