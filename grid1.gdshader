shader_type canvas_item;

uniform vec2 resolution = vec2(600.0, 400.0);
uniform vec3 line_color: source_color = vec3(0.2, 0.3, 0.5);
uniform vec3 cell_color: source_color;
uniform float zoom: hint_range(1.0, 50.0, 0.1) = 20.0;
uniform float thickness: hint_range(0.1, 10.0, 0.1) = 2.0;
uniform float brightness: hint_range(0.1, 4.0, 0.1) = 2.0;

float draw_grid(vec2 uv) {
	vec2 grid_uv = cos(uv * PI);
	return max(grid_uv.x, grid_uv.y);
}

void fragment() {
	vec2 uv = UV - 0.5;
	float line_thickness = zoom * thickness / resolution.y;
	vec3 color = smoothstep(1.0 - line_thickness, 1.0, draw_grid(uv * zoom)) * line_color;
	color = vec3(1.0, 1.0, 1.0) - color;
	COLOR = vec4(color * brightness, 1.0);
}
