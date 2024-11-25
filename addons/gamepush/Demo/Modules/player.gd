extends Control

@onready var key_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/Header#KeyInput"
@onready var value_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/Header#ValueInput"
@onready var override := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/override
@onready var storage := $MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/storage
@onready var interval_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/interval"

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		var ulr_avatar = GP.Player.get_avatar()
		GP.Logger.info(ulr_avatar)
		var request = HTTPRequest.new()
		add_child(request)
		request.request_completed.connect(_request_completed)
		request.request(ulr_avatar)
		$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/IDLabel.text = "ID: " + str(GP.Player.get_id())
		$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/NameLabel.text = "NAME: " + str(GP.Player.get_player_name())
		
		
		GP.Player.fields_fetched.connect(func(success): GP.Logger.info("fields fetched, success:", success))
		GP.Player.synced.connect(func(success): GP.Logger.info("synced, success:", success))
		GP.Player.loaded.connect(func(success): GP.Logger.info("loaded, success:", success))
		GP.Player.logged_in.connect(func(success): GP.Logger.info("logged_in, success:", success))
		GP.Player.logged_out.connect(func(success): GP.Logger.info("logged_out, success:", success))
		GP.Player.window_connected.connect(func(): GP.Logger.info("window_connected"))
		GP.Player.player_state_changed.connect(func(): GP.Logger.info("player_state_changed"))
		GP.Player.field_maximum_reached.connect(func(field): GP.Logger.info("field_maximum_reached", field.to_dict()))
		GP.Player.field_minimum_reached.connect(func(field): GP.Logger.info("field_minimum_reached", field.to_dict()))
		GP.Player.field_incremented.connect(func(field, old_value, new_value): GP.Logger.info("field_incremented", field.to_dict(), old_value, new_value))


func _request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	if response_code == 200:
		var img := Image.new()
		var err := img.load_png_from_buffer(body)
		if err == OK:
			var image_text := ImageTexture.create_from_image(img)
			$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/Avatar.texture = image_text


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_button_grid_get_id_button_pressed():
	GP.Logger.info(GP.Player.get_id())


func _on_button_grid_get_score_button_pressed():
	GP.Logger.info(GP.Player.get_score())


func _on_button_grid_login_button_pressed():
	GP.Player.login()


func _on_button_grid_sync_button_pressed():
	GP.Player.sync(override.button_pressed, storage.get_item_text(storage.selected))


func _on_button_grid_get_name_pressed():
	GP.Logger.info(GP.Player.get_player_name())


func _on_button_grid_get_avatar_pressed():
	GP.Logger.info(GP.Player.get_avatar())


func _on_button_grid_is_stub_pressed():
	GP.Logger.info(GP.Player.is_stub())


func _on_button_gridis_logged_in_pressed():
	GP.Logger.info(GP.Player.is_logged_in())


func _on_button_gridhas_any_credentials_pressed():
	GP.Logger.info(GP.Player.has_any_credentials())



func _on_button_gridenable_auto_sync_pressed():
	GP.Player.enable_auto_sync(int(interval_node.text), storage.text)


func _on_button_griddisable_auto_sync_pressed():
	GP.Player.disable_auto_sync(storage.text)


func _on_button_gridload_pressed():
	GP.Player.load()


func _on_button_gridlogout_pressed():
	GP.Player.logout()


func _on_button_gridfetch_fields_pressed():
	GP.Player.fetch_fields()


func _on_button_gridget_value_pressed():
	GP.Logger.info(GP.Player.get_value(key_node.text))


func _on_button_gridset_value_pressed():
	GP.Player.set_value(key_node.text, value_node.text)


func _on_button_gridadd_value_pressed():
	GP.Player.add_value(key_node.text, value_node.text)


func _on_button_gridtoggle_pressed():
	GP.Player.toggle(key_node.text)


func _on_button_gridhas_pressed():
	GP.Logger.info(GP.Player.has(key_node.text))


func _on_button_gridreset_pressed():
	GP.Player.reset()


func _on_button_gridremove_pressed():
	GP.Player.remove()


func _on_button_gridget_min_value_pressed():
	GP.Logger.info(GP.Player.get_min_value(key_node.text))


func _on_button_gridset_min_value_pressed():
	GP.Player.set_min_value(key_node.text, value_node.text)


func _on_button_gridget_max_value_pressed():
	GP.Logger.info(GP.Player.get_max_value(key_node.text))


func _on_button_gridset_max_value_pressed():
	GP.Player.set_max_value(key_node.text, value_node.text)


func _on_button_gridget_active_days_pressed():
	GP.Logger.info(GP.Player.get_active_days())


func _on_button_gridget_active_days_consecutive_pressed():
	GP.Logger.info(GP.Player.get_active_days_consecutive())
	

func _on_button_gridget_playtime_today_pressed():
	GP.Logger.info(GP.Player.get_playtime_today())


func _on_button_gridget_playtime_all_pressed():
	GP.Logger.info(GP.Player.get_playtime_all())


func _on_button_gridget_field_pressed():
	var field := GP.Player.get_field(key_node.text)
	GP.Logger.info(field.to_dict())


func _on_button_gridget_field_name_pressed():
	GP.Logger.info(GP.Player.get_field_name(key_node.text))


func _on_button_gridget_field_variant_name_pressed():
	GP.Logger.info(GP.Player.get_field_variant_name(key_node.text, value_node.text))


func _on_to_dict_pressed() -> void:
	GP.Logger.info(GP.Player.to_dict())


func _on_get_fileds_pressed() -> void:
	var res := []
	for f in GP.Player.get_fields():
		res.append(f.to_dict())
	GP.Logger.info(res)
