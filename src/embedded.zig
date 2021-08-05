pub usingnamespace @import("gtk.zig");
const std = @import("std");

const builderDecl = @embedFile("./builder.ui");

pub fn main() u8 {
    gtk_init(0, null);

    const builder: *GtkBuilder = gtk_builder_new();
    var err: [*c]GError = null;

    var bdp: [*c]const u8 = builderDecl;

    // Construct a GtkBuilder instance and load our UI description
    if (gtk_builder_add_from_string(builder, bdp, builderDecl.len, &err) == 0) {
        g_printerr("Error loading embedded builder: %s\n", err.*.message);
        g_clear_error(&err);
        return 1;
    }

    // Connect signal handlers to the constructed widgets.
    const window = gtk_builder_get_object(builder, "window");

    var zero: u32 = 0;
    const flags: *GConnectFlags = @ptrCast(*GConnectFlags, &zero);

    _ = flags;

    _ = g_signal_connect_(window, "destroy", @ptrCast(GCallback, gtk_main_quit), null);

    var button = gtk_builder_get_object(builder, "button1");
    _ = g_signal_connect_(button, "clicked", @ptrCast(GCallback, print_hello), null);

    button = gtk_builder_get_object(builder, "button2");
    _ = g_signal_connect_(button, "clicked", @ptrCast(GCallback, print_hello), null);

    button = gtk_builder_get_object(builder, "quit");
    _ = g_signal_connect_(button, "clicked", @ptrCast(GCallback, gtk_main_quit), null);

    gtk_main();

    return 0;
}
