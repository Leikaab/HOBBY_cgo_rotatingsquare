#include "../c/square_renderer.h"
#import "metal_renderer.h"

void draw_square() {
    NSLog(@"Drawing square...");
    MetalRenderer *renderer = [[MetalRenderer alloc] initWithMetalDevice:MTLCreateSystemDefaultDevice()];
    [renderer drawSquare];
}

void rotate_square() {
    NSLog(@"Rotating square...");
    MetalRenderer *renderer = [[MetalRenderer alloc] initWithMetalDevice:MTLCreateSystemDefaultDevice()];
    [renderer rotateSquare];
}
