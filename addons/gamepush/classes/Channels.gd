extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var channels:JavaScriptObject

signal event_message

var callback_event_message = JavaScriptBridge.create_callback(_event_message)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		channels = gp.channels
		
		channels.on('event:message', callback_event_message)
		

func join(channel_id:int):
	var conf := JavaScriptBridge.create_object("Object")
	conf["channelId"] = channel_id
	channels.join(conf)
	
func leave(channel_id:int):
	var conf := JavaScriptBridge.create_object("Object")
	conf["channelId"] = channel_id
	channels.leave(conf)

func sendMessage(channel_id:int, text:String):
	var conf := JavaScriptBridge.create_object("Object")
	conf["channelId"] = channel_id
	conf["text"] = text
	channels.sendMessage(conf)


func _event_message(args):
	var message = args[0]
	event_message.emit(message)
