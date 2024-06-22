const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const use_llvm = b.option(bool, "use-llvm", "use the LLVM backend");

    const manual_exe = b.addExecutable(.{
        .name = "manual",
        .root_source_file = b.path("src/manual.zig"),
        .optimize = optimize,
        .target = target,
        .use_llvm = use_llvm,
        .use_lld = use_llvm,
    });
    manual_exe.linkSystemLibrary("c");
    manual_exe.linkSystemLibrary("gtk+-3.0");
    b.installArtifact(manual_exe);

    const run_cmd_m = b.addRunArtifact(manual_exe);
    run_cmd_m.step.dependOn(b.getInstallStep());
    const run_step_m = b.step("manual", "Run the manual app");
    run_step_m.dependOn(&run_cmd_m.step);

    const builder_exe = b.addExecutable(.{
        .name = "builder",
        .root_source_file = b.path("src/builder.zig"),
        .optimize = optimize,
        .target = target,
        .use_llvm = use_llvm,
        .use_lld = use_llvm,
    });
    builder_exe.linkSystemLibrary("c");
    builder_exe.linkSystemLibrary("gtk+-3.0");
    b.installArtifact(builder_exe);

    const run_cmd_b = b.addRunArtifact(builder_exe);
    run_cmd_b.step.dependOn(b.getInstallStep());
    const run_step_b = b.step("builder", "Run the builder app");
    run_step_b.dependOn(&run_cmd_b.step);

    const embedded_exe = b.addExecutable(.{
        .name = "embedded",
        .root_source_file = b.path("src/embedded.zig"),
        .optimize = optimize,
        .target = target,
        .use_llvm = use_llvm,
        .use_lld = use_llvm,
    });
    embedded_exe.linkSystemLibrary("c");
    embedded_exe.linkSystemLibrary("gtk+-3.0");
    b.installArtifact(embedded_exe);

    const run_cmd_e = b.addRunArtifact(embedded_exe);
    run_cmd_e.step.dependOn(b.getInstallStep());
    const run_step_e = b.step("embedded", "Run the embedded builder app");
    run_step_e.dependOn(&run_cmd_e.step);
}
