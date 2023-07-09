// -*- objc -*-

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

@interface MetalRenderer : NSObject

- (instancetype)initWithMetalDevice:(id<MTLDevice>)device;
- (void)drawSquare;
- (void)rotateSquare;

@end
