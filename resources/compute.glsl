#version 450
#pragma shader_stage(compute)

layout (binding = 0, rgba8) uniform image2D Result;

void main() {
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    vec4 color = imageLoad(Result, coord);
    float gray = color.r * 0.2126 + color.g * 0.7152 + color.r * 0.0722;
    color.rgb = color.rgb * 0.45 + gray * 0.55;
    imageStore(Result, coord, color);
}
