const std = @import("std");

// Scratch entry point — change imports and calls as you move between exercise packages.
// Reviewers ignore this file’s specific contents beyond “it builds”.

pub fn main() !void {
    // Note (Zig 0.16): `std.io.getStdOut()` is gone. The scratch runner uses
    // `std.debug.print` for now; proper stdout handling via `std.Io.File.stdout()`
    // + `File.writer()` is covered in Phase 1 exercises.
    std.debug.print("practice_zig scratch runner\n", .{});
    std.debug.print("Import the package you are currently practicing and call its demos here.\n", .{});
}

test "scratch smoke" {
    try std.testing.expect(true);
}
