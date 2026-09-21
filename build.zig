const std = @import("std");

// Scratch / root build file for the practice_zig dojo.
// As you create packages, add them here as modules, executables, or tests.
// Future agents and the learner will extend this file.

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Example executable (scratch runner). Replace / extend as you go.
    const exe = b.addExecutable(.{
        .name = "practice_zig",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the scratch executable");
    run_step.dependOn(&run_cmd.step);

    // Placeholder test step — add real tests as packages appear.
    const unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_unit_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
