extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var ads:JavaScriptObject

signal start
signal close
signal fullscreen_start
signal fullscreen_close
signal preloader_start
signal preloader_close
signal rewarded_start
signal rewarded_close
signal rewarded_reward
signal sticky_start
signal sticky_close
signal sticky_render
signal sticky_refresh

var callback_start = JavaScriptBridge.create_callback(_start)
var _allback_start = JavaScriptBridge.create_callback(_start)
var callback_close = JavaScriptBridge.create_callback(_close)
var callback_fullscreen_start = JavaScriptBridge.create_callback(_fullscreen_start)
var callback_fullscreen_close = JavaScriptBridge.create_callback(_fullscreen_close)
var callback_preloader_start = JavaScriptBridge.create_callback(_preloader_start)
var callback_preloader_close = JavaScriptBridge.create_callback(_preloader_close)
var callback_rewarded_start = JavaScriptBridge.create_callback(_rewarded_start)
var callback_rewarded_close = JavaScriptBridge.create_callback(_rewarded_close)
var callback_rewarded_reward = JavaScriptBridge.create_callback(_rewarded_reward)
var callback_sticky_start = JavaScriptBridge.create_callback(_sticky_start)
var callback_sticky_close = JavaScriptBridge.create_callback(_sticky_close)
var callback_sticky_render = JavaScriptBridge.create_callback(_sticky_render)
var callback_sticky_refresh = JavaScriptBridge.create_callback(_sticky_refresh)


func _ready():
	if OS.get_name() == "Web":
		print("Ads start init")
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		ads = gp.ads
		
		ads.on('start', callback_start)
		ads.on('close', callback_close)
		ads.on('fullscreen:start', callback_fullscreen_start)
		ads.on('fullscreen:close', callback_fullscreen_close)
		ads.on('preloader:start', callback_preloader_start)
		ads.on('preloader:close', callback_preloader_close)
		ads.on('rewarded:start', callback_preloader_start)
		ads.on('rewarded:close', callback_preloader_close)
		ads.on('rewarded:reward', callback_rewarded_reward)
		ads.on('sticky:start', callback_sticky_start)
		ads.on('sticky:close', callback_close)
		ads.on('sticky:render', callback_sticky_render)
		ads.on('sticky:refresh', callback_sticky_refresh)
		print("Ads init")

		
func is_adblock_enabled() -> bool:
	if OS.get_name() == "Web" and ads:
		return ads.isAdblockEnabled
	push_warning("Not Web")
	return false
		
func is_sticky_available() -> bool:
	if OS.get_name() == "Web":
		return ads.isStickyAvailable
	push_warning("Not Web")
	return false
		
func is_fullscreen_available() -> bool:
	if OS.get_name() == "Web":
		return ads.isFullscreenAvailable
	push_warning("Not Web")
	return false
		
func is_rewarded_available() -> bool:
	if OS.get_name() == "Web":
		return ads.isRewardedAvailable
	push_warning("Not Web")
	return false
		
	# Is the ads playing now	
func is_sticky_playing() -> bool:
	if OS.get_name() == "Web":
		return ads.isStickyPlaying
	push_warning("Not Web")
	return false
		
func is_fullscreen_playing() -> bool:
	if OS.get_name() == "Web":
		return ads.isFullscreenPlaying
	push_warning("Not Web")
	return false
		
func is_rewarded_playing() -> bool:
	if OS.get_name() == "Web":
		return ads.isRewardedPlaying
	push_warning("Not Web")
	return false

func is_preloader_playing() -> bool:
	if OS.get_name() == "Web":
		return ads.isStickyPlaying
	push_warning("Not Web")
	return false
	
func is_countdown_overlay_enabled() -> bool:
	if OS.get_name() == "Web":
		return ads.isCountdownOverlayEnabled
	push_warning("Not Web")
	return false
	
func is_rewarded_failed_overlay_enabled() -> bool:
	if OS.get_name() == "Web":
		return ads.isRewardedFailedOverlayEnabled
	push_warning("Not Web")
	return false
	
func can_show_fullscreen_before_game_play() -> bool:
	if OS.get_name() == "Web":
		return ads.canShowFullscreenBeforeGamePlay
	push_warning("Not Web")
	return false
	


func show_fullscreen(show_countdown_overlay=false) -> void:
	if OS.get_name() == "Web":
		if show_countdown_overlay:
			var conf = JavaScriptBridge.create_object("Object")
			conf["showCountdownOverlay"] = show_countdown_overlay
			ads.showFullscreen(conf)
		else:
			ads.showFullscreen()
		return
	push_warning("Not Web")
		
func show_preloader() -> void:
	if OS.get_name() == "Web":
		ads.showPreloader()
		return
	push_warning("Not Web")
		
func show_rewarded_video(show_countdown_overlay=false) -> void:
	if OS.get_name() == "Web":
		ads.showRewardedVideo({"showCountdownOverlay": show_countdown_overlay})
		return
	push_warning("Not Web")
		
func show_sticky() -> void:
	if OS.get_name() == "Web":
		ads.showSticky()
		return
	push_warning("Not Web")
		
func refresh_sticky() -> void:
	if OS.get_name() == "Web":
		ads.refreshSticky()
		return
	push_warning("Not Web")

func close_sticky() -> void:
	if OS.get_name() == "Web":
		ads.closeSticky()
		return
	push_warning("Not Web")


func _start(args): start.emit()
func _close(args): close.emit()
func _fullscreen_start(args): fullscreen_start.emit()
func _fullscreen_close(args): fullscreen_close.emit()
func _preloader_start(args): preloader_start.emit()
func _preloader_close(args): preloader_close.emit()
func _rewarded_start(args): rewarded_start.emit()
func _rewarded_close(args): rewarded_close.emit()
func _rewarded_reward(args): rewarded_reward.emit()
func _sticky_start(args): sticky_start.emit()
func _sticky_close(args): sticky_close.emit()
func _sticky_render(args): sticky_render.emit()
func _sticky_refresh(args): sticky_refresh.emit()
