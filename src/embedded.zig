const gtk = @import("gtk.zig");

const file: *const [1476:0]u8 = @embedFile("./window.ui");

fn activate(app: [*c]gtk.GtkApplication, _: gtk.gpointer) void {
    const builder: *gtk.GtkBuilder = gtk.gtk_builder_new().?;
    defer gtk.g_object_unref(builder);
    var err: [*c]gtk.GError = null;

    if (gtk.gtk_builder_add_from_string(builder, file, file.len, &err) == 0) {
        gtk.g_printerr("Error loading embedded file: %s\n", err.*.message);
        gtk.g_clear_error(&err);
    }

    const window: [*c]gtk.GtkWindow = @ptrCast(gtk.gtk_builder_get_object(builder, "window"));
    gtk.gtk_window_set_application(window, app);

    const print_hello_callback: gtk.GCallback = @ptrCast(&gtk.print_hello);
    const app_quit_callback: gtk.GCallback = @ptrCast(&gtk.g_application_quit);

    var button = gtk.gtk_builder_get_object(builder, "button1");
    _ = gtk._g_signal_connect(button, "clicked", print_hello_callback, null);

    button = gtk.gtk_builder_get_object(builder, "button2");
    _ = gtk._g_signal_connect(button, "clicked", print_hello_callback, null);

    button = gtk.gtk_builder_get_object(builder, "quit");
    _ = gtk._g_signal_connect_swapped(button, "clicked", app_quit_callback, app);

    gtk.gtk_window_present(window);
}

pub fn main() u8 {
    const app: [*c]gtk.GtkApplication = gtk.gtk_application_new("org.gtk.example", gtk.G_APPLICATION_DEFAULT_FLAGS);
    defer gtk.g_object_unref(app);

    const activate_callback: gtk.GCallback = @ptrCast(&activate);
    _ = gtk._g_signal_connect(app, "activate", activate_callback, null);

    const g_app: [*c]gtk.GApplication = @ptrCast(app);
    const status: u8 = @intCast(gtk.g_application_run(g_app, 0, null));

    return status;
}
