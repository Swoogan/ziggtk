const gtk = @import("gtk.zig");

fn activate(app: *gtk.GtkApplication, _: gtk.gpointer) void {
    const window: *gtk.GtkWidget = gtk.gtk_application_window_new(app);
    const window_container: *gtk.GtkContainer = @ptrCast(window);
    const button_box: *gtk.GtkWidget = gtk.gtk_button_box_new(gtk.GTK_ORIENTATION_HORIZONTAL);
    const button_box_container: *gtk.GtkContainer = @ptrCast(button_box);

    gtk.gtk_container_add(window_container, button_box);

    const button: *gtk.GtkWidget = gtk.gtk_button_new_with_label("Hello World");
    const print_hello_callback: gtk.GCallback = @ptrCast(&gtk.print_hello);
    const widget_destroy_callback: gtk.GCallback = @ptrCast(&gtk.gtk_widget_destroy);

    _ = gtk._g_signal_connect(button, "clicked", print_hello_callback, null);
    _ = gtk._g_signal_connect_swapped(button, "clicked", widget_destroy_callback, window);
    gtk.gtk_container_add(button_box_container, button);

    const w: *gtk.GtkWindow = @ptrCast(window);
    gtk.gtk_window_set_title(w, "Window");
    gtk.gtk_window_set_default_size(w, 800, 600);
    gtk.gtk_widget_show_all(window);
}

pub fn main() u8 {
    const app: [*c]gtk.GtkApplication = gtk.gtk_application_new("org.gtk.example", gtk.G_APPLICATION_FLAGS_NONE);
    defer gtk.g_object_unref(app);

    const activate_callback: gtk.GCallback = @ptrCast(&activate);
    _ = gtk._g_signal_connect(app, "activate", activate_callback, null);

    const gtkApp: *gtk.GApplication = @ptrCast(app);
    const status: u8 = @intCast(gtk.g_application_run(gtkApp, 0, null));

    return status;
}
