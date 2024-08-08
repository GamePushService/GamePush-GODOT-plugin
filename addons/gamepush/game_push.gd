extends Node

var Ads

func _ready():
	Ads = await preload("res://addons/gamepush/classes/Ads.gd").new()
	add_child(Ads)
