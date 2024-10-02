extends Node

var window:JavaScriptObject
var gp:JavaScriptObject

signal event_message(message: Message)
signal message_received(message: Message)
signal message_sent(message: Message)
signal message_error(error: String)
signal message_edited(message: Message)
signal error_edit_message(error: String)
signal event_edit_message(message: Message)
signal message_deleted(message: Message)
signal error_delete_message(error: String)
signal event_delete_message(message: Message)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		gp.channels.on('event:message', JavaScriptBridge.create_callback(_event_message))
		gp.channels.on("sendMessage", JavaScriptBridge.create_callback(_message_send))
		gp.channels.on("sendMessage", JavaScriptBridge.create_callback(_message_send))
		gp.channels.on("error:sendMessage", JavaScriptBridge.create_callback(_message_error))
		gp.channels.on("editMessage", JavaScriptBridge.create_callback(_edit_message))
		gp.channels.on("error:editMessage", JavaScriptBridge.create_callback(_edit_message_error))
		gp.channels.on("event:editMessage", JavaScriptBridge.create_callback(_event_edit_message))
		gp.channels.on("deleteMessage", JavaScriptBridge.create_callback(_delete_message))
		gp.channels.on("error:deleteMessage", JavaScriptBridge.create_callback(_delete_message_error))
		gp.channels.on("event:deleteMessage", JavaScriptBridge.create_callback(_event_delete_message))


func join(channel_id:int) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		gp.channels.join(conf)
	else:
		push_warning("Not running on Web")
	
func leave(channel_id:int) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		gp.channels.leave(conf)
	else:
		push_warning("Not running on Web")

func send_message(channel_id:int, text:String) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["text"] = text
		gp.channels.sendMessage(conf)
	else:
		push_warning("Not running on Web")

func send_personal_message(player_id: int, text: String, tags: Array = []) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["playerId"] = player_id
		conf["text"] = text
		# Add tags if provided
		if tags.size() > 0:
			var js_tags := JavaScriptBridge.create_object("Array")
			for tag in tags:
				js_tags.push(tag)
			conf["tags"] = js_tags
		# Send the personal message
		gp.channels.sendPersonalMessage(conf)
	else:
		push_warning("Not running on Web")


func send_feed_message(player_id: int, text: String, tags: Array = []) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["playerId"] = player_id
		conf["text"] = text
		# Add tags if provided
		if tags.size() > 0:
			var js_tags := JavaScriptBridge.create_object("Array")
			for tag in tags:
				js_tags.push(tag)
			conf["tags"] = js_tags
		# Send the feed message
		gp.channels.sendFeedMessage(conf)
	else:
		push_warning("Not running on Web")
		
# Function to edit a message in a specified channel
func edit_message(message_id: String, text: String) -> void:
	# Check if the platform is Web
	if OS.get_name() == "Web":
		# Create a JavaScript object for the message edit parameters
		var edit_conf := JavaScriptBridge.create_object("Object")
		edit_conf["messageId"] = message_id
		edit_conf["text"] = text

		# Call the JavaScript method to edit the message
		gp.channels.editMessage(edit_conf)
	else:
		push_warning("Not running on Web")


func delete_message(message_id: String) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["messageId"] = message_id
		gp.channels.deleteMessage(conf)
	else:
		push_warning("Not running on Web")
		

func _event_message(args):
	var message = Message.new()
	message._from_js(args[0])  # Populate message data from the JS object
	event_message.emit(message)
	
# Event handler for the sendMessage event
func _message_send(args) -> void:
	var message = Message.new()
	message._from_js(args[0])  # Populate message data from the JS object
	message_received.emit(message)  # Emit the signal with the new message

# Callback for successful message send
func _message_sent(args) -> void:
	var js_message = args[0]
	var message = Message.new()
	message._from_js(js_message)
	message_sent.emit(message)

# Callback for message send error
func _message_error(args) -> void:
	var error = args[0]
	message_error.emit(error)

# Handling successful message editing
func _edit_message(args) -> void:
	var message = Message.new()
	message._from_js(args[0])
	message_edited.emit(message)

# Handling error during message editing
func _edit_message_error(args) -> void:
	error_edit_message.emit(args[0])

# Handling general edit message event
func _event_edit_message(args) -> void:
	var message = Message.new()
	message._from_js(args[0])
	event_edit_message.emit(message)
	
# Handling successful message deletion
func _delete_message(args) -> void:
	var message = Message.new()
	message._from_js(args[0])
	message_deleted.emit(message)

# Handling error during message deletion
func _delete_message_error(args) -> void:
	error_delete_message.emit(args[0])

# Handling general delete message event
func _event_delete_message(args) -> void:
	var message = Message.new()
	message._from_js(args[0])
	event_delete_message.emit(message)

# Message class to encapsulate message data
class Message:
	var id: String
	var channel_id: String
	var author_id: String
	var text: String
	var tags: Array # Array of strings
	var player: Player # Using the Player class
	var created_at: int

	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["channelId"] = channel_id
		js_object["authorId"] = author_id
		js_object["text"] = text
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		js_object["tags"] = js_tags
		if player:
			js_object["player"] = player._to_js()
		js_object["createdAt"] = created_at
		return js_object

	func _from_js(js_object: JavaScriptObject) -> Message:
		id = js_object["id"]
		channel_id = js_object["channelId"]
		author_id = js_object["authorId"]
		text = js_object["text"]
		tags = []
		for js_tag in js_object["tags"]:
			tags.append(js_tag)
		if js_object.has("player"):
			player = Player.new()
			player._from_js(js_object["player"])
		created_at = js_object["createdAt"]
		return self

	
class Player:
	var id: String
	var name: String
	var avatar: String

	# Method to convert the player to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["name"] = name
		js_object["avatar"] = avatar
		return js_object

	# Method to initialize the player from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> Player:
		id = js_object["id"]
		name = js_object["name"]
		avatar = js_object["avatar"]
		return self
