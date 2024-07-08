const gtk = @import("gtk.zig");

fn activate(app: *gtk.GtkApplication, _: gtk.gpointer) void {
    const window: *gtk.GtkWidget = gtk.gtk_application_window_new(app);

    const button_box: *gtk.GtkWidget = gtk.gtk_button_box_new(gtk.GTK_ORIENTATION_HORIZONTAL);
    gtk.gtk_container_add(@ptrCast(window), button_box);

    const button: *gtk.GtkWidget = gtk.gtk_button_new_with_label("Hello World");

    _ = gtk.g_signal_connect_(button, "clicked", @ptrCast(&gtk.print_hello), null);
    _ = gtk.g_signal_connect_swapped_(button, "clicked", @ptrCast(&gtk.gtk_widget_destroy), window);
    gtk.gtk_container_add(@ptrCast(button_box), button);

    const w: *gtk.GtkWindow = @ptrCast(window);
    gtk.gtk_window_set_title(w, "Window");
    gtk.gtk_window_set_default_size(w, 800, 600);
    gtk.gtk_widget_show_all(window);
}

pub fn main() u8 {
    const app = gtk.gtk_application_new("org.gtk.example", gtk.G_APPLICATION_FLAGS_NONE);
    defer gtk.g_object_unref(app);

    _ = gtk.g_signal_connect_(app, "activate", @ptrCast(&activate), null);
    const status: i32 = gtk.g_application_run(@ptrCast(app), 0, null);

    return @intCast(status);
}
