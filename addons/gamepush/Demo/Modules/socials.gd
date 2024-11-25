extends Control

@onready var url_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/url"
@onready var text_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/text"
@onready var image_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/image"
@onready var from_id_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/from_id"
@onready var gift_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/gift"
@onready var param_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/param"


func _ready():
	GP.Socials.invited.connect(func(s): GP.Logger.info("invite", s))
	GP.Socials.shared.connect(func(s): GP.Logger.info("share", s))
	GP.Socials.posted.connect(func(s): GP.Logger.info("poste", s))
	GP.Socials.joined_community.connect(func(s): GP.Logger.info("join_community", s))


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_is_supports_share_pressed():
	GP.Logger.info(GP.Socials.is_supports_share())


func _on_is_supports_native_share_pressed():
	GP.Logger.info(GP.Socials.is_supports_native_share())


func _on_share_pressed():
	GP.Socials.share(text_node.text, url_node.text, image_node.text)



func _on_is_supports_native_posts_pressed():
	GP.Logger.info(GP.Socials.is_supports_native_posts())


func _on_post_pressed():
	GP.Socials.post(text_node.text, url_node.text, image_node.text)


func _on_is_supports_native_invite_pressed():
	GP.Logger.info(GP.Socials.is_supports_native_invite())


func _on_invite_pressed():
	GP.Socials.invite(text_node.text)


func _on_can_join_community_pressed():
	GP.Logger.info(GP.Socials.can_join_community())


func _on_is_supports_native_community_join_pressed():
	GP.Logger.info(GP.Socials.is_supports_native_community_join())



func _on_join_community_pressed():
	GP.Socials.join_community()


func _on_make_share_url_pressed():
	var dict = {"fromId": from_id_node.text, "gift": gift_node.text}
	GP.Logger.info(GP.Socials.make_share_url(dict))


func _on_get_share_param_pressed():
	GP.Logger.info(GP.Socials.get_share_param(param_node.text))


func _on_is_supports_share_params_pressed() -> void:
	GP.Logger.info(GP.Socials.is_supports_share_params())
