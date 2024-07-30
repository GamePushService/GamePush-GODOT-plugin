@tool
extends EditorExportPlugin
class_name  HTMLExportPlugin


var export_path: String = get_script().resource_path.get_base_dir()

func _get_name() -> String:
	return "Game Push"


func _export_begin(features: PackedStringArray , is_debug: bool, path: String, flags: int) -> void:
	pass
	
	
func _export_end() -> void:
	pass
