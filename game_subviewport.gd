extends SubViewportContainer


var viewport_shader: ShaderMaterial = null


func _ready():
	GameBus.handle_tag.connect(handle_tag)
	get_viewport().size_changed.connect(resize)
	resize()


func resize():
	var viewport_size = get_viewport().get_visible_rect().size
	material.set_shader_parameter('aspect_ratio', viewport_size.x / viewport_size.y)


func handle_tag(tag_command, tag_args):
	if tag_command == 'light_level':
		material.set_shader_parameter('light_level', tag_args[0])
