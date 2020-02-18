/*
	shader for solid objects, with diffuse aspect based on the angle to the camera and a skybox reflect
*/
#version 330

in vec3 v_position;	// vertex position
in vec3 v_normal;	// vertex normal
in int v_flags;
uniform mat4 view;	// view matrix (camera orientation)
uniform mat4 proj;	// projection matrix (perspective or orthographic)

// to compute
out vec3 sight;		// vector from object to eye
out vec3 normal;	// normal to the surface
flat out int flags;

void main() {
	flags = v_flags;
	
	vec4 p = view * vec4(v_position, 1);
	// camera space vectors for the fragment shader
// 	normal = mat3(view) * v_normal;
// 	sight = -vec3(p);
	// world space vectors for the fragment shader
// 	sight = - v_position - view[3][2] * transpose(mat3(view))[2];	// biased sight that doesn't change with the camera translation
	sight = - v_position - transpose(mat3(view)) * vec3(view[3]);
	normal = v_normal;
	
	gl_Position = proj * p;	// set vertex position for render
}
