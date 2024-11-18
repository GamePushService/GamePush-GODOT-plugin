extends Control

@onready var channel_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/channel_id"
@onready var text_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/text"
@onready var tag1_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag1"
@onready var tag2_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag2"
@onready var tag3_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/tag3"
@onready var message_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/message_id"
@onready var limit_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/limit"
@onready var offset_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/offset"
@onready var player_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/player_id"
@onready var template_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/template"
@onready var capacity_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/capacity"
@onready var name_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/name"
@onready var description_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/description"
@onready var search_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/search"


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Channels.event_message.connect(func(message): GP.Logger.info("event_message", message.to_dict()))
	GP.Channels.message_received.connect(func(message): GP.Logger.info("message_received", message.to_dict()))
	GP.Channels.message_sent.connect(func(message): GP.Logger.info("message_sent", message.to_dict()))
	GP.Channels.message_error.connect(func(error): GP.Logger.info("message_error", error))
	GP.Channels.message_edited.connect(func(message): GP.Logger.info("message_edited", message.to_dict()))
	GP.Channels.error_edit_message.connect(func(error): GP.Logger.info("error_edit_message", error))
	GP.Channels.event_edit_message.connect(func(message): GP.Logger.info("event_edit_message", message.to_dict()))
	GP.Channels.message_deleted.connect(func(message): GP.Logger.info("message_deleted", message.to_dict()))
	GP.Channels.event_delete_message.connect(func(message): GP.Logger.info("event_delete_message", message.to_dict()))
	GP.Channels.messages_fetched.connect(func(result): GP.Logger.info("messages_fetched", result))
	GP.Channels.error_delete_message.connect(func(err): GP.Logger.info("error_delete_message", err))
	GP.Channels.messages_fetched.connect(func(result): GP.Logger.info("messages_fetched", result))
	GP.Channels.error_fetch_messages.connect(func(err): GP.Logger.info("error_fetch_messages", err))
	GP.Channels.fetched_more_messages.connect(func(result): GP.Logger.info("fetched_more_messages", result))
	GP.Channels.error_fetch_more_messages.connect(func(err): GP.Logger.info("error_fetch_more_messages", err))
	GP.Channels.channel_created.connect(func(channel): GP.Logger.info("channel_created", channel.to_dict()))
	GP.Channels.error_create_channel.connect(func(err): GP.Logger.info("error_create_channel", err))
	GP.Channels.channel_updated.connect(func(channel): GP.Logger.info("channel_updated", channel.to_dict()))
	GP.Channels.error_update_channel.connect(func(err): GP.Logger.info("error_update_channel", err))
	GP.Channels.channel_deleted.connect(func(success): GP.Logger.info("channel_deleted, success", success))
	GP.Channels.error_delete_channel.connect(func(err): GP.Logger.info("error_delete_channel", err))
	GP.Channels.event_channel_updated.connect(func(channel): GP.Logger.info("event_channel_updated", channel.to_dict()))
	GP.Channels.event_channel_deleted.connect(func(channel_id): GP.Logger.info("event_channel_deleted", channel_id))
	GP.Channels.channel_fetched.connect(func(channel): GP.Logger.info("channel_fetched", channel.to_dict()))
	GP.Channels.fetch_channel_error.connect(func(err): GP.Logger.info("fetch_channel_error", err))
	GP.Channels.channels_fetched.connect(func(channels, can_load_more):
		var res := []
		for c in channels:
			res.append(c.to_dict())
		GP.Logger.info("channels_fetched", res, can_load_more))
	GP.Channels.fetch_channels_error.connect(func(err): GP.Logger.info("fetch_channels_error", err))
	GP.Channels.more_channels_fetched.connect(func(channels, can_load_more): 
		var res := []
		for c in channels:
			res.append(c.to_dict())
		GP.Logger.info("more_channels_fetched", res, can_load_more))
	GP.Channels.fetch_more_channels_error.connect(func(err): GP.Logger.info("fetch_more_channels_error", err))
	GP.Channels.chat_opened.connect(func(): GP.Logger.info("chat_opened"))
	GP.Channels.chat_closed.connect(func(): GP.Logger.info("chat_closed"))
	GP.Channels.chat_error.connect(func(err): GP.Logger.info("chat_error", err))
	GP.Channels.joined.connect(func(): GP.Logger.info("joined"))
	GP.Channels.error_join.connect(func(err): GP.Logger.info("error_join", err))
	GP.Channels.event_joined.connect(func(member): GP.Logger.info("event_joined", member))
	GP.Channels.join_request_received.connect(func(join_request): GP.Logger.info("event_joined", join_request))
	GP.Channels.cancel_joined.connect(func(): GP.Logger.info("cancel_joined"))
	GP.Channels.cancel_join_error.connect(func(err): GP.Logger.info("cancel_join_error", err))
	GP.Channels.event_cancel_join.connect(func(join_request): GP.Logger.info("event_cancel_join", join_request))
	GP.Channels.leave_successful.connect(func(): GP.Logger.info("leave_successful"))
	GP.Channels.leave_error.connect(func(err): GP.Logger.info("leave_error", err))
	GP.Channels.leave_event.connect(func(member): GP.Logger.info("leave_event", member))
	GP.Channels.kick_successful.connect(func(): GP.Logger.info("kick_successful"))
	GP.Channels.kick_error.connect(func(err): GP.Logger.info("kick_error", err))
	GP.Channels.leave_event.connect(func(member): GP.Logger.info("leave_event", member))
	GP.Channels.members_fetched.connect(func(members, can_load_more): 
		var membs := []
		for m in members:
			membs.append(m.to_dict())
		GP.Logger.info("members_fetched", membs, "can_load_more:", can_load_more))
	GP.Channels.fetch_members_error.connect(func(err): GP.Logger.info("fetch_members_error", err))
	GP.Channels.fetch_more_members_success.connect(func(members, can_load_more): GP.Logger.info("fetch_more_members_success", members, "can_load_more:", can_load_more))
	GP.Channels.fetch_more_members_error.connect(func(err): GP.Logger.info("fetch_more_members_error", err))
	GP.Channels.mute_success.connect(func(): GP.Logger.info("mute_success"))
	GP.Channels.mute_error.connect(func(err): GP.Logger.info("mute_error", err))
	GP.Channels.event_mute.connect(func(mute): GP.Logger.info("event_mute", mute.to_dict()))
	GP.Channels.unmute_success.connect(func(): GP.Logger.info("unmute_success"))
	GP.Channels.unmute_error.connect(func(err): GP.Logger.info("unmute_error", err))
	GP.Channels.event_unmute.connect(func(unmute): GP.Logger.info("event_unmute", unmute))
	GP.Channels.sent_invite.connect(func(): GP.Logger.info("sent_invite"))
	GP.Channels.sent_invite_error.connect(func(err): GP.Logger.info("sent_invite_error", err))
	GP.Channels.event_invite.connect(func(invite): GP.Logger.info("event_invite", invite))
	GP.Channels.canceled_invite.connect(func(): GP.Logger.info("canceled_invite"))
	GP.Channels.cancel_invite_error.connect(func(err): GP.Logger.info("cancel_invite_error", err))
	GP.Channels.event_cancel_invite.connect(func(invite): GP.Logger.info("event_cancel_invite", invite))
	GP.Channels.accepted_invite.connect(func(): GP.Logger.info("accepted_invite"))
	GP.Channels.error_accept_invite.connect(func(err): GP.Logger.info("error_accept_invite", err))
	GP.Channels.rejected_invite.connect(func(): GP.Logger.info("rejected_invite"))
	GP.Channels.error_reject_invite.connect(func(err): GP.Logger.info("error_reject_invite", err))
	GP.Channels.event_reject_invite.connect(func(invite): GP.Logger.info("event_reject_invite", invite))
	GP.Channels.fetched_invites.connect(func(result): GP.Logger.info("fetched_invites", result))
	GP.Channels.error_fetch_invites.connect(func(err): GP.Logger.info("error_fetch_invites", err))
	GP.Channels.fetched_more_invites.connect(func(result): GP.Logger.info("fetched_more_invites", result))
	GP.Channels.error_fetch_more_invites.connect(func(err): GP.Logger.info("error_fetch_more_invites", err))
	GP.Channels.fetched_channel_invites.connect(func(result): GP.Logger.info("fetched_channel_invites", result))
	GP.Channels.error_fetch_channel_invites.connect(func(err): GP.Logger.info("error_fetch_channel_invites", err))
	GP.Channels.fetched_more_channel_invites.connect(func(result): GP.Logger.info("fetched_more_channel_invites", result))
	GP.Channels.error_fetch_more_channel_invites.connect(func(err): GP.Logger.info("error_fetch_more_channel_invites", err))
	GP.Channels.fetched_sent_invites.connect(func(result): GP.Logger.info("fetched_sent_invites", result))
	GP.Channels.error_fetch_sent_invites.connect(func(err): GP.Logger.info("error_fetch_sent_invites", err))
	GP.Channels.fetched_more_sent_invites.connect(func(result): GP.Logger.info("fetched_more_sent_invites", result))
	GP.Channels.error_fetch_more_sent_invites.connect(func(err): GP.Logger.info("error_fetch_more_sent_invites", err))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")

#region Panel1

func _on_join_pressed():
	GP.Channels.join(int(channel_id_node.text))


func _on_leave_pressed():
	GP.Channels.leave(int(channel_id_node.text))


func _on_send_message_pressed():
	GP.Channels.send_message(int(channel_id_node.text), text_node.text)
#endregion

#region channels 

func _on_create_channel_pressed():
	var channel := {}
	channel["template"] = template_node.text
	var tags := []
	if tag1_node.text:
		tags.append(tag1_node.text)
	if tag2_node.text:
		tags.append(tag2_node.text)
	if tag3_node.text:
		tags.append(tag3_node.text)
	if tags:
		channel.tags = tags
	if capacity_node.text:
		channel.capacity = int(capacity_node.text)
	if name_node.text:
		channel.name = name_node.text
	if description_node.text:
		channel.description = description_node.text
	channel["private"] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/private.button_pressed
	channel["visible"] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/visible.button_pressed
	channel["password"] = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/password.text
	GP.Channels.create_channel(channel)


func _on_update_channel_pressed():
	var channel := {}
	channel.channel_id = int(channel_id_node.text)
	var tags := []
	if tag1_node.text:
		tags.append(tag1_node.text)
	if tag2_node.text:
		tags.append(tag2_node.text)
	if tag3_node.text:
		tags.append(tag3_node.text)
	if tags:
		channel.tags = tags
	if capacity_node.text:
		channel.capacity = int(capacity_node.text)
	if name_node.text:
		channel.name = name_node.text
	if description_node.text:
		channel.description = description_node.text
	channel.private = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/private.button_pressed
	channel.visible = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/visible.button_pressed
	channel.password = $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/password.text
	if $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/owner_id.text:
		channel.owner_id = int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/owner_id.text)
	GP.Channels.update_channel(channel)


func _on_delete_channel_pressed():
	GP.Channels.delete_channel(int(channel_id_node.text))


func _on_fetch_channel_pressed():
	GP.Channels.fetch_channel(int(channel_id_node.text))


func _on_fetch_channels_pressed():
	GP.Channels.fetch_channels([int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/ids.text),
	 int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/ids2.text),
	 int($MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/ids3.text) ],
	 [tag1_node.text, tag2_node.text, tag3_node.text], search_node.text, $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/onlyJoined.button_pressed,
	 $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/onlyOwned.button_pressed, int(limit_node.text), int(offset_node.text))



func _on_fetch_more_channels_pressed():
	GP.Channels.fetch_more_channels(int(channel_id_node.text), [tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))
#endregion

#region chats

func _on_open_chat_pressed():
		
	GP.Channels.open_chat(int(channel_id_node.text),
	 [tag1_node.text, tag2_node.text, tag3_node.text])


func _on_is_main_chat_enabled_pressed():
	GP.Logger.info(GP.Channels.is_main_chat_enabled())


func _on_main_chat_id_pressed():
	GP.Logger.info(GP.Channels.main_chat_id())


func _on_open_personal_chat_pressed():
	GP.Channels.open_personal_chat(int(player_id_node.text), 
	[tag1_node.text, tag2_node.text, tag3_node.text])


func _on_open_feed_pressed():
	GP.Channels.open_feed(int(player_id_node.text), 
	[tag1_node.text, tag2_node.text, tag3_node.text])
#endregion

#region Members


func _on_cancel_join_pressed():
	GP.Channels.cancel_join(int(channel_id_node.text))


func _on_kick_pressed():
	GP.Channels.kick(int(channel_id_node.text), int(player_id_node.text))


func _on_fetch_members_pressed():
	GP.Channels.fetch_members(int(channel_id_node.text))


func _on_fetch_more_members_pressed():
	GP.Channels.fetch_more_members(int(channel_id_node.text))


func _on_mute_pressed():
	GP.Channels.mute(int(channel_id_node.text), int(player_id_node.text))


func _on_unmute_pressed():
	GP.Channels.unmute(int(channel_id_node.text), int(player_id_node.text))

#endregion

#region messages

func _on_send_personal_message_2_pressed():
	GP.Channels.send_personal_message(int(player_id_node.text), text_node.text,
	[tag1_node.text, tag2_node.text, tag3_node.text])


func _on_send_feed_message_pressed():
	GP.Channels.send_feed_message(int(player_id_node.text), text_node.text,
	[tag1_node.text, tag2_node.text, tag3_node.text])


func _on_edit_message_pressed():
	GP.Channels.edit_message(message_id_node.text, text_node.text)


func _on_delete_message_pressed():
	GP.Channels.delete_message(message_id_node.text)


func _on_fetch_messages_pressed():
	GP.Channels.fetch_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text), int(offset_node.text))


func _on_fetch_personal_messages_pressed():
	GP.Channels.fetch_personal_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))


func _on_fetch_feed_messages_pressed():
	GP.Channels.fetch_feed_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text), int(offset_node.text))


func _on_fetch_more_messages_pressed():
	GP.Channels.fetch_more_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))


func _on_fetch_more_personal_messages_pressed():
	GP.Channels.fetch_more_personal_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))


func _on_fetch_more_feed_messages_pressed():
		GP.Channels.fetch_more_feed_messages(int(channel_id_node.text),
	[tag1_node.text, tag2_node.text, tag3_node.text], int(limit_node.text))
	
#endregion

#region Invites

func _on_send_invite_pressed():
	GP.Channels.send_invite(int(channel_id_node.text), int(player_id_node.text))


func _on_cancel_invite_pressed():
	GP.Channels.cancel_invite(int(channel_id_node.text), int(player_id_node.text))


func _on_accept_invite_pressed():
	GP.Channels.accept_invite(int(channel_id_node.text))


func _on_reject_invite_pressed():
	GP.Channels.reject_invite(int(channel_id_node.text))


func _on_fetch_invites_pressed():
	GP.Channels.fetch_invites(int(limit_node.text), int(offset_node.text))


func _on_fetch_more_invites_pressed():
	GP.Channels.fetch_more_invites(int(limit_node.text))


func _on_fetch_channel_invites_pressed():
	GP.Channels.fetch_channel_invites(int(channel_id_node.text), int(limit_node.text), int(offset_node.text))


func _on_fetch_more_channel_invites_pressed():
	GP.Channels.fetch_more_channel_invites(int(channel_id_node.text), int(limit_node.text))


func _on_fetch_sent_invites_pressed():
	GP.Channels.fetch_sent_invites(int(limit_node.text), int(offset_node.text))


func _on_fetch_more_sent_invites_pressed():
	GP.Channels.fetch_more_sent_invites(int(limit_node.text))
#endregion

#region Requests

func _on_accept_join_request_pressed():
	GP.Channels.accept_join_request(int(channel_id_node.text), int(player_id_node.text))


func _on_reject_join_request_pressed():
	GP.Channels.reject_join_request(int(channel_id_node.text), int(player_id_node.text))


func _on_fetch_join_requests_pressed():
	GP.Channels.fetch_join_requests(int(channel_id_node.text), int(limit_node.text), int(offset_node.text))


func _on_fetch_more_join_requests_pressed():
	GP.Channels.fetch_more_join_requests(int(channel_id_node.text), int(limit_node.text))


func _on_fetch_sent_join_requests_pressed():
	GP.Channels.fetch_sent_join_requests(int(limit_node.text), int(offset_node.text))


func _on_fetch_more_sent_join_requests_pressed():
	GP.Channels.fetch_more_sent_join_requests(int(limit_node.text))
	
#endregion
