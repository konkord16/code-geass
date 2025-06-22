shader_type canvas_item;

uniform vec2 resolution = vec2(800.0, 800.0);
uniform vec3 line_color: source_color = vec3(0.2, 0.3, 0.5);
uniform vec3 cell_color: source_color = vec3(0.0);
uniform float zoom: hint_range(1.0, 50.0, 0.1) = 20.0;
uniform float thickness: hint_range(0.1, 10.0, 0.1) = 2.0;
uniform float brightness: hint_range(0.1, 4.0, 0.1) = 2.0;
uniform float opacity: hint_range(0.0, 1.0, 0.05) = 0.5;

float draw_grid(vec2 uv) {
	vec2 grid_uv = cos(uv * TAU);
	return max(grid_uv.x, grid_uv.y);
}

void fragment() {
	vec2 uv = UV;
	uv.x *= resolution.x / resolution.y;
	float line_thickness = zoom * thickness / resolution.y;
	float mix_value = smoothstep(1.0 - line_thickness, 1.0, draw_grid(uv * zoom));
	vec3 color = mix(cell_color, line_color, mix_value) * line_color;
	if (color.r + color.g + color.b < 0.3){
		color = cell_color;
	}
	COLOR = vec4(color * brightness, opacity);

}
