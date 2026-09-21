# Modules & Build Wiring (read before `06_packages_modules`)

## Modules
- Each `.zig` file is a module. `pub` decides what importers see. `@import("name")` resolves via `build.zig`, not via relative paths across phases.
- Cross-phase imports always go through the build system: `mod.addImport("p02_ring", ring_mod)`, then `@import("p02_ring")` in code. Relative `@import("../...")` across phase folders is forbidden by dojo convention (see BUILD_CHAIN.md).
- One library folder → one module name `pXX_shortname` (e.g. `p02_log`).

## `build.zig` in Zig ≥ 0.15
```zig
const mod = b.addModule("p01_demo", .{
    .root_source_file = b.path("phase_01_core/06_packages_modules/demo.zig"),
    .target = target, .optimize = optimize,
});
const exe = b.addExecutable(.{
    .name = "p01_demo",
    .root_module = b.createModule(.{
        .root_source_file = b.path("phase_01_core/06_packages_modules/main.zig"),
        .target = target, .optimize = optimize,
    }),
});
exe.root_module.addImport("p01_demo", mod);
```
- `b.addTest(.{ .root_module = ... })` follows the same shape.
- Build options: `b.option(bool, "with-x", "...")` → `b.createModule(.{ ... })` + `@import("build_options")` for conditional compilation.
- Cross-compile early and often: `zig build -Dtarget=x86_64-linux` (or your second triple). Record what breaks.

## Resources
- Local source: `std/Build.zig`, `std/Build/Module.zig`.
- Growth: GROWTH_TRACKS.md T4 (build-system dojo).
