const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    
    const manual = b.addExecutable("manual", "src/manual.zig");

    manual.linkSystemLibrary("c");
    manual.linkSystemLibrary("gtk+-3.0");
    manual.setBuildMode(mode);

    manual.install();

    const builder = b.addExecutable("builder", "src/builder.zig");

    builder.linkSystemLibrary("c");
    builder.linkSystemLibrary("gtk+-3.0");
    builder.setBuildMode(mode);

    builder.install();

    const embedded = b.addExecutable("embedded", "src/embedded.zig");

    embedded.linkSystemLibrary("c");
    embedded.linkSystemLibrary("gtk+-3.0");
    embedded.setBuildMode(mode);

    embedded.install();

    const run_cmd_m = manual.run();
    run_cmd_m.step.dependOn(b.getInstallStep());

    const run_cmd_b = builder.run();
    run_cmd_b.step.dependOn(b.getInstallStep());

    const run_cmd_e = embedded.run();
    run_cmd_e.step.dependOn(b.getInstallStep());

    const run_step_m = b.step("manual", "Run the manual app");
    run_step_m.dependOn(&run_cmd_m.step);

    const run_step_b = b.step("builder", "Run the builder app");
    run_step_b.dependOn(&run_cmd_b.step);

    const run_step_e = b.step("embedded", "Run the embedded builder app");
    run_step_e.dependOn(&run_cmd_e.step);
}
