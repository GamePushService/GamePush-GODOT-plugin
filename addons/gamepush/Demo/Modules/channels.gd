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
	GP.Channels.event_message.connect(func(arg): GP.Logger.info("event_message", arg))


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
	var channel := GP.Channels.Channel.new()
	channel.id = int(channel_id_node.text)
	channel.template_id = "test"
	GP.Channels.create_channel(channel)


func _on_update_channel_pressed():
	var channel := GP.Channels.Channel.new()
	channel.id = int(channel_id_node.text)
	channel.template_id = "test"
	GP.Channels.update_channel(channel)


func _on_delete_channel_pressed():
	GP.Channels.delete_channel(int(channel_id_node.text))


func _on_fetch_channel_pressed():
	GP.Channels.fetch_channel(int(channel_id_node.text))


func _on_fetch_channels_pressed():
	GP.Channels.fetch_channels([int(channel_id_node.text)], [tag1_node.text, tag2_node.text, tag3_node.text], search_node.text,)



func _on_fetch_more_channels_pressed():
	GP.Channels.fetch_more_channels(int(channel_id_node.text), [tag1_node.text, tag2_node.text, tag3_node.text])
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
	GP.Channels.mute(int(channel_id_node.text), int(player_id_node.text), "")


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
