extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
#var game:JavaScriptObject

signal paused
signal resumed

var callback_pause := JavaScriptBridge.create_callback(_pause)
var callback_resume := JavaScriptBridge.create_callback(_resume)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		#game = gp.game
		gp.on("pause", callback_pause)
		gp.on("resume", callback_resume)
		
		
func is_paused():
	if OS.get_name() == "Web":
		return gp.isPaused

func pause():
	if OS.get_name() == "Web":
		gp.pause()
		
func resume():
	if OS.get_name() == "Web":
		gp.resume()

func game_start():
	if OS.get_name() == "Web":
		gp.gameStart()
		
func gameplay_start():
	if OS.get_name() == "Web":
		gp.gameplayStart()
		
func gameplay_stop():
	if OS.get_name() == "Web":
		gp.gameplayStop()

#TODO happytime

func _pause(args): paused.emit() 
func _resume(args): resumed.emit()
