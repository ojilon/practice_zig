# Build System Basics

Zig projects are driven by `build.zig`.

## Minimal mental model
- `build.zig` is a Zig program that describes how to build your project.
- You add executables, libraries, and tests through the `Build` API.
- `zig build`, `zig build run`, `zig build test` are the common entry points.

## Habits to form early
- Prefer packages/modules over ad-hoc single files once you leave the absolute basics.
- Put tests next to the code they exercise.
- Keep the build graph understandable; avoid unnecessary complexity.

## Resources
- Official Zig build system documentation
- `std.Build` source and examples in real projects
