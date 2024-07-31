const gtk = @import("gtk.zig");
const std = @import("std");

pub fn main() u8 {
    gtk.gtk_init(0, null);

    const builder: *gtk.GtkBuilder = gtk.gtk_builder_new();
    var err: [*c]gtk.GError = null;

    // Construct a GtkBuilder instance and load our UI description
    if (gtk.gtk_builder_add_from_file(builder, "src/builder.ui", &err) == 0) {
        gtk.g_printerr("Error loading file: %s\n", err.*.message);
        gtk.g_clear_error(&err);
        return 1;
    }

    // Connect signal handlers to the constructed widgets.
    const window = gtk.gtk_builder_get_object(builder, "window");

    _ = gtk.g_signal_connect_(window, "destroy", @ptrCast(&gtk.gtk_main_quit), null);

    var button = gtk.gtk_builder_get_object(builder, "button1");
    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(&gtk.print_hello), null);

    button = gtk.gtk_builder_get_object(builder, "button2");
    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(&gtk.print_hello), null);

    button = gtk.gtk_builder_get_object(builder, "quit");
    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(&gtk.gtk_main_quit), null);

    gtk.gtk_main();

    return 0;
}
