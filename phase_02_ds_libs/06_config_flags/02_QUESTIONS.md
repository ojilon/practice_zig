# Questions — Config & Flags Helper

1. What is your merge precedence (CLI/env/file/default), and which test pins the full chain?
   > Your answer:

2. Who owns file-loaded value strings, and when are they freed? What about argv/env borrowed strings?
   > Your answer:

3. Where does number/bool parsing actually live (which shared helper), and why not a second copy here?
   > Your answer:

4. What are your exact error cases (unknown/missing/invalid/malformed), and which one names the flag + line number?
   > Your answer:

5. What does your `--help` guarantee, and how is it tested?
   > Your answer:

6. How does `--log-level` reach `p02_log`? (Bridge helper, mapping table, invalid-level behaviour.)
   > Your answer:

7. The capstone imports `p02_cfg` + `p02_log` + one container — sketch its argv and what each module does for it.
   > Your answer:
