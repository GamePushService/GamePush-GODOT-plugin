extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal paused
signal resumed

var _callback_pause := JavaScriptBridge.create_callback(_pause)
var _callback_resume := JavaScriptBridge.create_callback(_resume)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		gp.on("pause", _callback_pause)
		gp.on("resume", _callback_resume)
	else:
		push_warning("Not Web")
		
		
func is_paused() -> bool:
	if OS.get_name() == "Web":
		return gp.isPaused
	else:
		push_warning("Not Web")
		return false

func pause() -> void:
	if OS.get_name() == "Web":
		gp.pause()
	else:
		push_warning("Not Web")
		
func resume() -> void:
	if OS.get_name() == "Web":
		gp.resume()
	else:
		push_warning("Not Web")

func game_start() -> void:
	if OS.get_name() == "Web":
		while not gp:
			pass
		gp.gameStart()
	else:
		push_warning("Not Web")
		
func gameplay_start() -> void:
	if OS.get_name() == "Web":
		gp.gameplayStart()
	else:
		push_warning("Not Web")

func gameplay_stop() -> void:
	if OS.get_name() == "Web":
		gp.gameplayStop()
	else:
		push_warning("Not Web")

#TODO happytime

func _pause(args): paused.emit() 
func _resume(args): resumed.emit()
