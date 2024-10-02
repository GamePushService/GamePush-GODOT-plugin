extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var experiments:JavaScriptObject

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		experiments = gp.experiments
		
func map():
	if OS.get_name() == "Web":
	#NEED DATA STRUCTURE
		return experiments.map
	push_warning("Not Web")
	
func has(tag:String, cohort:String):
	if OS.get_name() == "Web":
		return await experiments.has(tag, cohort)
	push_warning("Not Web")
