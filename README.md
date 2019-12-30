# ZIG GTK+

Sample "hello world" GTK+ applications in [zig](https://ziglang.org/). Based on the examples at [GTK+ Getting Started](https://developer.gnome.org/gtk3/stable/gtk-getting-started.html)

There are two applications:

1. manual
1. builder

The manual application uses the in-code method of defining the UI. The builder application uses the 'builder.ui' file to define the UI.

## Build

Built with zig v0.5.0 on Ubuntu 18.04

    zig build

## Run

    zig build manual
    zig build builder
