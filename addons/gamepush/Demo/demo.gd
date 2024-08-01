extends Control


func _on_is_adblock_enabled_pressed():
	print(GP.Ads.is_adblock_enabled())


func _on_is_sticky_available_pressed():
	print(GP.Ads.is_sticky_available())


func _on_is_fullscreen_available_pressed():
	print(GP.Ads.is_fullscreen_available())


func _on_is_rewarded_available_pressed():
	print(GP.Ads.is_rewarded_available())
