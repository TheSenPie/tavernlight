varying mediump vec2 v_TexCoord;
uniform lowp vec4 u_Color;
uniform sampler2D u_Tex0;
uniform lowp float u_Opacity;

lowp vec4 calculatePixel() {
    return texture2D(u_Tex0, v_TexCoord) * u_Color;
}

void main()
{
    gl_FragColor = calculatePixel();
    gl_FragColor.a *= u_Opacity;
};
