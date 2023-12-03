shader_type canvas_item;

uniform float brightness : hint_range(-1.0, 1.0) = 0.0; // Adjust brightness (-1.0 to 1.0)

void fragment() {
    // Fetch the original color
    vec4 color = texture(TEXTURE, SCREEN_UV);

    // Apply brightness adjustment
    color.rgb += brightness;

    // Make sure color values are within the valid range (0.0 - 1.0)
    color.rgb = clamp(color.rgb, 0.0, 1.0);

    // Output the final color
    COLOR = color;
}
