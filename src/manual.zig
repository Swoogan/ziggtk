const gtk = @import("gtk.zig");

fn activate(app: *gtk.GtkApplication, _: gtk.gpointer) void {
    const window: *gtk.GtkWidget = gtk.gtk_application_window_new(app);

    const button_box: *gtk.GtkWidget = gtk.gtk_button_box_new(gtk.GTK_ORIENTATION_HORIZONTAL);
    gtk.gtk_container_add(@ptrCast(*gtk.GtkContainer, window), button_box);

    const button: *gtk.GtkWidget = gtk.gtk_button_new_with_label("Hello World");

    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(gtk.GCallback, &gtk.print_hello), null);
    _ = gtk.g_signal_connect_swapped_(button, "clicked", @ptrCast(gtk.GCallback, &gtk.gtk_widget_destroy), window);
    gtk.gtk_container_add(@ptrCast(*gtk.GtkContainer, button_box), button);

    const w = @ptrCast(*gtk.GtkWindow, window);
    gtk.gtk_window_set_title(w, "Window");
    gtk.gtk_window_set_default_size(w, 800, 600);
    gtk.gtk_widget_show_all(window);
}

pub fn main() u8 {
    var app = gtk.gtk_application_new("org.gtk.example", gtk.G_APPLICATION_FLAGS_NONE);
    defer gtk.g_object_unref(app);

    _ = gtk.g_signal_connect_(app, "activate", @ptrCast(gtk.GCallback, &activate), null);
    const status: i32 = gtk.g_application_run(@ptrCast(*gtk.GApplication, app), 0, null);

    return @intCast(u8, status);
}
