extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GP.Leaderboard.opened.connect(func(): GP.Logger.info("open"))
	GP.Leaderboard.closed.connect(func(): GP.Logger.info("close"))
	GP.Leaderboard.fetched.connect(func(players, fields, top_players,
	above_players, belowPlayers, player):
		GP.Logger.info("fetch")
		GP.Logger.info(player)
		)
	GP.Leaderboard.fetched_player_rating.connect(func(player, fields,
	above_players, belowPlayers):
		GP.Logger.info("fetched_player_rating")
		GP.Logger.info(player)
		)
	GP.Leaderboard.fetched_scoped.connect(func(player, fields,
	above_players, belowPlayers):
		GP.Logger.info("fetched_scoped")
		GP.Logger.info(player)
		)
	GP.Leaderboard.fetched_player_rating_scoped.connect(func(player, fields,
	above_players, belowPlayers):
		GP.Logger.info("fetched_player_rating_scoped")
		GP.Logger.info(player)
		)


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_fetch_pressed():
	GP.Leaderboard.fetch()


func _on_open_pressed():
	GP.Leaderboard.open()


func _on_fetch_player_rating_pressed():
	GP.Leaderboard.fetch_player_rating()


func _on_open_scoped_pressed():
	pass
	#GP.Leaderboard.open_scoped()
	
	
func _on_fetch_scoped_pressed():
	pass
	#GP.Leaderboard.fetched_scoped()
	
	
func _on_publish_record_pressed():
	pass
	#GP.Leaderboard.publish_record()


func _on_fetch_player_rating_scoped_pressed():
	#GP.Leaderboard.fetch_player_rating_scoped()
	pass # Replace with function body.
