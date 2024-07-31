@tool
extends Control

signal main_scene_data_change

var archive_name := "export_archive.zip"
var project_id := ""
var token := ""



func _on_project_id_text_changed(new_text: String) -> void:
	project_id = new_text
	main_scene_data_change.emit()


func _on_token_text_changed(new_text: String) -> void:
	token = new_text
	main_scene_data_change.emit()


func _on_is_archive_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$MarginContainer/VBoxContainer/HBoxContainer3/NameArchive.editable = true
	else:
		$MarginContainer/VBoxContainer/HBoxContainer3/NameArchive.editable = false
	#TODO add bool logic
	main_scene_data_change.emit()


func _on_name_archive_text_changed(new_text: String) -> void:
	if new_text.ends_with(".zip"):
		archive_name = new_text
	else:
		archive_name = new_text + ".zip"
	main_scene_data_change.emit()


func _on_show_preload_toggled(toggled_on: bool) -> void:
	pass #TODO Replace with function body.


func _on_ready_delay_text_changed(new_text: String) -> void:
	pass #TODO Replace with function body.
