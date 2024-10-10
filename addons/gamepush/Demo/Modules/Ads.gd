extends Control

func _ready():
	GP.Ads.start.connect(_on_signal_start)
	GP.Ads.close.connect(_on_signal_close)


func _on_is_adblock_enabled_pressed():
	print(GP.Ads.is_adblock_enabled())


func _on_is_sticky_available_pressed():
	print(GP.Ads.is_sticky_available())


func _on_is_fullscreen_available_pressed():
	print(GP.Ads.is_fullscreen_available())


func _on_is_rewarded_available_pressed():
	print(GP.Ads.is_rewarded_available())


func _on_signal_start():
	print("start")
	
func _on_signal_close(success):
	print("close")
	print("success: ", success)


func _on_show_fullscreen_pressed():
	GP.Ads.show_fullscreen(true)


func _on_show_rewarded_video_pressed():
	GP.Ads.show_rewarded_video(true)
	
func ddd():
	gui_input.connect(func(): pass)
