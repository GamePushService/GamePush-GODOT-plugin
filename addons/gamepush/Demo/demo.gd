extends Control


func _on_ads_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Ads.tscn")


func _on_achievements_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Achievements.tscn")


func _on_analytics_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Analytics.tscn")
