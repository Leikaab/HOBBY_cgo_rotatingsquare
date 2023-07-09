// Shaders.metal

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float2 position;
};

vertex float4 vertexShader(Vertex vertex [[stage_in]]) {
    float4 position;
    position.xy = vertex.position;
    position.zw = float2(0.0, 1.0);
    return position;
}

fragment float4 fragmentShader() {
    return float4(1.0, 1.0, 0.0, 1.0);
}