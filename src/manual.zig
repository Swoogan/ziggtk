const gtk = @import("gtk.zig");

fn activate(app: [*c]gtk.GtkApplication, _: gtk.gpointer) void {
    const window: [*c]gtk.GtkWindow = @ptrCast(gtk.gtk_application_window_new(app));
    const button_container: [*c]gtk.GtkWidget = gtk.gtk_center_box_new();
    const button: [*c]gtk.GtkWidget = gtk.gtk_button_new_with_label("Hello Word");
    gtk.gtk_widget_set_valign(button, gtk.GTK_ALIGN_CENTER);

    const print_hello_callback: gtk.GCallback = @ptrCast(&gtk.print_hello);
    const app_quit_callback: gtk.GCallback = @ptrCast(&gtk.g_application_quit);

    _ = gtk._g_signal_connect(button, "clicked", print_hello_callback, null);
    _ = gtk._g_signal_connect_swapped(button, "clicked", app_quit_callback, app);

    const button_container_box: *gtk.GtkCenterBox = @ptrCast(button_container);
    gtk.gtk_center_box_set_center_widget(button_container_box, button);

    gtk.gtk_window_set_child(window, button_container);
    gtk.gtk_window_set_title(window, "Window");
    gtk.gtk_window_set_default_size(window, 800, 600);
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
