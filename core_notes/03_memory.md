# Memory & Allocators (critical)

Zig has no garbage collector. You choose and pass allocators.

## Key tools
- `std.heap.GeneralPurposeAllocator` — general purpose; enable safety/leak detection in debug/tests
- Arena allocators — bulk free at a clear lifetime boundary
- Fixed buffer allocator — for bounded, stack-like or pre-reserved memory
- `std.heap.page_allocator` — when you need pages directly

## Patterns
- Pass `Allocator` as a parameter to data structures and functions that allocate.
- Use `defer` and `errdefer` for cleanup.
- In tests, assert zero leaks when using GPA in safety mode.

## Ownership questions to answer for every structure
- Which allocator owns the memory?
- Who is responsible for `deinit` / free?
- Can the object outlive the current scope?

## Resources
- `std.mem.Allocator` and the various heap allocators in the standard library
- Zig documentation and talks on allocator design
