const gtk = @import("gtk.zig");
const std = @import("std");

const builderDecl = @embedFile("./builder.ui");

pub fn main() u8 {
    gtk.gtk_init(0, null);

    const builder: *gtk.GtkBuilder = gtk.gtk_builder_new();
    var err: [*c]gtk.GError = null;

    var bdp: [*c]const u8 = builderDecl;

    // Construct a GtkBuilder instance and load our UI description
    if (gtk.gtk_builder_add_from_string(builder, bdp, builderDecl.len, &err) == 0) {
        gtk.g_printerr("Error loading embedded builder: %s\n", err.*.message);
        gtk.g_clear_error(&err);
        return 1;
    }

    // Connect signal handlers to the constructed widgets.
    const window = gtk.gtk_builder_get_object(builder, "window");

    _ = gtk.g_signal_connect_(window, "destroy", @ptrCast(gtk.GCallback, &gtk.gtk_main_quit), null);

    var button = gtk.gtk_builder_get_object(builder, "button1");
    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(gtk.GCallback, &gtk.print_hello), null);

    button = gtk.gtk_builder_get_object(builder, "button2");
    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(gtk.GCallback, &gtk.print_hello), null);

    button = gtk.gtk_builder_get_object(builder, "quit");
    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(gtk.GCallback, &gtk.gtk_main_quit), null);

    gtk.gtk_main();

    return 0;
}
