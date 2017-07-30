unit module GLFW;

use NativeCall;

########################################################################
# Native C API                                                         #
########################################################################

our sub init(
) returns int32 is native('glfw') is symbol('glfwInit') {*}

our sub terminate(
) is native('glfw') is symbol('glfwTerminate') {*}

our sub get-version(
    int32 $major is rw,
    int32 $minor is rw,
    int32 $rev is rw
) is native('glfw') is symbol('glfwGetVersion') {*}

our sub get-version-string(
) returns Str is native('glfw') is symbol('glfwGetVersionString') {*}

our sub set-error-callback(
    &callback (int32, Str)
) is native('glfw') is symbol('glfwSetErrorCallback') {*}

our sub get-monitors(
    int32 $count is rw
) returns CArray[Monitor] is native('glfw') is symbol('glfwGetMonitors') {*}

our sub get-primary-monitor(
    --> Monitor
) is native('glfw') is symbol('glfwGetPrimaryMonitor') {*}

our sub get-monitor-pos(
    Monitor $monitor,
    int32 $xpos is rw,
    int32 $ypos is rw
) is native('glfw') is symbol('glfwGetMonitorPos') {*}

our sub get-monitor-physical-size(
    Monitor $monitor,
    int32 $width-mm is rw,
    int32 $height-mm is rw
) is native('glfw') is symbol('glfwGetMonitorPhysicalSize') {*}

our sub get-monitor-name(
    Monitor $monitor
) returns Str is native('glfw') is symbol('glfwGetMonitorName') {*}

our sub set-monitor-callback(
    &callback (Monitor, int32)
) is native('glfw') is symbol('glfwSetMonitorCallback') {*}

our sub get-video-modes(
    Monitor $monitor,
    int32 $count is rw
) returns CArray[VidMode] is native('glfw') is symbol('glfwGetVideoModes') {*}

our sub get-video-mode(
    Monitor $monitor
) returns VidMode is native('glfw') is symbol('glfwGetVideoMode'){*}

our sub set-gamma(
    Monitor $monitor,
    num32 $gamma
) is native('glfw') is symbol('glfwSetGamma') {*}

our sub get-gamma-ramp(
    Monitor $monitor
) returns GammaRamp is native('glfw') is symbol('glfwGetGammaRamp') {*}

our sub set-gamma-ramp(
    Monitor $monitor,
    GammaRamp $ramp
) is native('glfw') is symbol('glfwSetGammaRamp') {*}

our sub default-window-hints(
) is native('glfw') is symbol('glfwDefaultWindowHints') {*}

our sub window-hint(
    int32 $hint,
    int32 $value
) is native('glfw') is symbol('glfwWindowHint') {*}

our sub create-window(
    int32 $width,
    int32 $height,
    Str $title,
    Monitor $monitor,
    Window $share
) returns Window is native('glfw') is symbol('glfwCreateWindow') {*}

our sub destroy-window(
    Window $window
) is native('glfw') is symbol('glfwCreateWindow') {*}

our sub window-should-close(
    Window $window
) returns int32(Bool) is native('glfw') is symbol('glfwWindowShouldClose') {*}

our sub set-window-should-close(
    Window $window,
    int32(Bool) $value
) is native('glfw') is symbol('glfwSetWindowShouldClose') {*}

our sub set-window-title(
    Window $window,
    Str $title
) is native('glfw') is symbol('glfwSetWindowTitle') {*}

our sub set-window-icon(
    Window $window,
    int32 $count,
    CArray[Image] $images
) is native('glfw') is symbol('glfwSetWindowIcon') {*}

our sub get-window-position(
    Window $window,
    int32 $xpos is rw,
    int32 $ypos is rw
) is native('glfw') is symbol('glfwGetWindowPos') {*}

our sub set-window-position(
    Window $window,
    int32 $xpos,
    int32 $ypos
) is native('glfw') is symbol('glfwSetWindowPos') {*}

our sub get-window-size(
    Window $window,
    int32 $width is rw,
    int32 $height is rw
) is native('glfw') is symbol('glfwGetWindowSize') {*}

our sub set-window-size-limits(
    Window $window,
    int32 $min-width,
    int32 $min-height,
    int32 $max-width,
    int32 $max-height
) is native('glfw') is symbol('glfwSetWindowSizeLimits') {*}

our sub set-window-aspect-ratio(
    Window $window,
    int32 $numerator,
    int32 $denominator
) is native('glfw') is symbol('glfwSetWindowAspectRatio') {*}

our sub set-window-size(
    Window $window,
    int32 $width,
    int32 $height
) is native('glfw') is symbol('glfwSetWindowSize') {*}

our sub get-framebuffer-size(
    Window $window,
    int32 $width is rw,
    int32 $height is rw
) is native('glfw') is symbol('glfwGetFramebufferSize') {*}

our sub get-window-frame-size(
    Window $window,
    int32 $left is rw,
    int32 $top is rw,
    int32 $right is rw,
    int32 $bottom is rw
) is native('glfw') is symbol('glfwGetWindowFrameSize') {*}

our sub iconify-window(
    Window $window
) is native('glfw') is symbol('glfwIconifyWindow') {*}

our sub restore-window(
    Window $window
) is native('glfw') is symbol('glfwRestoreWindow') {*}

our sub maximize-window(
    Window $window
) is native('glfw') is symbol('glfwMaximizeWindow') {*}

our sub show-window(
    Window $window
) is native('glfw') is symbol('glfwShowWindow') {*}

our sub hide-window(
    Window $window
) is native('glfw') is symbol('glfwHideWindow') {*}

our sub focus-window(
    Window $window
) is native('glfw') is symbol('glfwFocusWindow') {*}

our sub get-window-monitor(
    Window $window
) returns Monitor is native('glfw') is symbol('glfwGetWindowMonitor') {*}

our sub set-window-monitor(
    Window $window,
    Monitor $monitor,
    int32 $xpos,
    int32 $ypos,
    int32 $width,
    int32 $height,
    int32 $refresh-rate
) is native('glfw') is symbol('glfwSetWindowMonitor') {*}

our sub get-window-attribute(
    Window $window,
    int32 $attrib
) returns int32 is native('glfw') is symbol('glfwGetWindowAttrib') {*}

our sub set-window-user-pointer(
    Window $window,
    Pointer $pointer
) is native('glfw') is symbol('glfwSetWindowUserPointer') {*}

our sub get-window-user-pointer(
    Window $window
) returns Pointer is native('glfw') is symbol('glfwGetWindowUserPointer') {*}

our sub set-window-position-callback(
    Window $window,
    &callback (Window, int32, int32)
) is native('glfw') is symbol('glfwSetWindowPosCallback') {*}

our sub set-window-size-callback(
    Window $window,
    &callback (Window, int32, int32)
) is native('glfw') is symbol('glfwSetWindowSizeCallback') {*}

our sub set-window-close-callback(
    Window $window,
    &callback (Window)
) is native('glfw') is symbol('glfwSetWindowCloseCallback') {*}

our sub set-window-refresh-callback(
    Window $window,
    &callback (Window)
) is native('glfw') is symbol('glfwSetWindowRefreshCallback') {*}

our sub set-window-iconify-callback(
    Window $window,
    &callback (Window, int32)
) is native('glfw') is symbol('glfwSetWindowIconifyCallback') {*}

our sub set-framebuffer-size-callback(
    Window $window,
    &callback (Window, int32, int32)
) is native('glfw') is symbol('glfwSetFramebufferSizeCallback') {*}

our sub poll-events(
) is native('glfw') is symbol('glfwPollEvents') {*}

our sub wait-events(
) is native('glfw') is symbol('glfwWaitEvents') {*}

our sub wait-events-timeout(
    num64 $timeout
) is native('glfw') is symbol('glfwWaitEventsTimeout') {*}

our sub post-empty-event(
) is native('glfw') is symbol('glfwPostEmptyEvent') {*}

our sub get-input-mode(
    Window $window,
    int32 $mode
) returns int32 is native('glfw') is symbol('glfwGetInputMode') {*}

our sub set-input-mode(
    Window $window,
    int32 $mode,
    int32 $value
) is native('glfw') is symbol('glfwSetInputMode') {*}

our sub get-key-name(
    int32 $key,
    int32 $scancode
) returns Str is native('glfw') is symbol('glfwGetKeyName') {*}

our sub get-key(
    Window $window,
    int32 $key
) returns int32 is native('glfw') is symbol('glfwGetKey') {*}

our sub get-mouse-button(
    Window $window,
    int32 $button
) returns int32 is native('glfw') is symbol('glfwGetMouseButton') {*}

our sub get-cursor-position(
    Window $window,
    num64 $xpos is rw,
    num64 $ypos is rw
) is native('glfw') is symobl('glfwGetCursorPos') {*}

our sub set-cursor-position(
    Window $window,
    num64 $xpos,
    num64 $ypos
) is native('glfw') is symbol('glfwSetCursorPos') {*}

our sub create-cursor(
    Image $image,
    int32 $xhot,
    int32 $yhot
) returns Cursor is native('glfw') is symbol('glfwCreateCursor') {*}

our sub create-standard-cursor(
    int32 $shape
) returns Cursor is native('glfw') is symbol('glfwCreateStandardCursor') {*}

our sub destroy-cursor(
    Cursor $cursor
) is native('glfw') is symbol('glfwDestroyCursor') {*}

our sub set-key-callback(
    Window $window,
    &callback (Window, int32, int32, int32, int32)
) is native('glfw') is symbol('glfwSetKeyCallback') {*}

our sub set-char-callback(
    Window $window,
    &callback (Window, uint32)
) is native('glfw') is symbol('glfwSetCharCallback') {*}

our sub set-char-mods-callback(
    Window $window,
    &callback (Window, uint32, int32)
) is native('glfw') is symbol('glfwSetCharModsCallback') {*}

our sub set-mouse-button-callback(
    Window $window,
    &callback (Window, int32, int32, int32)
) is native('glfw') is symbol('glfwSetMouseButtonCallback') {*}

our sub set-cursor-position-callback(
    Window $window,
    &callback (Window, num64, num64)
) is native('glfw') is symbol('glfwSetCursorPosCallback') {*}

our sub set-cursor-enter-callback(
    Window $window,
    &callback (Window, int32)  # FIXME: should the int32 be int32(Bool)?
) is native('glfw') is symbol('glfwSetCursorEnterCallback') {*}

our sub set-scroll-callback(
    Window $window,
    &callback (Window, num64, num64)
) is native('glfw') is symbol('glfwSetScrollCallback') {*}

our sub set-drop-callback(
    Window $window,
    &callback (Window, Array[Str])
) is native('glfw') is symbol('glfwSetDropCallback') {*}

our sub joystick-present(
    int32 $joystick
) returns int32(Bool) is native('glfw') is symbol('glfwJoystickPresent') {*}

our sub get-joystick-axes(
    int32 $joystick,
    int32 $count is rw
) returns Array[num32] is native('glfw') is symbol('glfwGetJoystickAxes') {*}

our sub get-joystick-buttons(
    int32 $joystick,
    int32 $count is rw
) returns Str is native('glfw') is symbol('glfwGetJoystickButtons') {*}

our sub get-joystick-name(
    int32 $joystick
) returns Str is native('glfw') is symbol('glfwGetJoystickName') {*}

our sub set-joystick-callback(
    &callback (int32, int32)
) is native('glfw') is symbol('glfwSetJoystickCallback') {*}

our sub set-clipboard-string(
    Window $window,
    Str $string
) is native('glfw') is symbol('glfwSetClipboardString') {*}

our sub get-clipboard-string(
    Window $window
) returns Str is native('glfw') is symbol('glfwGetClipboardString') {*}

our sub get-time(
) returns num64 is native('glfw') is symbol('glfwGetTime') {*}

our sub set-time(
    num64 $time
) is native('glfw') is symbol('glfwSetTime') {*}

our sub get-timer-value(
) returns uint64 is native('glfw') is symbol('glfwGetTimerValue') {*}

our sub get-timer-frequency(
) returns uint64 is native('glfw') is symbol('glfwGetTimerFrequency') {*}

our sub make-context-current(
    Window $window
) is native('glfw') is symbol('glfwMakeContextCurrent') {*}

our sub swap-buffers(
    Window $window
) is native('glfw') is symbol('glfwSwapBuffers'){*}

our sub swap-interval(
    int32 $interval
) is native('glfw') is symbol('glfwSwapInterval') {*}

our sub extension-supported(
    Str $extension
) is native('glfw') is symbol('glfwExtensionSupported') {*}

# FIXME: this is probably broken
our sub get-proc-address(
    Str $proc-name
) returns Pointer is native('glfw') is symbol('glfwGetProcAddress') {*}

our sub vulkan-supported(
) returns int32(Bool) is native('glfw') is symbol('glfwGetProcAddress') {*}

our sub get-required-instance-extensions(
    int32 $count is rw
) returns Array[Str] is native('glfw') is symbol('glfwGetRequiredInstanceExtensions') {*}

# TODO: get some Vulkan stuff defined.  We need a Vulkan package with
# Vulkan::Instance, Vulkan::PhysicalDevice, Vulkan::SurfaceKHR, and
# possibly Vulkan::AllocationCallbacks and Vulkan::Result classes (for
# VkInstance, VkPhysicalDevice, VkSurfaceKHR, and
# VkAllocationCallbacks, respectively)

# our sub get-instance-proc-address(
#     Vulkan::Instance $instance,
#     Str $proc-name
# ) returns Pointer is native('glfw') is symbol('glfwGetInstanceProcAddress') {*}

# our sub get-physical-device-presentation-support(
#     Vulkan::Instance $instance,
#     Vulkan::PhysicalDevice $device,
#     uint32 $queue-family
# ) returns int32(Bool) is native('glfw') is symbol('glfwGetPhysicalDevicePresentationSupport') {*}

# our sub create-window-surface(
#     Vulkan::Instance $instance,
#     Window $window,
#     Vulkan::AllocationCallbacks $allocator,
#     Vulkan::SurfaceKHR $surface
# ) returns Vulkan::Result is native('glfw') is symbol('glfwCreateWindowSurface') {*}


## OpenGL (TODO: consider moving this stuff out to a separate
## module, with or without going through GLFW)

our enum PrimitiveMode(
    GL_POINTS         => 0x0000,
    GL_LINES          => 0x0001,
    GL_LINE_LOOP      => 0x0002,
    GL_LINE_STRIP     => 0x0003,
    GL_TRIANGLES      => 0x0004,
    GL_TRIANGLE_STRIP => 0x0005,
    GL_TRIANGLE_FAN   => 0x0006,
    GL_QUADS          => 0x0007,
    GL_QUAD_STRIP     => 0x0008,
    GL_POLYGON        => 0x0009
);

our enum MatrixMode(
    GL_MATRIX_MODE => 0x0BA0,
    GL_MODELVIEW   => 0x1700,
    GL_PROJECTION  => 0x1701,
    GL_TEXTURE     => 0x1702
);

our sub gl-viewport(int32, int32, int32, int32)
is native('glfw') is symbol('glViewport') {*}

our sub gl-clear(int32)
is native('glfw') is symbol('glClear') {*}

our sub gl-matrix-mode(int32)
is native('glfw') is symbol('glMatrixMode') {*}

our sub gl-load-identity()
is native('glfw') is symbol('glLoadIdentity') {*}

our sub gl-ortho(num64, num64, num64, num64, num64, num64)
is native('glfw') is symbol('glOrtho') {*}

our sub gl-rotatef(num32, num32, num32, num32)
is native('glfw') is symbol('glRotatef') {*}

our sub gl-begin(int32)
is native('glfw') is symbol('glBegin') {*}

our sub gl-color3f(num32, num32, num32)
is native('glfw') is symbol('glColor3f') {*}

our sub gl-vertex3f(num32, num32, num32)
is native('glfw') is symbol('glVertex3f') {*}

our sub gl-end()
is native('glfw') is symbol('glEnd') {*}

our constant GL_COLOR_BUFFER_BIT = 0x00004000;
