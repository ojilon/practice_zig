# Exercises — Stack, Queue, Ring Buffer

Create the module source file(s) in this folder; register module `p02_ring` in build wiring.

## Must implement

```zig
pub fn Stack(comptime T: type) type // methods:
    // push(self: *Self, gpa: Allocator, v: T) !void
    // pop(self: *Self) ?T
    // peek(self: *const Self) ?T
    // len(self: *const Self) usize
    // deinit(self: *Self, gpa: Allocator) void

pub fn Queue(comptime T: type) type // methods:
    // enqueue(self: *Self, gpa: Allocator, v: T) !void
    // dequeue(self: *Self) ?T
    // peek(self: *const Self) ?T
    // len(self: *const Self) usize
    // deinit(self: *Self, gpa: Allocator) void

pub fn RingBuffer(comptime T: type) type // fixed capacity; methods:
    // init(gpa: Allocator, capacity: usize) !Self   (capacity 0 => error.InvalidCapacity)
    // deinit(self: *Self) void                      (uses stored allocator)
    // push(self: *Self, v: T) !void  — OR pushOverwrite(self: *Self, v: T) ?T (evicted or null); document + implement exactly one policy
    // pop(self: *Self) ?T
    // peek(self: *const Self) ?T
    // len / capacity / isEmpty / isFull
```

Document at the top of the file: Queue strategy (head-index/compaction or other + amortized claim) and Ring push policy.

## Tests
- Stack: push/pop order (LIFO), peek stability, pop-empty → null, two `T`s (e.g. `u32` + a struct), GPA-clean.
- Queue: FIFO order across ≥2x growth, dequeue-empty → null, head-wrap (enqueue/dequeue interleaved ≥ capacity*3 ops), GPA-clean.
- Ring: fill→full, drain→empty, wrap (push/pop interleaved past capacity), overfill follows documented policy, `capacity==0` init error, GPA-clean.
- Failure: failing/tiny allocator on `enqueue`/`push` growth → `error.OutOfMemory`, length unchanged, still usable after.

## STRETCH
- Random-op invariant test (fixed seed): interleave push/pop N=10k times, assert `len` matches model count and drain yields expected items.
- `Deque` sketch (push/pop both ends) OR SPSC-ring notes: what would need atomics and why this folder's ring is *not* thread-safe (3 lines).
- BENCH.md: 1M `u32` pushes — Stack vs Queue vs Ring(reused); one-paragraph interpretation.

## Notes
No thread-safety claims. No hidden allocation. Later importers: Phase 3 tokenizer buffer, Phase 5 scrollback.
