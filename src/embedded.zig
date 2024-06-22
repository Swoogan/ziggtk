const gtk = @import("gtk.zig");

const file: *const [1496:0]u8 = @embedFile("./builder.ui");

pub fn main() u8 {
    gtk.gtk_init(0, null);

    const builder: *gtk.GtkBuilder = gtk.gtk_builder_new();
    var err: [*c]gtk.GError = null;

    // Construct a GtkBuilder instance and load our UI description
    if (gtk.gtk_builder_add_from_string(builder, file, file.len, &err) == 0) {
        gtk.g_printerr("Error loading embedded builder: %s\n", err.*.message);
        gtk.g_clear_error(&err);
        return 1;
    }

    // Connect signal handlers to the constructed widgets.
    const window: [*c]gtk.GObject = gtk.gtk_builder_get_object(builder, "window");

    const print_hello_callback: gtk.GCallback = @ptrCast(&gtk.print_hello);
    const main_quit_callback: gtk.GCallback = @ptrCast(&gtk.gtk_main_quit);

    _ = gtk._g_signal_connect(window, "destroy", main_quit_callback, null);

    var button = gtk.gtk_builder_get_object(builder, "button1");
    _ = gtk._g_signal_connect(button, "clicked", print_hello_callback, null);

    button = gtk.gtk_builder_get_object(builder, "button2");
    _ = gtk._g_signal_connect(button, "clicked", print_hello_callback, null);

    button = gtk.gtk_builder_get_object(builder, "quit");
    _ = gtk._g_signal_connect(button, "clicked", main_quit_callback, null);

    gtk.gtk_main();

    return 0;
}
