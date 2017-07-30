#| Object-oriented GLFW window interface
unit class GLFW::Window is repr('CPointer');

#| Creates a new window.  For fullscreen windows, pass a GLFW::Monitor
#| in $monitor.  To share resources with another window, pass another
#| GLFW::Window in $window.
method new($width, $height, $title, $monitor, $window) {
    GLFW::create-window($width, $height, $title, $monitor, $window);
}

# FIXME: is this right?  Perl 6 docs seem to be limited to
# constructors, with no mention of destructors.  I'm going by RFC
# 189 for lack of a better resource.
submethod DESTROY {
    GLFW::destroy-window(self);
}

#| Sets or gets whether the window should close (e.g. when the user
#| clicks the window's "close" button or equivalent).  Note that
#| actually setting this appears to be broken (it'll crash MoarVM), so
#| for now, setting this should be done through
#| GLFW::set-window-should-close.
method should-close() is rw {
    return Proxy.new(
        FETCH => sub ($) {
            GLFW::window-should-close(self);
        },
        STORE => sub ($, $value) {
            # TODO: figure out why this causes MoarVM to panic
            GLFW::set-window-should-close(self, $value);
        });
}

method title() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, $value) {
            GLFW::set-window-title(self, $value);
        });
}

#| Set the window's title.
method icon() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, $value) {
            GLFW::set-window-icon(self, $value);
        });
}

#| Get or set the window's position in screen units.  Accepts/returns
#| a list containing the X and Y coordinates.
method position() is rw {
    return Proxy.new(
        FETCH => sub ($) { GLFW::get-window-position(self); },
        STORE => sub ($, $pos) {
            my (int32 $x, int32 $y) = $pos;
            GLFW::set-window-position(self, $x, $y);
        });
}

#| Get or set the window's size in screen units.  Accepts/returns a
#| list containing the width and height.
method size() is rw {
    return Proxy.new(
        FETCH => sub ($) { GLFW::get-window-size(self); },
        STORE => sub ($, $size) {
            my (int32 $width, int32 $height) = $size;
            GLFW::set-window-height(self, $width, $height);
        });
}

# TODO: figure out a way to split this into min-size/max-size
# methods.  Not clear if it's possible to define fields for
# CPointer-based classes (if it is, then it also solves the
# problem of working around the lack of getters in the GLFW API).

#| Set the window's minimum/maximum sizes in screen units.  Accepts a
#| list containing the minimum and maximum sizes, each of which in
#| turn being a width/height list.
method size-limits() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, $limits) {
            my ($min, $max) = $limits;
            my ($min-w, $min-h) = $min;
            my ($max-w, $max-h) = $max;

            GLFW::set-window-size-limits(self,
                                         $min-w, $min-h,
                                         $max-w, $max-h);
        });
}

#| Set the window's aspect ratio.
method aspect-ratio() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, $ratio) {
            my (in32 $numerator, int32 $denominator) = $ratio;
            GLFW::set-window-aspect-ratio(self,
                                          $numerator,
                                          $denominator);
        });
}

#| Get or set the window's monitor (read: make the window fullscreen
#| on the given monitor).  Accepts a list with the monitor and
#| parameters, the latter of which is in turn a list with the position
#| (a list of coordinates in screen units), size/resolution (a list of
#| dimensions in screen units), and refresh rate (in Hz).
method monitor() is rw {
    return Proxy.new(
        FETCH => sub ($) { GLFW::get-window-monitor(self); },
        STORE => sub ($, $params) {
            my (GLFW::Monitor $m, $params) = $params;
            my ($pos, $size, int32 $r) = $params;
            my (int32 $x, int32 $y) = $pos;
            my (int32 $w, int32 $h) = $size;

            GLFW::set-window-monitor(self, $m, $x, $y, $w, $h, $r);
        });
}

#| Returns the value of the specified attribute.
method attribute($a) { GLFW::get-window-attribute(self, $a); }

#| Gets or sets the window's "user pointer".
method user-pointer() is rw {
    return Proxy.new(
        FETCH => sub ($) { GLFW::get-window-user-pointer(self); },
        STORE => sub ($, $pointer) {
            GLFW::set-window-user-pointer(self, $pointer);
        });
}

#| Gets the size of the window's framebuffer in pixels (*not* screen
#| units).
method framebuffer-size() {
    my (int32 $width, int32 $height);
    GLFW::get-framebuffer-size(self, $width, $height);
    return $width, $height
}

#| Gets the size of each edge of the window frame in screen units.
method frame-size() {
    my (int32 $left, int32 $top, int32 $right, int32 $bottom);
    GLFW::get-window-frame-size(self, $left, $top, $right, $bottom);
    return $left, $top, $right, $bottom;
}

#| Iconifies the window
method iconify() { GLFW::iconify-window(self); }

#| Restores the window
method restore() { GLFW::restore-window(self); }

#| Maximizes the window
method maximize() { GLFW::maximize-window(self); }

#| Shows the window
method show() { GLFW::show-window(self); }

#| Hides the window
method hide() { GLFW::hide-window(self); }

# FIXME: this probably doesn't work the way I'd like it to work
#| Gets/sets the window's input mode
method input-mode($mode) is rw {
    return Proxy.new(
        FETCH => sub ($) { GLFW::get-input-mode(self, $mode); },
        STORE => sub ($, $value) {
            GLFW::set-input-mode(self, $mode, $value);
        });
}

#| Gets the state of the specified key
method key($key) { GLFW::get-key(self, $key); }

#| Gets the state of the specified mouse button
method mouse-button($button) { GLFW::get-mouse-button(self, $button); }

#| Gets/sets the mouse cursor position
method cursor-position() is rw {
    return Proxy.new(
        FETCH => sub ($) {
            my (num64 $x, num64 $y);
            GLFW::get-cursor-position(self, $x, $y);
            return $x, $y;
        },
        STORE => sub ($, $pos) {
            my (num64 $x, num64 $y) = $pos;
            GLFW::set-cursor-position(self, $x, $y);
        });
}

#| Gets/sets the clipboard contents
method clipboard() is rw {
    return Proxy.new(
        FETCH => sub ($) { GLFW::get-clipboard-string(self); },
        STORE => sub ($, $content) {
            GLFW::set-clipboard-string(self, $content);
        });
}

#| Sets the window's context as the current context for OpenGL
#| rendering
method make-context-current() {
    GLFW::make-context-current(self);
}

#| Swaps the window's buffers, causing the result of rendering
#| operations to be displayed in the window.
method swap-buffers() {
    GLFW::swap-buffers(self);
}

#| Sets a callback to be run whenever the window is moved.  The
#| callback subroutine should accept a window, an X coordinate, and a
#| Y coordinate.
method position-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-window-position-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever the window is resized.  The
#| callback subroutine should accept a window, a width, and a height.
method size-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-window-size-callback(self, &callback);
        });
}

#| Sets a callback to be run when the window is closed.  The callback
#| subroutine should accept a window.
method close-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-window-close-callback(self, &callback);
        });
}

#| Sets a callback to be run when the window's content is refreshed.
#| The callback subroutine should accept a window.
method refresh-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-window-refresh-callback(self &callback);
        });
}

#| Sets a callback to be run when the window is iconified.  The
#| callback subroutine should accept a window.
method iconify-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-window-iconify-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever the window's framebuffer is
#| resized.  The callback subroutine should accept a window, a width,
#| and a height.
method framebuffer-size-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-framebuffer-size-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever a key is pressed while the window
#| is focused.  The callback subroutine should accept a window, a GLFW
#| keycode, a system-specific scancode, an action
#| (press/release/repeat), and a modifier key bitmask.
method key-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-key-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever the window receives a character.
#| The callback subroutine should accept a window and a Unicode code
#| point.
method char-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-char-callback(self, &callback);
        });
}

#| Equivalent to $window.char-callback, but with the addition of a
#| bitmask representing the active modifier keys.
method char-mods-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-char-mods-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever the mouse cursor moves within
#| the window.  The callback subroutine should accept a window, the
#| new X coordinate, and the new Y coordinate.
method cursor-position-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-cursor-position-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever the mouse cursor enters or
#| leaves the window.  The callback should accept a window and an
#| integer pretending to be a boolean.
method cursor-enter-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-cursor-enter-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever the window is scrolled
#| (e.g. with the mouse scrollwheel).  The callback should accept a
#| window, a horizontal offset, and a vertical offset.
method scroll-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-scroll-callback(self, &callback);
        });
}

#| Sets a callback to be run whenever one or more files are dragged
#| and dropped onto the window.  The callback subroutine should accept
#| a window, the number of files, and a CArray of strings representing
#| the filenames/paths.  Note that since this is a CArray, you'll
#| probably want to convert it to a Perl array first (e.g. with
#| '@perlarray[$_] = $paths[$_] for ^$count;').
method drop-callback() is rw {
    return Proxy.new(
        FETCH => sub ($) {},  # FIXME: no GLFW equivalent
        STORE => sub ($, &callback) {
            GLFW::set-drop-callback(self, &callback);
        });
}
