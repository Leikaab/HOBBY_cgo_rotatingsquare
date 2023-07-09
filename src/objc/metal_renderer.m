#import "metal_renderer.h"
#import <MetalKit/MetalKit.h>

// Define the vertex structure for the square
typedef struct {
    vector_float2 position;
} Vertex;

@interface MetalRenderer ()

@property (nonatomic, strong) id<MTLDevice> device;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;
@property (nonatomic, strong) id<MTLRenderPipelineState> pipelineState;
@property (nonatomic, strong) id<MTLBuffer> vertexBuffer;
// Add any additional properties as needed

@end

@implementation MetalRenderer

- (instancetype)initWithMetalDevice:(id<MTLDevice>)device {
    self = [super init];
    if (self) {
        _device = device;
        _commandQueue = [device newCommandQueue];
        [self setupPipelineState];
        [self setupVertexBuffer];
        // Perform any additional initialization steps if required
    }
    return self;
}

- (void)setupPipelineState {
    id<MTLLibrary> library = [self.device newLibraryWithSource:[self shaderSource] options:nil error:nil];
    id<MTLFunction> vertexFunction = [library newFunctionWithName:@"vertexShader"];
    id<MTLFunction> fragmentFunction = [library newFunctionWithName:@"fragmentShader"];
   
    
    MTLRenderPipelineDescriptor *pipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    pipelineDescriptor.vertexFunction = vertexFunction;
    pipelineDescriptor.fragmentFunction = fragmentFunction;
    pipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    NSError *error = nil;
    self.pipelineState = [self.device newRenderPipelineStateWithDescriptor:pipelineDescriptor error:&error];
    if (!self.pipelineState) {
        NSLog(@"Failed to create render pipeline state: %@", error);
    }
}

- (NSString *)shaderSource {
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Shaders" ofType:@"metal"];
    NSString *source = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"Error reading shader source file: %@", error);
    }
    
    return source;
}

- (void)setupVertexBuffer {
    static const Vertex vertices[] = {
        { .position = { -0.5, -0.5 } },
        { .position = { 0.5, -0.5 } },
        { .position = { -0.5, 0.5 } },
        { .position = { 0.5, 0.5 } }
    };
    
    self.vertexBuffer = [self.device newBufferWithBytes:vertices length:sizeof(vertices) options:MTLResourceStorageModeShared];
}

- (void)drawSquare {
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:[self currentRenderPassDescriptor]];
    
    [renderEncoder setRenderPipelineState:self.pipelineState];
    [renderEncoder setVertexBuffer:self.vertexBuffer offset:0 atIndex:0];
    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:4];
    
    [renderEncoder endEncoding];
    [commandBuffer presentDrawable:nil];
    [commandBuffer commit];
}

- (MTLRenderPassDescriptor *)currentRenderPassDescriptor {
    MTLRenderPassDescriptor *renderPassDescriptor = [[MTLRenderPassDescriptor alloc] init];
    renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0);
    // Set up other properties of the render pass descriptor as needed
    
    // Get the current drawable size
    CGSize drawableSize = CGSizeZero; // Replace with the actual drawable size
    renderPassDescriptor.colorAttachments[0].texture = [self createDrawableTextureWithSize:drawableSize];
    
    return renderPassDescriptor;
}

- (id<MTLTexture>)createDrawableTextureWithSize:(CGSize)size {
    MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm width:size.width height:size.height mipmapped:NO];
    textureDescriptor.usage = MTLTextureUsageRenderTarget | MTLTextureUsageShaderRead;
    id<MTLTexture> texture = [self.device newTextureWithDescriptor:textureDescriptor];
    
    return texture;
}

@end
