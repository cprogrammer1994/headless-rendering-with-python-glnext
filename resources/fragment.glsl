#version 450
#pragma shader_stage(fragment)

layout (binding = 0) uniform Buffer {
    mat4 mvp;
    vec3 light;
};

layout (binding = 1) uniform sampler2D Texture;

layout (location = 0) in vec3 in_vert;
layout (location = 1) in vec3 in_norm;
layout (location = 2) in vec3 in_text;

layout (location = 0) out vec4 out_color;

void main() {
    float lum = dot(normalize(in_norm), normalize(in_vert - light));
    lum = acos(lum) / 3.14159265;
    lum = clamp(lum, 0.0, 1.0);
    lum = lum * lum;
    lum = smoothstep(0.0, 1.0, lum);
    lum *= smoothstep(0.0, 80.0, in_vert.z) * 0.3 + 0.7;
    lum = lum * 0.8 + 0.2;

    vec3 color = texture(Texture, in_text.xy).rgb;
    out_color = vec4(color * lum, 1.0);
}
