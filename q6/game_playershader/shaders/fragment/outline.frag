#define SCREEN_PIXEL_SIZE vec2(1.0/1920.0, 1.0/1080.0)

varying mediump vec2 v_TexCoord;
uniform lowp vec4 u_Color;
uniform sampler2D u_Tex0;
uniform lowp float u_Opacity;

lowp vec4 calculatePixel() {
    return texture2D(u_Tex0, v_TexCoord) * u_Color;
}

void main()
{
    vec4 line_color = vec4(1.0, 0.0, 0.0, 1.0);
    float line_thickness = 0.6;

    vec2 uv = v_TexCoord;
    vec2 size = (SCREEN_PIXEL_SIZE * line_thickness);

    float outline = texture2D(u_Tex0, uv + vec2(-size.x, 0)).a;
    outline += texture2D(u_Tex0, uv + vec2(0, size.y)).a;
    outline += texture2D(u_Tex0, uv + vec2(size.x, 0)).a;
    outline += texture2D(u_Tex0, uv + vec2(0, -size.y)).a;
    outline += texture2D(u_Tex0, uv + vec2(-size.x * 0.866, size.y * 0.5)).a;
    outline += texture2D(u_Tex0, uv + vec2(-size.x * 0.5, size.y * 0.866)).a;
    outline += texture2D(u_Tex0, uv + vec2(size.x * 0.866, size.y * 0.5)).a;
    outline += texture2D(u_Tex0, uv + vec2(size.x * 0.5, size.y * 0.866)).a;
    outline += texture2D(u_Tex0, uv + vec2(-size.x * 0.866, -size.y * 0.5)).a;
    outline += texture2D(u_Tex0, uv + vec2(-size.x * 0.5, -size.y * 0.866)).a;
    outline += texture2D(u_Tex0, uv + vec2(size.x * 0.866, -size.y * 0.5)).a;
    outline += texture2D(u_Tex0, uv + vec2(size.x * 0.5, -size.y * 0.866)).a;
    outline = min(outline, 1.0);

    vec4 original_color = calculatePixel();
    gl_FragColor = mix(original_color, line_color, outline - original_color.a);
    gl_FragColor.a *= u_Opacity;
};
