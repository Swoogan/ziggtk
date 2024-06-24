const std = @import("std");

const names = [_][]const u8{ "manual", "builder", "embedded" };

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const use_llvm = b.option(bool, "use-llvm", "use the LLVM backend");

    inline for (names) |n| {
        const exe = b.addExecutable(.{
            .name = n,
            .root_source_file = b.path("src/" ++ n ++ ".zig"),
            .optimize = optimize,
            .target = target,
            .use_llvm = use_llvm,
            .use_lld = use_llvm,
        });
        exe.linkLibC();
        exe.linkSystemLibrary("gtk4");
        b.installArtifact(exe);

        const run = b.addRunArtifact(exe);
        run.step.dependOn(b.getInstallStep());
        const step = b.step(n, "Run the " ++ n ++ " app");
        step.dependOn(&run.step);
    }
}
