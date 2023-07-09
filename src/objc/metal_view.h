#import <MetalKit/MetalKit.h>

@interface MetalView : MTKView

@property(nonatomic, strong) id<MTLDevice> device; // Change 'nonatomic' to 'strong'
@property(nonatomic, strong) id<MTLCommandQueue> commandQueue;
@property(nonatomic, strong) id<MTLRenderPipelineState> pipelineState;
@property(nonatomic, strong) id<MTLBuffer> vertexBuffer;
// Add any additional properties as needed

@end