extends Control

func _ready():
	GP.Ads.start.connect(_on_signal_start)
	GP.Ads.close.connect(_on_signal_close)
	GP.Ads.fullscreen_start.connect(func(): GP.Logger.info("fullscreen start"))
	GP.Ads.fullscreen_close.connect(func(arg): GP.Logger.info("fullscreen close", arg))
	GP.Ads.preloader_start.connect(func(): GP.Logger.info("preloader start"))
	GP.Ads.preloader_close.connect(func(arg): GP.Logger.info("preloader close", arg))
	GP.Ads.rewarded_reward.connect(func(): GP.Logger.info("rewarded reward"))
	GP.Ads.rewarded_start.connect(func(): GP.Logger.info("rewarded start"))
	GP.Ads.rewarded_close.connect(func(arg): GP.Logger.info("rewarded close", arg))
	GP.Ads.sticky_start.connect(func(): GP.Logger.info("sticky start"))
	GP.Ads.sticky_close.connect(func(): GP.Logger.info("sticky close"))
	GP.Ads.sticky_render.connect(func(): GP.Logger.info("sticky render"))
	GP.Ads.sticky_refresh.connect(func(): GP.Logger.info("sticky refresh"))


func _on_is_adblock_enabled_pressed():
	GP.Logger.info(GP.Ads.is_adblock_enabled())


func _on_is_sticky_available_pressed():
	GP.Logger.info(GP.Ads.is_sticky_available())


func _on_is_fullscreen_available_pressed():
	GP.Logger.info(GP.Ads.is_fullscreen_available())


func _on_is_rewarded_available_pressed():
	GP.Logger.info(GP.Ads.is_rewarded_available())


func _on_signal_start():
	GP.Logger.info("start")
	
func _on_signal_close(success):
	GP.Logger.info("close")
	GP.Logger.info("success: ", success)


func _on_show_fullscreen_pressed():
	GP.Ads.show_fullscreen(true)


func _on_show_rewarded_video_pressed():
	GP.Ads.show_rewarded_video(true)


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://addons/gamepush/Demo/Demo.tscn")


func _on_show_preloader_pressed():
	GP.Ads.show_preloader()


func _on_is_sticky_playing_pressed():
	GP.Logger.info(GP.Ads.is_sticky_playing())


func _on_is_fullscreen_playing_pressed():
	GP.Logger.info(GP.Ads.is_fullscreen_playing())


func _on_is_rewarded_playing_pressed():
	GP.Logger.info(GP.Ads.is_rewarded_playing())


func _on_is_preloader_playing_pressed():
	GP.Logger.info(GP.Ads.is_preloader_playing())


func _on_is_countdown_overlay_enabled_pressed():
	GP.Logger.info(GP.Ads.is_countdown_overlay_enabled())


func _on_is_rewarded_failed_overlay_enabled_pressed():
	GP.Logger.info(GP.Ads.is_rewarded_failed_overlay_enabled())


func _on_show_sticky_pressed():
	GP.Ads.show_sticky()


func _on_can_show_fullscreen_before_game_play_pressed():
	GP.Logger.info(GP.Ads.can_show_fullscreen_before_game_play())


func _on_refresh_sticky_pressed():
	GP.Ads.refresh_sticky()


func _on_close_sticky_pressed():
	GP.Ads.close_sticky()
