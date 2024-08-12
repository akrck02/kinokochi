shader_type canvas_item;

void fragment() {
	vec4 current = texture(TEXTURE,UV);
	ivec2 pixel_pos = ivec2(UV / TEXTURE_PIXEL_SIZE);
	
	float pos_x = float(pixel_pos.x);
	float pos_y = float(pixel_pos.y);
	
	float r = current.r; // + 0.2;
	float g = current.g; // + 0.05;
	float b = current.b; // + 0.05;
	
	COLOR = vec4(r ,g, b, current.a);
  
}
