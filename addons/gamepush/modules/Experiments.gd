extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var experiments:JavaScriptObject

signal after_ready


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		experiments = gp.experiments
	after_ready.emit()
	
		
func map() -> Dictionary:
	if OS.get_name() == "Web":
		return GP._js_to_dict(experiments.map)
	push_warning("Not Web")
	return JavaScriptBridge.create_object("Object")

func has(tag:String, cohort:String) -> bool:
	if OS.get_name() == "Web":
		return experiments.has(tag, cohort)
	push_warning("Not Web")
	return false
