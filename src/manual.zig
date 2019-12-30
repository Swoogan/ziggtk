pub usingnamespace @cImport({
    @cInclude("gtk/gtk.h");
});

const std = @import("std");

fn print_hello(widget: *GtkWidget, data: gpointer) void {
    g_print (c"Hello World\n");
}

fn activate(app: *GtkApplication, user_data: gpointer) void {
    const window: *GtkWidget = gtk_application_window_new(app);

    const button_box: *GtkWidget = gtk_button_box_new(.GTK_ORIENTATION_HORIZONTAL);
    gtk_container_add (@ptrCast(*GtkContainer, window), button_box);

    const button: *GtkWidget = gtk_button_new_with_label(c"Hello World");

    var zero: u32 = 0;
    const flags: *GConnectFlags = @ptrCast(*GConnectFlags, &zero);
    // could not get `g_signal_connect` to work. Zig says "use of undeclared identifier"
    const sig = g_signal_connect_data(button, c"clicked", @ptrCast(GCallback, print_hello), null, null, flags.*);

    // could not get `g_signal_connect_swapped` to work. Zig says "use of undeclared identifier"
    const swap = g_signal_connect_data(button, c"clicked", @ptrCast(GCallback, gtk_widget_destroy), window, null, .G_CONNECT_SWAPPED);
    gtk_container_add (@ptrCast(*GtkContainer, button_box), button);

    const w = @ptrCast(*GtkWindow, window);
    gtk_window_set_title(w, c"Window");
    gtk_window_set_default_size(w, 800, 600);
    gtk_widget_show_all(window);
}

pub fn main() u8 {
    var app = gtk_application_new(c"org.gtk.example", .G_APPLICATION_FLAGS_NONE);
    defer g_object_unref(app);

    var zero: u32 = 0;
    const flags: *GConnectFlags = @ptrCast(*GConnectFlags, &zero);
    // could not get `g_signal_connect` to work. Zig says "use of undeclared identifier"
    _ = g_signal_connect_data(app, c"activate", @ptrCast(GCallback, activate), null, null, flags.*);

    const status: i32 = g_application_run(@ptrCast(*GApplication, app), 0, null);

    return @intCast(u8, status);
}
