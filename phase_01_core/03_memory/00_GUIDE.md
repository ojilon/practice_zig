# 03 — Memory & Allocators

> Prerequisite: `core_notes/03_memory.md`  
> This is one of the most important early folders.

## Why this exists
Almost all non-trivial Zig code allocates. You need to be comfortable choosing an allocator, passing it, freeing correctly, and detecting leaks.

## Steps (simple → complex)
1. Allocate and free with `std.heap.DebugAllocator` (named `GeneralPurposeAllocator` before Zig 0.16); enable safety checks.
2. Use an arena for a group of short-lived allocations and free them together.
3. Write a small struct that owns heap memory and has a clear `deinit`.
4. Demonstrate a deliberate leak being caught by the GPA in a test or debug run, then fix it.
5. Document ownership for the struct you created.

## Constraints
- Prefer explicit allocator parameters.
- Tests should fail if you leak on the happy path (when safety is on).

## Done when
- You can allocate, free, and use an arena correctly.
- A test or debug run shows clean leak detection after you fix intentional mistakes.
- You can explain who owns the memory in your example struct.
