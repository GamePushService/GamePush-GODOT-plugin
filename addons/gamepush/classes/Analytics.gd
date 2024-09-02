extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var analytics:JavaScriptObject

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		analytics = gp.analytics
		
func hit(url:String):
	analytics.hit(url)

func goal(name:String, value=null):
	if value:
		analytics.goal(name, value)
		return
	analytics.goal(name)
