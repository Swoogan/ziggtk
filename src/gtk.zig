pub usingnamespace @cImport({
    @cInclude("gtk/gtk.h");
});

pub fn print_hello(widget: *GtkWidget, data: gpointer) void {
    g_print ("Hello World\n");
}

/// Could not get `g_signal_connect` to work. Zig says "use of undeclared identifier". Reimplemented here
pub fn g_signal_connect(instance: gpointer, detailed_signal: [*c]const gchar, c_handler: GCallback, data: gpointer) gulong {
    var zero: u32 = 0;
    const flags: *GConnectFlags = @ptrCast(*GConnectFlags, &zero);
    return g_signal_connect_data(instance, detailed_signal, c_handler, null, null, flags.*);
}

/// Could not get `g_signal_connect_swapped` to work. Zig says "use of undeclared identifier". Reimplemented here
pub fn g_signal_connect_swapped(instance: gpointer, detailed_signal: [*c]const gchar, c_handler: GCallback, data: gpointer) gulong {
    return g_signal_connect_data(instance, detailed_signal, c_handler, data, null, .G_CONNECT_SWAPPED);
}
