const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const manual = b.addExecutable(.{
        .name = "manual",
        .root_source_file = b.path("src/manual.zig"),
        .target = target,
        .optimize = optimize,
    });

    manual.linkSystemLibrary("c");
    manual.linkSystemLibrary("gtk+-3.0");

    b.installArtifact(manual);

    const builder = b.addExecutable(.{
        .name = "builder",
        .root_source_file = b.path("src/builder.zig"),
        .target = target,
        .optimize = optimize,
    });

    builder.linkSystemLibrary("c");
    builder.linkSystemLibrary("gtk+-3.0");

    b.installArtifact(builder);

    const embedded = b.addExecutable(.{
        .name = "embedded",
        .root_source_file = b.path("src/embedded.zig"),
        .target = target,
        .optimize = optimize,
    });

    embedded.linkSystemLibrary("c");
    embedded.linkSystemLibrary("gtk+-3.0");

    b.installArtifact(embedded);

    const run_cmd_m = b.addRunArtifact(manual);
    run_cmd_m.step.dependOn(b.getInstallStep());

    const run_cmd_b = b.addRunArtifact(builder);
    run_cmd_b.step.dependOn(b.getInstallStep());

    const run_cmd_e = b.addRunArtifact(embedded);
    run_cmd_e.step.dependOn(b.getInstallStep());

    const run_step_m = b.step("manual", "Run the manual app");
    run_step_m.dependOn(&run_cmd_m.step);

    const run_step_b = b.step("builder", "Run the builder app");
    run_step_b.dependOn(&run_cmd_b.step);

    const run_step_e = b.step("embedded", "Run the embedded builder app");
    run_step_e.dependOn(&run_cmd_e.step);
}
