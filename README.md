# ZIG GTK

> [!IMPORTANT]  
> Works with zig version 0.13.0 and may not work in older versions.

## Main branch

Sample "hello world" GTK4 applications in [zig](https://ziglang.org/). Based on the examples at [GTK4 Getting Started](https://docs.gtk.org/gtk4/getting_started.html)

There are three applications:

1. manual: uses the in-code method of defining the UI
1. builder: uses the 'window.ui' file to define the UI.
1. embedded: uses the 'window.ui' file to define the UI, but embeds the text into the application at compile time,

## GTK3 branch

Same examples as above but with [GTK3](https://developer.gnome.org/gtk3/stable/gtk-getting-started.html)


## Build

Ensure gtk4 is installed as system dependency.

    zig build

## Run

    zig build manual
    zig build builder
    zig build embedded
