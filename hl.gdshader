shader_type canvas_item;

uniform float brightness : hint_range(-1.0, 1.0);
uniform float c : hint_range(-1.0, 1.0);
uniform float y : hint_range(-1.0, 1.0);
uniform float m : hint_range(-1.0, 1.0);

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color.rgb += vec3(brightness);
	color.r -= c;
	color.g -= m;
	color.b -= y;
    COLOR = color;
}
