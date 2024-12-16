extends Node

signal after_ready

var window:JavaScriptObject
var gp:JavaScriptObject
var analytics:JavaScriptObject

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
			analytics = gp.analytics
	after_ready.emit()

func hit(url:String) -> void:
	if OS.get_name() == "Web":
		analytics.hit(url)
	else:
		push_warning("Not running on Web")


func goal(name:String, value=null) -> void:
	# Check if the platform is Web
	if OS.get_name() == "Web":
		if value != null:
			if value is String and value.is_valid_int():
				value = int(value)
			analytics.goal(name, value)
			return
		analytics.goal(name)
	else:
		push_warning("Not running on Web")

			
