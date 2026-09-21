# Questions — Educational Hash Map + Set

1. What are your probe, tombstone, and resize policies (exact thresholds)? Why those numbers?
   > Your answer:

2. Tombstones vs backward-shift deletion: which did you pick and what breaks without it? (Which test proves it?)
   > Your answer:

3. Who owns key/value memory in your map? What changes for owned-string keys (STRETCH)?
   > Your answer:

4. What hasher + equality do you use per tested `K`, and why that hasher?
   > Your answer:

5. Describe your differential test: op mix, seed, N, oracle (what exactly did you compare against std)?
   > Your answer:

6. What did `std/hash_map.zig` do that surprised you (at least one thing you stole or rejected)?
   > Your answer:

7. Where will this map be reused — symbol table (Phase 8)? dedup index (Phase 3/4)? Name one concrete future importer.
   > Your answer:
