@tool
extends CollisionShape3D


@onready var collision_shape = $StaticBody3D/CollisionShape3D
@onready var mesh_instance = $MeshInstance3D


@export var color: Color = Color('#ffffff'):
	get ():
		return color
	set (c):
		color = c
		_update_material()


func _ready() -> void:
	shape.changed.connect(_update_shape)
	_update_shape()
	_update_material()


func _update_shape():
	var box_shape: BoxShape3D = shape
	collision_shape.shape = box_shape
	
	var mesh: BoxMesh = mesh_instance.mesh
	mesh.size = box_shape.size


func _update_material():
	if !mesh_instance: return
	if !mesh_instance.mesh.material:
		mesh_instance.mesh.material = StandardMaterial3D.new()
		mesh_instance.mesh.material.setup_local_to_scene()

	var material: StandardMaterial3D = mesh_instance.mesh.material
	material.albedo_color = color
