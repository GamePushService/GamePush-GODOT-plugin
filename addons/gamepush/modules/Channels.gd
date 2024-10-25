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
signal channel_fetched(channel: Channel)
signal fetch_channel_error(err: String)
signal channels_fetched(channels: Array, can_load_more: bool)
signal fetch_channels_error(error: String)
signal more_channels_fetched(channels: Array, can_load_more: bool)
signal fetch_more_channels_error(error: String)
signal chat_opened()
signal chat_closed()
signal chat_error(error: String)
signal joined()
signal error_join(err: String)
signal event_joined(member: Dictionary)
signal join_request_received(join_request: Dictionary)
signal cancel_joined()
signal cancel_join_error(error: String)
signal event_cancel_join(join_request: Dictionary)
signal leave_successful()
signal leave_error(error: String)
signal leave_event(member: Dictionary)
signal kick_successful()
signal kick_error(error: String)
signal members_fetched(members:Array, can_load_more:bool)
signal fetch_members_error(error: String)
signal fetch_more_members_success(members: Array, can_load_more:bool)
signal fetch_more_members_error(error: String)
signal mute_success()
signal mute_error(error: String)
signal event_mute(mute: Mute)
signal unmute_success()
signal unmute_error(error: String)
signal event_unmute(unmute: Dictionary)
signal sent_invite()
signal sent_invite_error(error: String)
signal event_invite(invite:Dictionary)
signal canceled_invite()
signal cancel_invite_error(error: String)
signal event_cancel_invite(invite:Dictionary)
signal accepted_invite()
signal error_accept_invite(error: String)
signal rejected_invite()
signal error_reject_invite(error: String)
signal event_reject_invite(invite:Dictionary)
signal fetched_invites(result:Dictionary)
signal error_fetch_invites(error:String)
signal fetched_more_invites(result:Dictionary)
signal error_fetch_more_invites(error:String)
signal fetched_channel_invites(result:Dictionary)
signal error_fetch_channel_invites(error:String)
signal fetched_more_channel_invites(result:Dictionary)
signal error_fetch_more_channel_invites(error:String)
signal fetched_sent_invites(result:Dictionary)
signal error_fetch_sent_invites(error:String)
signal fetched_more_sent_invites(result:Dictionary)
signal error_fetch_more_sent_invites(error:String)

# Глобальные переменные для всех коллбэков
var _callback_event_message := JavaScriptBridge.create_callback(_event_message)
var _callback_message_send := JavaScriptBridge.create_callback(_message_send)
var _callback_message_error := JavaScriptBridge.create_callback(_message_error)
var _callback_edit_message := JavaScriptBridge.create_callback(_edit_message)
var _callback_edit_message_error := JavaScriptBridge.create_callback(_edit_message_error)
var _callback_event_edit_message := JavaScriptBridge.create_callback(_event_edit_message)
var _callback_delete_message := JavaScriptBridge.create_callback(_delete_message)
var _callback_delete_message_error := JavaScriptBridge.create_callback(_delete_message_error)
var _callback_event_delete_message := JavaScriptBridge.create_callback(_event_delete_message)
var _callback_fetch_messages := JavaScriptBridge.create_callback(_fetch_messages)
var _callback_fetch_messages_error := JavaScriptBridge.create_callback(_fetch_messages_error)
var _callback_fetch_more_messages := JavaScriptBridge.create_callback(_on_fetch_more_messages)
var _callback_fetch_more_messages_error := JavaScriptBridge.create_callback(_on_fetch_more_messages_error)
var _callback_create_channel := JavaScriptBridge.create_callback(_on_create_channel)
var _callback_create_channel_error := JavaScriptBridge.create_callback(_on_create_channel_error)
var _callback_update_channel := JavaScriptBridge.create_callback(_on_update_channel)
var _callback_update_channel_error := JavaScriptBridge.create_callback(_on_update_channel_error)
var _callback_event_update_channel := JavaScriptBridge.create_callback(_on_event_update_channel)
var _callback_delete_channel := JavaScriptBridge.create_callback(_on_delete_channel)
var _callback_delete_channel_error := JavaScriptBridge.create_callback(_on_delete_channel_error)
var _callback_fetch_channel := JavaScriptBridge.create_callback(_on_fetch_channel)
var _callback_fetch_channel_error := JavaScriptBridge.create_callback(_on_fetch_channel_error)
var _callback_fetch_channels := JavaScriptBridge.create_callback(_on_fetch_channels)
var _callback_fetch_channels_error := JavaScriptBridge.create_callback(_on_fetch_channels_error)
var _callback_open_chat := JavaScriptBridge.create_callback(_on_open_chat)
var _callback_close_chat := JavaScriptBridge.create_callback(_on_close_chat)
var _callback_chat_error := JavaScriptBridge.create_callback(_on_chat_error)
var _callback_join := JavaScriptBridge.create_callback(_on_join)
var _callback_join_error := JavaScriptBridge.create_callback(_on_join_error)
var _callback_event_join := JavaScriptBridge.create_callback(_on_event_join)
var _callback_event_join_request := JavaScriptBridge.create_callback(_on_event_join_request)
var _callback_leave_successful := JavaScriptBridge.create_callback(_on_leave_successful)
var _callback_leave_error := JavaScriptBridge.create_callback(_on_leave_error)
var _callback_leave_event := JavaScriptBridge.create_callback(_on_leave_event)
var _callback_kick_successful := JavaScriptBridge.create_callback(_on_kick_successful)
var _callback_kick_error := JavaScriptBridge.create_callback(_on_kick_error)
var _callback_fetch_members := JavaScriptBridge.create_callback(_on_fetch_members)
var _callback_fetch_members_error := JavaScriptBridge.create_callback(_on_fetch_members_error)
var _callback_fetch_more_members := JavaScriptBridge.create_callback(_on_fetch_more_members)
var _callback_fetch_more_members_error := JavaScriptBridge.create_callback(_on_fetch_more_members_error)
var _callback_mute := JavaScriptBridge.create_callback(_on_mute)
var _callback_mute_error := JavaScriptBridge.create_callback(_on_mute_error)
var _callback_event_mute := JavaScriptBridge.create_callback(_on_event_mute)
var _callback_unmute := JavaScriptBridge.create_callback(_on_unmute)
var _callback_error_unmute := JavaScriptBridge.create_callback(_on_error_unmute)
var _callback_event_unmute := JavaScriptBridge.create_callback(_on_event_unmute)
var _callback_send_invite := JavaScriptBridge.create_callback(_on_send_invite)
var _callback_send_invite_error := JavaScriptBridge.create_callback(_on_send_invite_error)
var _callback_event_invite := JavaScriptBridge.create_callback(_on_event_invite)
var _callback_cancel_invite := JavaScriptBridge.create_callback(_on_cancel_invite)
var _callback_cancel_invite_error : = JavaScriptBridge.create_callback(_on_cancel_invite_error)
var _callback_event_cancel_invite : = JavaScriptBridge.create_callback(_on_event_cancel_invite)
var _callback_accept_invite : = JavaScriptBridge.create_callback(_on_accept_invite)
var _callback_error_accept_invite := JavaScriptBridge.create_callback(_on_error_accept_invite)
var _callback_reject_invite := JavaScriptBridge.create_callback(_on_reject_invite)
var _callback_error_reject_invite := JavaScriptBridge.create_callback(_on_error_reject_invite)
var _callback_event_reject_invite := JavaScriptBridge.create_callback(_on_event_reject_invite)
var _callback_fetch_invites:= JavaScriptBridge.create_callback(_on_fetch_invites)
var _callback_error_fetch_invites := JavaScriptBridge.create_callback(_on_error_fetch_invites)
var _callback_fetch_more_invites := JavaScriptBridge.create_callback(_on_fetch_more_invites)
var _callback_error_fetch_more_invites := JavaScriptBridge.create_callback(_on_error_fetch_more_invites)
var _callback_fetch_channel_invites := JavaScriptBridge.create_callback(_on_fetch_channel_invites)
var _callback_error_fetch_channel_invites := JavaScriptBridge.create_callback(_on_error_fetch_channel_invites)
var _callback_fetch_more_channel_invites := JavaScriptBridge.create_callback(_on_fetch_more_channel_invites)
var _callback_error_fetch_more_channel_invites := JavaScriptBridge.create_callback(_on_error_fetch_more_channel_invites)
var _callback_fetch_sent_invites := JavaScriptBridge.create_callback(_on_fetch_sent_invites)
var _callback_error_fetch_sent_invites := JavaScriptBridge.create_callback(_on_error_fetch_sent_invites)
var _callback_fetch_more_sent_invites := JavaScriptBridge.create_callback(_on_fetch_more_sent_invites)
var _callback_error_fetch_more_sent_invites := JavaScriptBridge.create_callback(_on_error_fetch_more_sent_invites)


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		
		# Привязка коллбэков к событиям
		gp.channels.on('event:message', _callback_event_message)
		gp.channels.on("sendMessage", _callback_message_send)
		gp.channels.on("error:sendMessage", _callback_message_error)
		gp.channels.on("editMessage", _callback_edit_message)
		gp.channels.on("error:editMessage", _callback_edit_message_error)
		gp.channels.on("event:editMessage", _callback_event_edit_message)
		gp.channels.on("deleteMessage", _callback_delete_message)
		gp.channels.on("error:deleteMessage", _callback_delete_message_error)
		gp.channels.on("event:deleteMessage", _callback_event_delete_message)
		gp.channels.on("fetchMessages", _callback_fetch_messages)
		gp.channels.on("error:fetchMessages", _callback_fetch_messages_error)
		gp.channels.on("fetchMoreMessages", _callback_fetch_more_messages)
		gp.channels.on("error:fetchMoreMessages", _callback_fetch_more_messages_error)
		gp.channels.on("createChannel", _callback_create_channel)
		gp.channels.on("error:createChannel", _callback_create_channel_error)
		gp.channels.on('updateChannel', _callback_update_channel)
		gp.channels.on('error:updateChannel', _callback_update_channel_error)
		gp.channels.on("event:updateChannel", _callback_event_update_channel)
		gp.channels.on('deleteChannel', _callback_delete_channel)
		gp.channels.on('error:deleteChannel', _callback_delete_channel_error)
		gp.channels.on("fetchChannel", _callback_fetch_channel)
		gp.channels.on("error:fetchChannel", _callback_fetch_channel_error)
		gp.channels.on("fetchChannels", _callback_fetch_channels)
		gp.channels.on("error:fetchChannels", _callback_fetch_channels_error)
		gp.channels.on("openChat", _callback_open_chat)
		gp.channels.on("closeChat", _callback_close_chat)
		gp.channels.on("error:openChat", _callback_chat_error)
		gp.channels.on("join", _callback_join)
		gp.channels.on("error:join", _callback_join_error)
		gp.channels.on("event:join", _callback_event_join)
		gp.channels.on("event:joinRequest", _callback_event_join_request)
		gp.channels.on("leave", _callback_leave_successful)
		gp.channels.on("error:leave", _callback_leave_error)
		gp.channels.on("event:leave", _callback_leave_event)
		gp.channels.on("kick", _callback_kick_successful)
		gp.channels.on("error:kick", _callback_kick_error)
		gp.channels.on("fetchMembers", _callback_fetch_members)
		gp.channels.on("error:fetchMembers", _callback_fetch_members_error)
		gp.channels.on("fetchMoreMembers", _callback_fetch_more_members)
		gp.channels.on("error:fetchMoreMembers", _callback_fetch_more_members_error)
		gp.channels.on("mute", _callback_mute)
		gp.channels.on("error:mute", _callback_mute_error)
		gp.channels.on("event:mute", _callback_event_mute)
		gp.channels.on("unmute", _callback_unmute)
		gp.channels.on("error:unmute", _callback_error_unmute)
		gp.channels.on("event:unmute", _callback_event_unmute)
		gp.channels.on("sendInvite", _callback_send_invite)
		gp.channels.on("error:sendInvite", _callback_send_invite_error)
		gp.channels.on("event:invite", _callback_event_invite)
		gp.channels.on("acceptInvite", _callback_accept_invite)
		gp.channels.on("error:acceptInvite", _callback_error_accept_invite)
		gp.channels.on("rejectInvite", _callback_reject_invite)
		gp.channels.on("error:rejectInvite", _callback_error_reject_invite)
		gp.channels.on("fetchInvites", _callback_fetch_invites)
		gp.channels.on("error:fetchInvites", _callback_error_fetch_invites)
		gp.channels.on("fetchMoreInvites", _callback_fetch_more_invites)
		gp.channels.on("error:fetchMoreInvites", _callback_error_fetch_more_invites)
		gp.channels.on("fetchChannelInvites", _callback_fetch_channel_invites)
		gp.channels.on("error:fetchChannelInvites", _callback_error_fetch_channel_invites)
		gp.channels.on("fetchMoreChannelInvites", _callback_fetch_more_channel_invites)
		gp.channels.on("error:fetchMoreChannelInvites", _callback_error_fetch_more_channel_invites)
		gp.channels.on("fetchSentInvites", _callback_fetch_sent_invites)
		gp.channels.on("error:fetchSentInvites", _callback_error_fetch_sent_invites)
		gp.channels.on("fetchMoreSentInvites", _callback_fetch_more_sent_invites)
		gp.channels.on("error:fetchMoreSentInvites", _callback_error_fetch_more_sent_invites)
		
		
func join(channel_id:int, password:String="") -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		if password:
			conf["password"] = password
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


signal __fetch_messages(a:JavaScriptObject)

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
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_messages.emit(args[0]))
		gp.channels.fetchMessages(conf).then(callback)
		var result = await __fetch_messages
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
		

signal __fetch_personal_messages(a:JavaScriptObject)

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
		
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_personal_messages.emit(args[0]))
		gp.channels.fetchPersonalMessages(conf).then(callback)
		var result = await __fetch_personal_messages
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}


signal __fetch_feed_messages(a:JavaScriptObject)

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
		
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_feed_messages.emit(args[0]))
		gp.channels.fetchFeedMessages(conf).then(callback)
		var result = await __fetch_feed_messages
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
				
signal __fetch_more_messages(a:JavaScriptObject)

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
		
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more_messages.emit(args[0]))
		gp.channels.fetchMoreMessages(conf).then(callback)
		var result = await __fetch_more_messages
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		
		var canLoadMore: bool = result.canLoadMore
		return {"items": items, "can_load_more": canLoadMore}
	else:
		push_warning("Not running on Web")
		return {"items": null, "can_load_more": null}


signal __fetch_more_personal_messages(a:JavaScriptObject)
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
		
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more_personal_messages.emit(args[0]))
		gp.channels.fetchMorePersonalMessages(conf).then(callback)
		var result = await __fetch_more_personal_messages
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		
		var canLoadMore: bool = result.canLoadMore
		return {"items": items, "can_load_more": canLoadMore}
	else:
		push_warning("Not running on Web")
		return {"items": null, "can_load_more": null}


signal __fetch_more_feed_messages(a:JavaScriptObject)

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
		
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more_feed_messages.emit(args[0]))
		gp.channels.fetchMoreFeedMessages(conf).then(callback)
		var result = await __fetch_more_feed_messages
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		
		var canLoadMore: bool = result.canLoadMore
		return {"items": items, "can_load_more": canLoadMore}
	else:
		push_warning("Not running on Web")
		return {"items": null, "can_load_more": null}


func create_channel(channel:Channel) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf = channel._to_js()
		gp.channels.createChannel(conf)
	else:
		push_warning("Not running on Web")


func update_channel(channel:Channel) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf = channel._to_js()
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

signal __fetch_channel(a:JavaScriptObject)

func fetch_channel(channel_id:int) -> Channel:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_channel.emit(args[0]))
		gp.channels.fetchChannel(conf).then(callback)
		var response = await __fetch_channel
		return Channel.new()._from_js(response)
	else:
		push_warning("Not running on Web")
		return Channel.new()

signal __fetch_channels(a:JavaScriptObject)

func fetch_channels(ids: Array, tags: Array, search: String = "", only_joined: bool = true, only_owned: bool = true, limit: int = 100, offset: int = 0) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["ids"] = JavaScriptBridge.create_object("Array")
		for id in ids:
			conf["ids"].push(id)

		conf["tags"] = JavaScriptBridge.create_object("Array")
		for tag in tags:
			conf["tags"].push(tag)

		conf["search"] = search
		conf["onlyJoined"] = only_joined
		conf["onlyOwned"] = only_owned
		conf["limit"] = limit
		conf["offset"] = offset
		
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_channels.emit(args[0]))
		gp.channels.fetchChannels(conf).then(callback)
		var result = await __fetch_channels
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
		

signal __fetch_more_channels(a:JavaScriptObject)

func fetch_more_channels(channel_id: int, tags: Array, limit: int = 100) -> Dictionary:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		
		conf["limit"] = limit
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_channels.emit(args[0]))
		gp.channels.fetchMoreChannels(conf).then(callback)
		var result = await __fetch_channels
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(Message.new()._from_js(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}


func open_chat(channel_id: int = 0, tags: Array = []) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		# If a valid channel ID is provided, use it
		if channel_id > 0:
			conf["id"] = channel_id
		# Convert GDScript Array to JavaScript Array for tags if they are provided
		if tags.size() > 0:
			var js_tags := JavaScriptBridge.create_object("Array")
			for tag in tags:
				js_tags.push(tag)
			conf["tags"] = js_tags
		# Call the gp.channels.openChat with the config
		gp.channels.openChat(conf)
	else:
		push_warning("Not running on Web")

func is_main_chat_enabled() -> bool:
	if OS.get_name() == "Web":
		return gp.channels.isMainChatEnabled
	else:
		push_warning("Not running on Web")
		return false


func main_chat_id() -> int:
	if OS.get_name() == "Web":
		return gp.channels.mainChatId
	else:
		push_warning("Not running on Web")
		return 0


func open_personal_chat(player_id: int, tags: Array) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["playerId"] = player_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		# Open the personal chat using the GamePush API
		gp.channels.openPersonalChat(conf)
	else:
		push_warning("Not running on Web")

# Function to open a feed for a player
func open_feed(player_id: int, tags: Array) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["playerId"] = player_id
		# Convert GDScript Array to JavaScript Array
		var js_tags := JavaScriptBridge.create_object("Array")
		for tag in tags:
			js_tags.push(tag)
		conf["tags"] = js_tags
		# Open the feed using the GamePush API
		gp.channels.openFeed(conf)
	else:
		push_warning("Not running on Web")
		
		
func cancel_join(channel_id:int) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		gp.channels.cancelJoin(conf)
	else:
		push_warning("Not running on Web")
		
# Function to kick a player from a channel
func kick(channel_id: int, player_id: int) -> void:
	if OS.get_name() == "Web":
		# Create a JavaScript object to hold parameters
		var params := JavaScriptBridge.create_object("Object")
		params["channelId"] = channel_id
		params["playerId"] = player_id
		# Call the kick function with the JavaScript object
		gp.channels.kick(params)
	else:
		push_warning("Not running on Web")
		
# Function to fetch members of a channel
func fetch_members(channel_id: int, search: String = "", only_online: bool = true, limit: int = 100, offset: int = 0) -> void:
	if OS.get_name() == "Web":
		# Create a JavaScript object to hold parameters
		var params := JavaScriptBridge.create_object("Object")
		params["channelId"] = channel_id
		params["search"] = search
		params["onlyOnline"] = only_online
		params["limit"] = limit
		params["offset"] = offset
		# Call the fetchMembers function with the JavaScript object
		var response = await gp.channels.fetchMembers(params)
	else:
		push_warning("Not running on Web")
		
		
func fetch_more_members(channel_id: int, search: String = "", only_online: bool = true, limit: int = 100) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["search"] = search
		conf["onlyOnline"] = only_online
		conf["limit"] = limit
		
		var response = await gp.channels.fetchMoreMembers(conf)
	else:
		push_warning("Not running on Web")

	
func mute(channel_id: int, player_id: int, unmute_at: String) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["playerId"] = player_id
		conf["unmuteAt"] = unmute_at
		
		gp.channels.mute(conf)
	else:
		push_warning("Not running on Web")

func unmute(channel_id: int, player_id: int) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["playerId"] = player_id
		gp.channels.unmute(conf)
	else:
		push_warning("Not running on Web")


func send_invite(channel_id: int, player_id: int):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["playerId"] = player_id
		gp.channels.sendInvite(conf)
	else:
		push_warning("Not running on Web")

func cancel_invite(channel_id: int, player_id: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["playerId"] = player_id
		gp.channels.cancelInvite(conf)
	else:
		push_warning("Not running on Web")


func accept_invite(channel_id: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		gp.channels.acceptInvite(conf)
	else:
		push_warning("Not running on Web")

# Function to reject an invite
func reject_invite(channel_id: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		gp.channels.rejectInvite(conf)
	else:
		push_warning("Not running on Web")
		
		
signal __fetch_invites(a:JavaScriptObject)

func fetch_invites(limit: int, offset: int) -> Dictionary:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["limit"] = limit
		conf["offset"] = offset
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_invites.emit(args[0]))
		gp.channels.fetchInvites(conf).then(callback)
		var result = await __fetch_invites
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(GP._js_to_dict(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
				
signal __fetch_more_invites(a:JavaScriptObject)

func fetch_more_invites(limit: int) -> Dictionary:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["limit"] = limit
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more_invites.emit(args[0]))
		gp.channels.fetchMoreInvites(conf).then(callback)
		var result = await __fetch_more_invites
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(GP._js_to_dict(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
signal __fetch_channel_invites(a:JavaScriptObject)

func fetch_channel_invites(channel_id: int, limit: int, offset: int) -> Dictionary:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channel_id"] = channel_id
		conf["limit"] = limit
		conf["offset"] = offset
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_channel_invites.emit(args[0]))
		gp.channels.fetchChannelInvites(conf).then(callback)
		var result = await __fetch_channel_invites
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(GP._js_to_dict(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}

signal __fetch_more_channel_invites(a:JavaScriptObject)

func fetch_more_channel_invites(channel_id: int, limit: int) -> Dictionary:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channel_id"] = channel_id
		conf["limit"] = limit
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more_channel_invites.emit(args[0]))
		gp.channels.fetchMoreChannelInvites(conf).then(callback)
		var result = await __fetch_more_channel_invites
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(GP._js_to_dict(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
				
signal __fetch_sent_invites(a:JavaScriptObject)

func fetch_sent_invites(limit: int, offset: int) -> Dictionary:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["limit"] = limit
		conf["offset"] = offset
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_sent_invites.emit(args[0]))
		gp.channels.fetchSentInvites(conf).then(callback)
		var result = await __fetch_sent_invites
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(GP._js_to_dict(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
				
signal __fetch_more_sent_invites(a:JavaScriptObject)

func fetch_more_sent_invites(limit: int) -> Dictionary:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["limit"] = limit
		var callback := JavaScriptBridge.create_callback(func(args):
			__fetch_more_sent_invites.emit(args[0]))
		gp.channels.fetchMoreSentInvites(conf).then(callback)
		var result = await __fetch_more_sent_invites
		var items := []
		var callback2 := JavaScriptBridge.create_callback(func(args):
			items.append(GP._js_to_dict(args[0])))
		result.items.forEach(callback2)
		var canLoadMore:bool = result.canLoadMore
		return {"items": items, 
				"can_load_more": canLoadMore
				}
	else:
		push_warning("Not running on Web")
		return {"items": null, 
				"can_load_more": null
				}
				
				
func accept_join_request(channel_id: int, player_id: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["playerId"] = player_id
		gp.channels.acceptJoinRequest(conf)
	else:
		push_warning("Not on the web platform.")

# Reject a join request
func reject_join_request(channel_id: int, player_id: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["playerId"] = player_id
		gp.channels.rejectJoinRequest(conf)
	else:
		push_warning("Not on the web platform.")

# Fetch join requests
func fetch_join_requests(channel_id: int, limit: int, offset: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["limit"] = limit
		conf["offset"] = offset
		gp.channels.fetchJoinRequests(conf)
	else:
		push_warning("Not on the web platform.")

# Fetch more join requests
func fetch_more_join_requests(channel_id: int, limit: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["channelId"] = channel_id
		conf["limit"] = limit
		gp.channels.fetchMoreJoinRequests(conf)
	else:
		push_warning("Not on the web platform.")

# Fetch sent join requests
func fetch_sent_join_requests(limit: int, offset: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["offset"] = offset
		conf["limit"] = limit
		gp.channels.fetchSentJoinRequests(conf)
	else:
		push_warning("Not on the web platform.")

# Fetch more sent join requests
func fetch_more_sent_join_requests(limit: int) -> void:
	if OS.get_name() == "Web":
		var conf = JavaScriptBridge.create_object("Object")
		conf["limit"] = limit
		gp.channels.fetchMoreSentJoinRequests(conf)
	else:
		push_warning("Not on the web platform.")
		
				
func _event_message(args):
	var message = Message.new()
	message._from_js(args[0])  
	event_message.emit(message)
	
	
func _message_send(args) -> void:
	var message = Message.new()
	message._from_js(args[0])  
	message_received.emit(message) 


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
func _on_delete_channel(args) -> void:
	channel_deleted.emit()
	
	
func _on_delete_channel_error(args) -> void:
	channel_deleted.emit(args[0])
	
func _on_event_delete_channel(args) -> void:
	var channel = Channel.new()
	channel._from_js(args[0])
	channel_updated.emit(channel)

# Handling successful channel fetch
func _on_fetch_channel(args) -> void:
	channel_fetched.emit(Channel.new()._from_js(args[0]))
	
func _on_fetch_channel_error(args) -> void:
	fetch_channel_error.emit(args[0])

# Handling successful channel fetch
func _on_fetch_channels(args) -> void:
	var channels := []
	for ch_data in args[0].items:
		channels.append(Channel.new()._from_js(ch_data))
	emit_signal("channels_fetched", channels, args[0].canLoadMore)

# Handling error during channel fetch
func _on_fetch_channels_error(args) -> void:
	emit_signal("fetch_channels_error", args[0])
	
# Handling successful fetch of more channels
func _on_fetch_more_channels(args) -> void:
	var channels := []
	for ch_data in args[0].items:
		channels.append(Channel.new()._from_js(ch_data))
	var can_load_more: bool = args[0].canLoadMore
	emit_signal("more_channels_fetched", channels, can_load_more)
	
# Handling error during fetch of more channels
func _on_fetch_more_channels_error(args) -> void:
	emit_signal("fetch_more_channels_error", args[0])

# Handling successful chat opening
func _on_open_chat(args) -> void:
	emit_signal("chat_opened")

# Handling chat closure
func _on_close_chat(args) -> void:
	emit_signal("chat_closed")

# Handling errors during chat opening
func _on_chat_error(args) -> void:
	emit_signal("chat_error", args[0])

# Function to handle successful join
func _on_join(args) -> void:
	joined.emit()
	
func _on_join_error(args) -> void:
	error_join.emit(args[0])
	
func _on_event_join(args) -> void:
	var member = args[0]  # Get member data
	var result = {}
	result["channel_id"] = member.channelId
	result["id"] = member.id
	result["state"] = member.state
	result["mute"] = member.mute
	event_joined.emit(result)
	
func _on_event_join_request(args) -> void:
	var join_request = args[0]  # Get the join request data
	var result = {}
	result["channel_id"] = join_request.channelId
	result["id"] = join_request.id
	result["state"] = join_request.state
	result["mute"] = join_request.mute
	emit_signal("join_request_received", result)
	
# Cancel join successful event handler
func _on_cancel_join_success(args) -> void:
	emit_signal("cancel_join_success")  # Emit signal for successful cancellation

# Cancel join error event handler
func _on_cancel_join_error(args) -> void:
	emit_signal("cancel_join_error", args[0])  # Emit error data

# Cancel join event handler
func _on_cancel_join_event(args) -> void:
	var join_request = args[0]  # Join request data
	var result = {}
	result["channel_id"] = join_request.channelId
	result["player_id"] = join_request.playerId
	emit_signal("cancel_join_event", result)  # Emit cancellation data
	
# Leave successful event handler
func _on_leave_successful(args) -> void:
	emit_signal("leave_successful")  # Emit signal for successful leave

# Leave error event handler
func _on_leave_error(args) -> void:
	emit_signal("leave_error", args[0])  # Emit error data

# Leave event handler
func _on_leave_event(args) -> void:
	var member = args[0]  # Member data from leave event
	var result = {}
	result["channel_id"] = member.channelId
	result["player_id"] = member.playerId
	result["reason"] = member.reason
	emit_signal("leave_event", result)  # Emit leave event data
	
# Kick successful event handler
func _on_kick_successful(args) -> void:
	emit_signal("kick_successful")  # Emit signal for successful kick

# Kick error event handler
func _on_kick_error(args) -> void:
	emit_signal("kick_error", args[0])  # Emit error data
	
func _on_fetch_members(args) -> void:
	var result = args[0]  # Extract the result from the event arguments
	var members_array: Array = []
	# Process each member in the result
	for member_data in result.items:
		var member = Member.new()._from_js(member_data)
		members_array.append(member)
	# Check if more members can be loaded
	var can_load_more :bool = result.canLoadMore
	# Emit the members fetched signal with the array of members
	emit_signal("members_fetched", members_array, can_load_more)
		
func _on_fetch_members_error(args) -> void:
	emit_signal("fetch_members_error", args[0])

func _on_fetch_more_members(args) -> void:
	var members = []
	for member in args[0].items:
		members.append(Member.new()._from_js(member))
	emit_signal("fetch_more_members_success", members, args[0].canLoadMore)

func _on_fetch_more_members_error(args) -> void:
	emit_signal("fetch_more_members_error", args[0])

func _on_mute(result) -> void:
	emit_signal("mute_success")

func _on_mute_error(args) -> void:
	emit_signal("mute_error", args[0])

func _on_event_mute(args) -> void:
	var mute = Mute.new()._from_js(args[0])
	emit_signal("event_mute", mute)

func _on_unmute(args) -> void:
	emit_signal("unmute_success")

func _on_error_unmute(args) -> void:
	emit_signal("unmute_error", args[0])

func _on_event_unmute(args) -> void:
	var mute_info = {
		"channel_id": args[0]["channelId"],
		"player_id": args[0]["playerId"]
	}
	# Handle the unmute event as needed
	event_unmute.emit(mute_info)


func _on_send_invite(args) -> void:
	sent_invite.emit()


func _on_send_invite_error(args) -> void:
	sent_invite_error.emit(args[0])


func _on_event_invite(args) -> void:
	event_invite.emit(GP._js_to_dict(args[0]))
	

func _on_cancel_invite(args) -> void:
	canceled_invite.emit()


func _on_cancel_invite_error(args) -> void:
	cancel_invite_error.emit(args[0])


func _on_event_cancel_invite(args) -> void:
	event_cancel_invite.emit(GP._js_to_dict(args[0]))


func _on_accept_invite(args) -> void:
	accepted_invite.emit()


func _on_error_accept_invite(args) -> void:
	error_accept_invite.emit(args[0])
	

func _on_reject_invite(args) -> void:
	rejected_invite.emit()


func _on_error_reject_invite(args) -> void:
	error_reject_invite.emit(args[0])


func _on_event_reject_invite(args) -> void:
	event_reject_invite.emit(GP._js_to_dict(args[0]))

func _on_fetch_invites(args) -> void:
	fetched_invites.emit(GP._js_to_dict(args[0]))

func _on_error_fetch_invites(args) -> void:
	error_fetch_invites.emit(args[0])
	
func _on_fetch_more_invites(args) -> void:
	fetched_more_invites.emit(GP._js_to_dict(args[0]))

func _on_error_fetch_more_invites(args) -> void:
	error_fetch_more_invites.emit(args[0])


func _on_fetch_channel_invites(args) -> void:
	fetched_channel_invites.emit(GP._js_to_dict(args[0]))

func _on_error_fetch_channel_invites(args) -> void:
	error_fetch_channel_invites.emit(args[0])
	
func _on_fetch_more_channel_invites(args) -> void:
	fetched_more_channel_invites.emit(GP._js_to_dict(args[0]))

func _on_error_fetch_more_channel_invites(args) -> void:
	error_fetch_more_channel_invites.emit(args[0])
	
func _on_fetch_sent_invites(args) -> void:
	fetched_sent_invites.emit(GP._js_to_dict(args[0]))

func _on_error_fetch_sent_invites(args) -> void:
	error_fetch_sent_invites.emit(args[0])
	
func _on_fetch_more_sent_invites(args) -> void:
	fetched_more_sent_invites.emit(GP._js_to_dict(args[0]))

func _on_error_fetch_more_sent_invites(args) -> void:
	error_fetch_more_sent_invites.emit(args[0])
	
	
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
		var callback_tags := JavaScriptBridge.create_callback(func(args):
			tags.append(args[0]))
		js_object["tags"].forEach(callback_tags)
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
		var callback_tags := JavaScriptBridge.create_callback(func(args):
			tags.append(args[0]))
		js_object["tags"].forEach(callback_tags)
		message_tags = []
		var callback_message_tags := JavaScriptBridge.create_callback(func(args):
			message_tags.append(args[0]))
		js_object["messageTags"].forEach(callback_message_tags)
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
		
class Member:
	var id: int
	var is_online: bool
	var state: Player
	var mute: Mute

	# Method to convert from JS object to Member instance
	func _from_js(js_object: JavaScriptObject) -> Member:
		self.id = js_object.id
		self.is_online = js_object.isOnline
		self.state = Player.new()._from_js(js_object.state)
		self.mute = Mute.new()._from_js(js_object.mute)
		return self
	
	func _to_js() -> JavaScriptObject:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["isOnline"] = is_online
		js_object["state"] = state._to_js()
		js_object["mute"] = mute._to_js()
		return js_object

class Mute:
	var is_muted: bool
	var unmute_at: String

	# Method to populate Mute from a JavaScript object
	func _from_js(js_object: JavaScriptObject) -> Mute:
		is_muted = js_object.isMuted
		unmute_at = js_object.unmuteAt
		return self

	# Method to convert Mute to a JavaScript object
	func _to_js() -> JavaScriptObject:
		var js_object := JavaScriptBridge.create_object("Object")
		js_object["isMuted"] = is_muted
		js_object["unmuteAt"] = unmute_at
		return js_object
