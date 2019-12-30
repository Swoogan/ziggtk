pub usingnamespace @import("gtk.zig");
const std = @import("std");

pub fn main() u8 {
    gtk_init(0, null);

    const builder: *GtkBuilder = gtk_builder_new();
    var err: [*c]GError = null;

    // Construct a GtkBuilder instance and load our UI description 
    if (gtk_builder_add_from_file(builder, c"src/builder.ui", &err) == 0) {
        g_printerr(c"Error loading file: %s\n", err.*.message);
        g_clear_error(&err);
        return 1;
    }

    // Connect signal handlers to the constructed widgets. 
    const window = gtk_builder_get_object(builder, c"window");

    _ = g_signal_connect(window, c"destroy", @ptrCast(GCallback, gtk_main_quit), null);

    var button = gtk_builder_get_object(builder, c"button1");
    _ = g_signal_connect(button, c"clicked", @ptrCast(GCallback, print_hello), null);

    button = gtk_builder_get_object (builder, c"button2");
    _ = g_signal_connect(button, c"clicked", @ptrCast(GCallback, print_hello), null);

    button = gtk_builder_get_object (builder, c"quit");
    _ = g_signal_connect(button, c"clicked", @ptrCast(GCallback, gtk_main_quit), null);

    gtk_main();

    return 0;
}
