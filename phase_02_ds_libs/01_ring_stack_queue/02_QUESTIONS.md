# Questions — Stack, Queue, Ring Buffer

1. What Queue strategy did you pick, and what is its amortized cost? When does it compact, and who pays?
   > Your answer:

2. What is your Ring's push-on-full policy (error vs overwrite)? Why did you choose it, and which future user (tokenizer? log tail?) wants the other one?
   > Your answer:

3. Why does the Ring store its allocator from `init` while Stack/Queue take `gpa` per operation? Is that consistent with `std.HashMap` vs `std.ArrayList`?
   > Your answer:

4. What did your injected-failure test prove (exact error, length before/after, usability after)?
   > Your answer:

5. What did `std/deque.zig` do differently from your Queue, and what (if anything) will you steal?
   > Your answer:

6. Which Phase 3/5 structure will import `p02_ring`, and for what buffer?
   > Your answer:
