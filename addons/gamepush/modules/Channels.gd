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
signal messages_fetched(result: Dictionary)
signal error_fetch_messages(error: String)
signal fetched_more_messages(result: Dictionary)
signal error_fetch_more_messages(error: String)
signal channel_created(channel: Channel)
signal error_create_channel(error: String)
signal channel_updated(channel: Channel)
signal error_update_channel(error: String)
signal event_channel_updated(channel: Channel)
signal channel_deleted(channel: Channel)
signal error_delete_channel(error: String)
signal event_channel_deleted(channel: Channel)

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
		gp.channels.on("fetchMessages", JavaScriptBridge.create_callback(_fetch_messages))
		gp.channels.on("error:fetchMessages", JavaScriptBridge.create_callback(_fetch_messages_error))
		gp.channels.on("fetchMoreMessages", JavaScriptBridge.create_callback(_on_fetch_more_messages))
		gp.channels.on("error:fetchMoreMessages", JavaScriptBridge.create_callback(_on_fetch_more_messages_error))
		gp.channels.on("createChannel", JavaScriptBridge.create_callback(_on_create_channel))
		gp.channels.on("error:createChannel", JavaScriptBridge.create_callback(_on_create_channel_error))
		gp.channels.on('updateChannel', JavaScriptBridge.create_callback(_on_update_channel))
		gp.channels.on('error:updateChannel', JavaScriptBridge.create_callback(_on_update_channel_error))
		gp.channels.on("event:updateChannel", JavaScriptBridge.create_callback(_on_event_update_channel))
		gp.channels.on('deleteChannel', JavaScriptBridge.create_callback(_on_delete_channel))
		gp.channels.on('error:deleteChannel', JavaScriptBridge.create_callback(_on_delete_channel_error))
		
		
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
		
func fetch_messages(channel_id: int, tags: Array, limit: int = 100, offset: int = 0) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["limit"] = limit
		conf["offset"] = offset
		var result = await gp.channels.fetchMessages(conf)
		var items := []
		for i in result.items:
			items.append(Message.new()._from_js(i))
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
		

func fetch_personal_messages(channel_id: int, tags: Array, limit: int = 100, offset: int = 0) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["limit"] = limit
		conf["offset"] = offset
		var result = await gp.channels.fetchPersonalMessages(conf)
		var items := []
		for i in result.items:
			items.append(Message.new()._from_js(i))
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}


func fetch_feed_messages(channel_id: int, tags: Array, limit: int = 100, offset: int = 0) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["limit"] = limit
		conf["offset"] = offset
		var result = await gp.channels.fetchFeedMessages(conf)
		var items := []
		for i in result.items:
			items.append(Message.new()._from_js(i))
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
# Fetch more messages from a channel
func fetch_more_messages(channel_id: int, tags: Array, limit: int = 100) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["limit"] = limit
		var result = await gp.channels.fetchMoreMessages(conf)
		var items := []
		for i in result.items:
			items.append(Message.new()._from_js(i))
		var canLoadMore: bool = result.canLoadMore
		return {"items": items, "can_load_more": canLoadMore}
	else:
		push_warning("Not running on Web")
		return {"items": null, "can_load_more": null}

# Fetch more personal messages from a player
func fetch_more_personal_messages(player_id: int, tags: Array, limit: int = 100) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["playerId"] = player_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["limit"] = limit
		var result = await gp.channels.fetchMorePersonalMessages(conf)
		var items := []
		for i in result.items:
			items.append(Message.new()._from_js(i))
		var canLoadMore: bool = result.canLoadMore
		return {"items": items, "can_load_more": canLoadMore}
	else:
		push_warning("Not running on Web")
		return {"items": null, "can_load_more": null}

# Fetch more feed messages from a player
func fetch_more_feed_messages(player_id: int, tags: Array, limit: int = 100) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["playerId"] = player_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["limit"] = limit
		var result = await gp.channels.fetchMoreFeedMessages(conf)
		var items := []
		for i in result.items:
			items.append(Message.new()._from_js(i))
		var canLoadMore: bool = result.canLoadMore
		return {"items": items, "can_load_more": canLoadMore}
	else:
		push_warning("Not running on Web")
		return {"items": null, "can_load_more": null}


func create_channel(template: String, tags: Array, capacity: int, name: String, description: String, private: bool, visible: bool, password: String, owner_acl: Dictionary, member_acl: Dictionary, guest_acl: Dictionary) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["template"] = template
		# Convert GDScript Array to JavaScript Array for tags
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		conf["capacity"] = capacity
		conf["name"] = name
		conf["description"] = description
		conf["private"] = private
		conf["visible"] = visible
		conf["password"] = password
		# Handle ownerAcl
		var js_owner_acl := JavaScriptBridge.create_object("Object")
		js_owner_acl["canViewMessages"] = owner_acl.get("canViewMessages", false)
		js_owner_acl["canAddMessage"] = owner_acl.get("canAddMessage", false)
		js_owner_acl["canEditMessage"] = owner_acl.get("canEditMessage", false)
		js_owner_acl["canDeleteMessage"] = owner_acl.get("canDeleteMessage", false)
		js_owner_acl["canViewMembers"] = owner_acl.get("canViewMembers", false)
		js_owner_acl["canInvitePlayer"] = owner_acl.get("canInvitePlayer", false)
		js_owner_acl["canKickPlayer"] = owner_acl.get("canKickPlayer", false)
		js_owner_acl["canAcceptJoinRequest"] = owner_acl.get("canAcceptJoinRequest", false)
		js_owner_acl["canMutePlayer"] = owner_acl.get("canMutePlayer", false)
		conf["ownerAcl"] = js_owner_acl

		# Handle memberAcl
		var js_member_acl := JavaScriptBridge.create_object("Object")
		js_member_acl["canViewMessages"] = member_acl.get("canViewMessages", false)
		js_member_acl["canAddMessage"] = member_acl.get("canAddMessage", false)
		js_member_acl["canEditMessage"] = member_acl.get("canEditMessage", false)
		js_member_acl["canDeleteMessage"] = member_acl.get("canDeleteMessage", false)
		js_member_acl["canViewMembers"] = member_acl.get("canViewMembers", false)
		js_member_acl["canInvitePlayer"] = member_acl.get("canInvitePlayer", false)
		js_member_acl["canKickPlayer"] = member_acl.get("canKickPlayer", false)
		js_member_acl["canAcceptJoinRequest"] = member_acl.get("canAcceptJoinRequest", false)
		js_member_acl["canMutePlayer"] = member_acl.get("canMutePlayer", false)
		conf["memberAcl"] = js_member_acl

		# Handle guestAcl
		var js_guest_acl := JavaScriptBridge.create_object("Object")
		js_guest_acl["canViewMessages"] = guest_acl.get("canViewMessages", false)
		js_guest_acl["canAddMessage"] = guest_acl.get("canAddMessage", false)
		js_guest_acl["canEditMessage"] = guest_acl.get("canEditMessage", false)
		js_guest_acl["canDeleteMessage"] = guest_acl.get("canDeleteMessage", false)
		js_guest_acl["canViewMembers"] = guest_acl.get("canViewMembers", false)
		js_guest_acl["canInvitePlayer"] = guest_acl.get("canInvitePlayer", false)
		js_guest_acl["canKickPlayer"] = guest_acl.get("canKickPlayer", false)
		js_guest_acl["canAcceptJoinRequest"] = guest_acl.get("canAcceptJoinRequest", false)
		js_guest_acl["canMutePlayer"] = guest_acl.get("canMutePlayer", false)
		conf["guestAcl"] = js_guest_acl

		gp.channels.createChannel(conf)
	else:
		push_warning("Not running on Web")


func update_channel(channel_id: int, tags = null, capacity = null, name = null,
 description = null, private = null, visible = null, password = null,
 owner_acl = null, member_acl = null, guest_acl = null	) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		# Convert GDScript Array to JavaScript Array for tags
		if tags != null:
			var js_tags := JavaScriptBridge.create_object("Array")
			for tag in tags:
				js_tags.push(tag)
			conf["tags"] = js_tags
		if capacity != null:
			conf["capacity"] = capacity
		if name != null:
			conf["name"] = name
		if description != null:
			conf["description"] = description
		if private != null:
			conf["private"] = private
		if visible != null:
			conf["visible"] = visible
		if password != null:
			conf["password"] = password
		# Handle ownerAcl
		if owner_acl != null:
			var js_owner_acl := JavaScriptBridge.create_object("Object")
			js_owner_acl["canViewMessages"] = owner_acl.get("canViewMessages")
			js_owner_acl["canAddMessage"] = owner_acl.get("canAddMessage")
			js_owner_acl["canEditMessage"] = owner_acl.get("canEditMessage")
			js_owner_acl["canDeleteMessage"] = owner_acl.get("canDeleteMessage")
			js_owner_acl["canViewMembers"] = owner_acl.get("canViewMembers")
			js_owner_acl["canInvitePlayer"] = owner_acl.get("canInvitePlayer")
			js_owner_acl["canKickPlayer"] = owner_acl.get("canKickPlayer")
			js_owner_acl["canAcceptJoinRequest"] = owner_acl.get("canAcceptJoinRequest")
			js_owner_acl["canMutePlayer"] = owner_acl.get("canMutePlayer")
			conf["ownerAcl"] = js_owner_acl

		# Handle memberAcl
		if member_acl != null:
			var js_member_acl := JavaScriptBridge.create_object("Object")
			js_member_acl["canViewMessages"] = member_acl.get("canViewMessages")
			js_member_acl["canAddMessage"] = member_acl.get("canAddMessage")
			js_member_acl["canEditMessage"] = member_acl.get("canEditMessage")
			js_member_acl["canDeleteMessage"] = member_acl.get("canDeleteMessage")
			js_member_acl["canViewMembers"] = member_acl.get("canViewMembers")
			js_member_acl["canInvitePlayer"] = member_acl.get("canInvitePlayer")
			js_member_acl["canKickPlayer"] = member_acl.get("canKickPlayer")
			js_member_acl["canAcceptJoinRequest"] = member_acl.get("canAcceptJoinRequest")
			js_member_acl["canMutePlayer"] = member_acl.get("canMutePlayer")
			conf["memberAcl"] = js_member_acl

		# Handle guestAcl
		if guest_acl != null:
			var js_guest_acl := JavaScriptBridge.create_object("Object")
			js_guest_acl["canViewMessages"] = guest_acl.get("canViewMessages")
			js_guest_acl["canAddMessage"] = guest_acl.get("canAddMessage")
			js_guest_acl["canEditMessage"] = guest_acl.get("canEditMessage")
			js_guest_acl["canDeleteMessage"] = guest_acl.get("canDeleteMessage")
			js_guest_acl["canViewMembers"] = guest_acl.get("canViewMembers")
			js_guest_acl["canInvitePlayer"] = guest_acl.get("canInvitePlayer")
			js_guest_acl["canKickPlayer"] = guest_acl.get("canKickPlayer")
			js_guest_acl["canAcceptJoinRequest"] = guest_acl.get("canAcceptJoinRequest")
			js_guest_acl["canMutePlayer"] = guest_acl.get("canMutePlayer")
			conf["guestAcl"] = js_guest_acl

		gp.channels.updateChannel(conf)
	else:
		push_warning("Not running on Web")

# Function to delete a channel
func delete_channel(channel_id: int) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		gp.channels.deleteChannel(conf)
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

# Handling successful message fetching
func _fetch_messages(args) -> void:
	var result = args[0]
	var items := []
	for i in result.items:
		items.append(Message.new()._from_js(i))
	emit_signal("messages_fetched", {"items": items,
									"can_load_more": result.canLoadMore
									})

# Handling error during message fetching
func _fetch_messages_error(args) -> void:
	emit_signal("error_fetch_messages", args[0])
	
# Handling successful fetchMoreMessages
func _on_fetch_more_messages(args) -> void:
	var result = args[0]
	var items = []
	for i in result.items:
		var message = Message.new()
		message._from_js(i)
		items.append(message)
	emit_signal("fetched_more_messages", {"items": items, "can_load_more": result.canLoadMore })

# Handling error during fetchMoreMessages
func _on_fetch_more_messages_error(args) -> void:
	emit_signal("error_fetch_more_messages", args[0])

# Handling successful channel creation
func _on_create_channel(args) -> void:
	var channel = Channel.new()._from_js(args[0])
	emit_signal("channel_created", channel)

# Handling errors during channel creation
func _on_create_channel_error(args) -> void:
	emit_signal("error_create_channel", args[0])

# Handling successful channel update
func _on_update_channel(args) -> void:
	var channel = Channel.new()
	channel._from_js(args[0])
	channel_updated.emit(channel)

# Handling error during channel update
func _on_update_channel_error(args) -> void:
	error_update_channel.emit(args[0])
	
func _on_event_update_channel(args) -> void:
	var channel = Channel.new()
	channel._from_js(args[0])
	channel_updated.emit(channel)
	
# Handling successful channel deletion
func _on_delete_channel() -> void:
	channel_deleted.emit()
	
	
func _on_delete_channel_error(args) -> void:
	channel_deleted.emit(args[0])
	
func _on_event_delete_channel(args) -> void:
	var channel = Channel.new()
	channel._from_js(args[0])
	channel_updated.emit(channel)
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

class Channel:
	var id: int
	var tags: Array
	var message_tags: Array
	var template_id: String
	var capacity: int
	var owner_id: int
	var name: String
	var description: String
	var private: bool
	var visible: bool
	var permanent: bool
	var has_password: bool
	var is_joined: bool
	var is_request_sent: bool
	var is_invited: bool
	var is_muted: bool
	var password: String
	var members_count: int
	var owner_acl: Dictionary
	var member_acl: Dictionary
	var guest_acl: Dictionary

	func _from_js(js_object: JavaScriptObject) -> Channel:
		id = js_object["id"]
		tags = []
		for t in js_object["tags"]:
			tags.append(t)
		message_tags = []
		for t in js_object["messageTags"]:
			message_tags.append(t)
		template_id = js_object["templateId"]
		capacity = js_object["capacity"]
		owner_id = js_object["ownerId"]
		name = js_object["name"]
		description = js_object["description"]
		private = js_object["private"]
		visible = js_object["visible"]
		permanent = js_object["permanent"]
		has_password = js_object["hasPassword"]
		is_joined = js_object["isJoined"]
		is_request_sent = js_object["isRequestSent"]
		is_invited = js_object["isInvited"]
		is_muted = js_object["isMuted"]
		password = js_object["password"]
		members_count = js_object["membersCount"]
		owner_acl = {}
		owner_acl["canViewMessages"] = js_object["ownerAcl"]["canViewMessages"]
		owner_acl["canAddMessage"] = js_object["ownerAcl"]["canAddMessage"]
		owner_acl["canEditMessage"] = js_object["ownerAcl"]["canEditMessage"]
		owner_acl["canDeleteMessage"] = js_object["ownerAcl"]["canDeleteMessage"]
		owner_acl["canViewMembers"] = js_object["ownerAcl"]["canViewMembers"]
		owner_acl["canInvitePlayer"] = js_object["ownerAcl"]["canInvitePlayer"]
		owner_acl["canKickPlayer"] = js_object["ownerAcl"]["canKickPlayer"]
		owner_acl["canAcceptJoinRequest"] = js_object["ownerAcl"]["canAcceptJoinRequest"]
		owner_acl["canMutePlayer"] = js_object["ownerAcl"]["canMutePlayer"]
		member_acl = {}
		member_acl["canViewMessages"] = js_object["memberAcl"]["canViewMessages"]
		member_acl["canAddMessage"] = js_object["memberAcl"]["canAddMessage"]
		member_acl["canEditMessage"] = js_object["memberAcl"]["canEditMessage"]
		member_acl["canDeleteMessage"] = js_object["memberAcl"]["canDeleteMessage"]
		member_acl["canViewMembers"] = js_object["memberAcl"]["canViewMembers"]
		member_acl["canInvitePlayer"] = js_object["memberAcl"]["canInvitePlayer"]
		member_acl["canKickPlayer"] = js_object["memberAcl"]["canKickPlayer"]
		member_acl["canAcceptJoinRequest"] = js_object["memberAcl"]["canAcceptJoinRequest"]
		member_acl["canMutePlayer"] = js_object["memberAcl"]["canMutePlayer"]
		guest_acl = {}
		guest_acl["canViewMessages"] = js_object["guestAcl"]["canViewMessages"]
		guest_acl["canAddMessage"] = js_object["guestAcl"]["canAddMessage"]
		guest_acl["canEditMessage"] = js_object["guestAcl"]["canEditMessage"]
		guest_acl["canDeleteMessage"] = js_object["guestAcl"]["canDeleteMessage"]
		guest_acl["canViewMembers"] = js_object["guestAcl"]["canViewMembers"]
		guest_acl["canInvitePlayer"] = js_object["guestAcl"]["canInvitePlayer"]
		guest_acl["canKickPlayer"] = js_object["guestAcl"]["canKickPlayer"]
		guest_acl["canAcceptJoinRequest"] = js_object["guestAcl"]["canAcceptJoinRequest"]
		guest_acl["canMutePlayer"] = js_object["guestAcl"]["canMutePlayer"]
		return self

	func _to_js() -> JavaScriptObject:
		var data := JavaScriptBridge.create_object("Object")
		data["id"] = id
		data["tags"] = JavaScriptBridge.create_object("Array")
		for t in tags:
			data["tags"].push(t)
		data["messageTags"] = JavaScriptBridge.create_object("Array")
		for t in message_tags:
			data["messageTags"].push(t)
		data["templateId"] = template_id
		data["capacity"] = capacity
		data["ownerId"] = owner_id
		data["name"] = name
		data["description"] = description
		data["private"] = private
		data["visible"] = visible
		data["permanent"] = permanent
		data["hasPassword"] = has_password
		data["isJoined"] = is_joined
		data["isRequestSent"] = is_request_sent
		data["isInvited"] = is_invited
		data["isMuted"] = is_muted
		data["password"] = password
		data["membersCount"] = members_count
		var js_owner_acl := JavaScriptBridge.create_object("Object")
		js_owner_acl["canViewMessages"] = owner_acl.get("canViewMessages", false)
		js_owner_acl["canAddMessage"] = owner_acl.get("canAddMessage", false)
		js_owner_acl["canEditMessage"] = owner_acl.get("canEditMessage", false)
		js_owner_acl["canDeleteMessage"] = owner_acl.get("canDeleteMessage", false)
		js_owner_acl["canViewMembers"] = owner_acl.get("canViewMembers", false)
		js_owner_acl["canInvitePlayer"] = owner_acl.get("canInvitePlayer", false)
		js_owner_acl["canKickPlayer"] = owner_acl.get("canKickPlayer", false)
		js_owner_acl["canAcceptJoinRequest"] = owner_acl.get("canAcceptJoinRequest", false)
		js_owner_acl["canMutePlayer"] = owner_acl.get("canMutePlayer", false)
		data["ownerAcl"] = js_owner_acl
		# Handle memberAcl
		var js_member_acl := JavaScriptBridge.create_object("Object")
		js_member_acl["canViewMessages"] = member_acl.get("canViewMessages", false)
		js_member_acl["canAddMessage"] = member_acl.get("canAddMessage", false)
		js_member_acl["canEditMessage"] = member_acl.get("canEditMessage", false)
		js_member_acl["canDeleteMessage"] = member_acl.get("canDeleteMessage", false)
		js_member_acl["canViewMembers"] = member_acl.get("canViewMembers", false)
		js_member_acl["canInvitePlayer"] = member_acl.get("canInvitePlayer", false)
		js_member_acl["canKickPlayer"] = member_acl.get("canKickPlayer", false)
		js_member_acl["canAcceptJoinRequest"] = member_acl.get("canAcceptJoinRequest", false)
		js_member_acl["canMutePlayer"] = member_acl.get("canMutePlayer", false)
		data["memberAcl"] = js_member_acl
		# Handle guestAcl
		var js_guest_acl := JavaScriptBridge.create_object("Object")
		js_guest_acl["canViewMessages"] = guest_acl.get("canViewMessages", false)
		js_guest_acl["canAddMessage"] = guest_acl.get("canAddMessage", false)
		js_guest_acl["canEditMessage"] = guest_acl.get("canEditMessage", false)
		js_guest_acl["canDeleteMessage"] = guest_acl.get("canDeleteMessage", false)
		js_guest_acl["canViewMembers"] = guest_acl.get("canViewMembers", false)
		js_guest_acl["canInvitePlayer"] = guest_acl.get("canInvitePlayer", false)
		js_guest_acl["canKickPlayer"] = guest_acl.get("canKickPlayer", false)
		js_guest_acl["canAcceptJoinRequest"] = guest_acl.get("canAcceptJoinRequest", false)
		js_guest_acl["canMutePlayer"] = guest_acl.get("canMutePlayer", false)
		data["guestAcl"] = js_guest_acl
		return data
