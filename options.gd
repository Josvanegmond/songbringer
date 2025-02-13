extends Control


@onready var control_settings = $Panel/MarginContainer/VBoxContainer/ScrollContainer/ControlSettings
@onready var general_settings = $Panel/MarginContainer/VBoxContainer/ScrollContainer/GeneralSettings


func _on_general_settings_button_pressed() -> void:
	switch_to(general_settings)


func _on_control_settings_button_pressed() -> void:
	switch_to(control_settings)


func switch_to(settings):
	general_settings.visible = settings == general_settings
	control_settings.visible = settings == control_settings

