const std = @import("std");

// Scratch entry point — change imports and calls as you move between exercise packages.
// Reviewers ignore this file’s specific contents beyond “it builds”.

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("practice_zig scratch runner\n", .{});
    try stdout.print("Import the package you are currently practicing and call its demos here.\n", .{});
}

test "scratch smoke" {
    try std.testing.expect(true);
}
