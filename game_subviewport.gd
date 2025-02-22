extends SubViewportContainer


var viewport_shader: ShaderMaterial = null

func _ready():
	GameBus.handle_tag.connect(handle_tag)

	material.set_shader_parameter('aspect_ratio', size.x / size.y)


func _on_sub_viewport_container_resized() -> void:
	material.set_shader_parameter('aspect_ratio', size.x / size.y)


func handle_tag(tag_command, tag_args):
	if tag_command == 'light_level':
		material.set_shader_parameter('light_level', tag_args[0])