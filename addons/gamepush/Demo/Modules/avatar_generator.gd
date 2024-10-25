extends Control

@onready var size_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/size_input"
@onready var hash_node := $"MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/Has_input"


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")
	

func _on_current_pressed():
	GP.Logger.info(GP.AvatarGenerator.current())


func _on_generate_pressed():
	var url_avatar = GP.AvatarGenerator.generate_avatar(hash_node.text, int(size_node.text))
	GP.Logger.info(url_avatar)
	var request = HTTPRequest.new()
	add_child(request)
	request.request_completed.connect(_request_completed)
	request.request(url_avatar)
	
	
func _request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	if response_code == 200:
		var img := Image.new()
		var err := img.load_png_from_buffer(body)
		if err == OK:
			var image_text := ImageTexture.create_from_image(img)
			$MarginContainer/HBoxContainer/Panel/VBoxContainer/Header/Avatar.texture = image_text
