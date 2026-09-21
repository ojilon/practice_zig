# Exercises — Memory

## Must implement / demonstrate

1. Use `std.heap.DebugAllocator` (`GeneralPurposeAllocator` pre-0.16) to allocate and free a few values; show leak detection working.
2. Use an arena allocator for a set of temporary allocations and free them in one step.
3. Define a small struct that owns a dynamically allocated buffer (or list) and implements `deinit`.
4. Write at least one test that would fail on leak and passes when ownership is correct.

## Stretch
- Try a fixed-buffer allocator for a bounded workload.
- Pass an allocator into a function that builds a dynamic structure and returns it.

## Notes
Do not ignore leak detector output. Fix the issues it reports.
