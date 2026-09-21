# Questions — Linked Lists

1. Draw (in words) the pointer updates for doubly-linked `remove(middle)`. What breaks if you free before unlinking?
   > Your answer:

2. Who owns each `Node`, and when is it freed? What happens to `T`'s own memory (if any) on removal?
   > Your answer:

3. How does `removeWhere` avoid use-after-free while deleting during traversal? (Which pointer do you save first?)
   > Your answer:

4. What did your multi-node build-failure test prove about `errdefer` placement?
   > Your answer:

5. What did you steal from std's lists, and what did you deliberately reject?
   > Your answer:

6. Where will arenas replace per-node GPA allocation later (which phase), and what gets simpler / harder?
   > Your answer:
