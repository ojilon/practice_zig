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

## Rules

- Prefer understanding + re-implementation over large copy-paste.
- Attribute significant design ideas.
- Every exploration that claims an implementation must have a runnable demo.
