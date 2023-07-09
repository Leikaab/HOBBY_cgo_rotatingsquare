#include "square_renderer.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <objc/message.h>
#include <objc/runtime.h>
#include <CoreFoundation/CoreFoundation.h>
#include <objc/objc.h>
#include <CoreGraphics/CoreGraphics.h>

static id create_metal_window();
static void setup_renderer(id metalWindow);

void draw_square()
{
    printf("Drawing square...\n");
    // Call the Metal rendering function to draw the square
    void *metalRendererClass = objc_getClass("MetalRenderer");
    SEL drawSquareSelector = sel_registerName("drawSquare");
    ((void (*)(void *, SEL))objc_msgSend)(metalRendererClass, drawSquareSelector);

    id metalWindow = create_metal_window();
    setup_renderer(metalWindow);

    run_event_loop();
}

void rotate_square()
{
    printf("Rotating square...\n");
    // Call the Metal rendering function to rotate the square
    void *metalRendererClass = objc_getClass("MetalRenderer");
    SEL rotateSquareSelector = sel_registerName("rotateSquare");
    ((void (*)(void *, SEL))objc_msgSend)(metalRendererClass, rotateSquareSelector);
    sleep(1); // 1-second delay
}

void run_event_loop()
{
    Class appDelegateClass = objc_getClass("AppDelegate");
    SEL appDelegateSelector = sel_registerName("sharedInstance");
    id appDelegate = ((id(*)(id, SEL))objc_msgSend)(appDelegateClass, appDelegateSelector);

    SEL runSelector = sel_registerName("runEventLoop");
    ((void (*)(id, SEL))objc_msgSend)(appDelegate, runSelector);
}

static id create_metal_window()
{
    Class NSAutoreleasePoolClass = objc_getClass("NSAutoreleasePool");
    id NSAutoreleasePoolInstance = ((id(*)(id, SEL))objc_msgSend)(NSAutoreleasePoolClass, sel_registerName("alloc"));
    NSAutoreleasePoolInstance = ((id(*)(id, SEL))objc_msgSend)(NSAutoreleasePoolInstance, sel_registerName("init"));

    Class NSApplicationClass = objc_getClass("NSApplication");
    id sharedApplication = ((id(*)(id, SEL))objc_msgSend)(NSApplicationClass, sel_registerName("sharedApplication"));

    Class NSWindowClass = objc_getClass("NSWindow");
    id window = ((id(*)(id, SEL, CGRect, unsigned long, unsigned long, BOOL))objc_msgSend)(NSWindowClass, sel_registerName("initWithContentRect:styleMask:backing:defer:"), CGRectMake(0, 0, 800, 600), 15, 2, NO);
    window = ((id(*)(id, SEL, CGRect, unsigned long, unsigned long, BOOL))objc_msgSend)(window, sel_registerName("initWithContentRect:styleMask:backing:defer:"), CGRectMake(0, 0, 800, 600), 15, 2, NO);
    ((void (*)(id, SEL, BOOL))objc_msgSend)(window, sel_registerName("setReleasedWhenClosed:"), NO);
    ((void (*)(id, SEL, BOOL))objc_msgSend)(window, sel_registerName("makeKeyAndOrderFront:"), window);

    id appDelegate = ((id(*)(id, SEL))objc_msgSend)(objc_getClass("AppDelegate"), sel_registerName("sharedInstance"));

    id metalWindow = ((id(*)(id, SEL, id))objc_msgSend)(appDelegate, sel_registerName("createMetalWindow:"), window);

    return metalWindow;
}

static void setup_renderer(id metalWindow)
{
    id appDelegate = ((id(*)(id, SEL))objc_msgSend)(objc_getClass("AppDelegate"), sel_registerName("sharedInstance"));
    ((void (*)(id, SEL, id))objc_msgSend)(appDelegate, sel_registerName("setupRenderer:"), metalWindow);
}