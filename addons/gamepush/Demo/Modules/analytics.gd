extends Control

var text_hit:String

func _on_hit_text_text_changed(new_text):
	if new_text != "":
		$MarginContainer/GridContainer/hit.disabled = false
	else:
		$MarginContainer/GridContainer/hit.disabled = true


func _on_hit_pressed():
	GP.Analytics.hit("")


func _on_goal_text_text_changed(new_text):
	pass # Replace with function body.


func _on_goal_pressed():
	pass # Replace with function body.
