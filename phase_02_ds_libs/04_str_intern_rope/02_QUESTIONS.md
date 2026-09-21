# Questions — String Interner + Rope-ish Builder

1. Who owns the bytes at each step: caller → `intern` → pool → `lookup` → caller? When are they freed?
   > Your answer:

2. How do you guarantee ID stability across growth? (What would renumber them, and how did you prevent it?)
   > Your answer:

3. Why is your builder "rope-ish" and not a real rope? What did you deliberately leave out (rebalancing? tree ops?)?
   > Your answer:

4. What did your fuzz test compare, and what was the oracle? Seed + N?
   > Your answer:

5. Empty string and 1MB string: what does your interner do for each, and why that policy?
   > Your answer:

6. Which Phase 8 component imports the interner, and what changes (if anything) when it does?
   > Your answer:
