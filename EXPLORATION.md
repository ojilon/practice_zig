# Exploration — Papers, Specs, and Real Systems

A large part of this dojo is deliberate reading followed by implementation.

---

## 1. Reading Zig itself

- `std` library source (allocators, ArrayList, json, fs, os, Thread, etc.)
- Zig’s own `build.zig` patterns in real projects
- Small high-quality Zig codebases (tools, parsers, games, embedded examples)

Method: read for allocator choices, error handling style, and build structure; then re-implement the *idea* at a smaller scale.

---

## 2. Research papers & classic systems literature

Good adventure targets:
- Allocator and memory management papers
- Classic OS papers (UNIX, early virtual memory, etc.) — extract one implementable idea
- Parsing and compiler papers (selective chapters or short papers)
- Concurrent data structure papers (keep scope tiny and safe)
- Numerical / geometric / noise papers that fit a few days of work

For each: implement a minimal version, write what you learned, and note what you deliberately simplified.

---

## 3. Format specifications (document & media)

Practical parsing adventures:
- XML 1.0 (subset) or HTML tokenization ideas
- PDF specification excerpts (objects, xref, trailer) — read-only subset is enough
- WAV / RIFF
- Simplified ISO BMFF / MP4 box structure concepts
- Any small binary format you design yourself and then fully support

Always prefer the official or primary specification when practical; secondary explanations are fine for orientation.

---

## 4. TUI & tools inspiration

- Existing Zig TUI experiments
- Classic terminal UI design ideas
- Small, focused Unix-style tools whose source you can read

---

## 5. Compiler / language resources (later phases)

- “Crafting Interpreters” (ideas, not a port)
- Selective chapters from classic compiler texts
- Zig compiler source as inspiration for structure and discipline (not for copying)

---

## 6. Collecting best practices

Keep a living notes file of patterns you adopt or reject, with origin and rationale. This becomes valuable when productizing and when writing your own libraries.

---

## 7. Concrete adventure backlog (ordered easy → hard)

Pull from here when a phase says "pick a paper / spec". Each entry is scoped to 1–4 days.

**Specs (with primary source to cite in your takeaway):**
1. WAV/RIFF chunk walk — Microsoft/IBM WAVE spec excerpt; implement chunk listing + duration math.
2. CSV with quoting (RFC 4180 spirit) — streaming row reader, fuzz with random quotes/commas.
3. JSON subset — ECMA-404; strict number handling is the interesting part.
4. XML 1.0 subset (W3C REC-xml) — entities + well-formedness errors with byte offsets.
5. PDF objects/xref/trailer (ISO 32000 excerpt) — read-only: parse `obj…endobj`, `xref`, `trailer`.
6. ISO BMFF box walk (ISO/IEC 14496-12 excerpt) — recursive box listing without full codec support.

**Papers / classic ideas (implement the core, simulate the rest):**
1. A ring-buffer / bounded-queue discipline note — implement SPSC ring, benchmark vs mutex queue.
2. An allocator-strategy sketch (arena / slab / free-list) — implement one, measure fragmentation qualitatively.
3. A string-matching core (e.g. KMP or Boyer-Moore-Horspool idea) — differential-test vs `std.mem.indexOf`.
4. A sorting-experiment note — instrument comparison counts on your own data, compare to `std.sort`.
5. A replication/log toy *simulator* with deterministic fault injection (not a networked system).
6. A bytecode-VM idea note — constant pool + dispatch loop (runway into Phase 8).

**Read-std quests (30–60 min each, see GROWTH_TRACKS.md T10):**
`array_list.zig` → `hash_map.zig` → `heap/arena_allocator.zig` → `log.zig` → `json.zig` → `Build.zig`.

---

## Rules

- Prefer understanding + re-implementation over large copy-paste.
- Attribute significant design ideas.
- Every exploration that claims an implementation must have a runnable demo.
