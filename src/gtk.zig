pub usingnamespace @cImport({
    @cInclude("gtk/gtk.h");
});

const c = @cImport({
    @cInclude("gtk/gtk.h");
});

pub fn print_hello(_: *c.GtkWidget, _: c.gpointer) void {
    c.g_print("Hello World\n");
}

// _g_signal_connect generated code passes NULL(c type) aka ?*anyopaque(zig type) as destroy_data(5th arg) and this causes type check to fail because of (destory_data: GClosureNotify)
pub fn _g_signal_connect(instance: c.gpointer, detailed_signal: [*c]const c.gchar, c_handler: c.GCallback, data: c.gpointer) c.gulong {
    var zero: u32 = 0;
    const flags: *c.GConnectFlags = @ptrCast(&zero);
    return c.g_signal_connect_data(instance, detailed_signal, c_handler, data, null, flags.*);
}

// _g_signal_connect_swapped generated code passes NULL(c type) aka ?*anyopaque as destroy_data(5th arg) and this causes type check to fail because of (destory_data: GClosureNotify)
pub fn _g_signal_connect_swapped(instance: c.gpointer, detailed_signal: [*c]const c.gchar, c_handler: c.GCallback, data: c.gpointer) c.gulong {
    return c.g_signal_connect_data(instance, detailed_signal, c_handler, data, null, c.G_CONNECT_SWAPPED);
}
