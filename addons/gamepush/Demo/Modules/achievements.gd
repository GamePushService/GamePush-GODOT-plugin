extends Control


func _on_open_pressed():
	GP.Achievements.open()


func _on_fetch_pressed():
	print(await GP.Achievements.fetch())
