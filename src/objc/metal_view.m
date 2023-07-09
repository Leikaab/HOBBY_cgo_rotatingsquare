#import "metal_view.h"
#import "metal_renderer.h"

@interface MetalView ()

@property (nonatomic, strong) MetalRenderer *renderer;

@end

@implementation MetalView

- (instancetype)initWithFrame:(CGRect)frameRect device:(id<MTLDevice>)device {
    self = [super initWithFrame:frameRect device:device];
    if (self) {
        self.device = device; // Use the property syntax to assign the value
        self.commandQueue = [device newCommandQueue]; // Use the property syntax
        [self setupRenderer];
    }
    return self;
}

- (void)setupRenderer {
    self.renderer = [[MetalRenderer alloc] initWithMetalDevice:self.device];
    self.delegate = self.renderer;
}

@end
