#| Object-oriented interface for GLFW cursors
unit class Cursor is repr('CPointer');

need GLFW;
need GLFW::Image;

constant Arrow     = 0x00036001;
constant IBeam     = 0x00036002;
constant Crosshair = 0x00036003;
constant Hand      = 0x00036004;
constant HResize   = 0x00036005;
constant VResize   = 0x00036006;

#| Create a cursor from an image, an X coordinate, and a Y coordinate.
multi method new(GLFW::Image $image, $hotspot) {
    my (int32 $x, int32 $y) = $hotspot;
    GLFW::create-cursor($image, $x, $y);
}

#| Create a cursor from a predefined shape (as understood by GLFW).
multi method new(int32 $shape) {
    GLFW::create-standard-cursor($shape);
}

# FIXME: see comment on DESTROY submethod for Window
submethod DESTROY {
    GLFW::destroy-cursor(self);
}
