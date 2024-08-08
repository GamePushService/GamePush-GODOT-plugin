extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var ads:JavaScriptObject

signal start
signal close
signal fullsreen_start
signal fullsreen_close
signal preloader_start
signal preloader_close
signal rewarded_start
signal rewarded_close
signal rewarded_reward
signal sticky_start
signal sticky_close
signal sticky_render
signal sticky_refresh

	
func _ready():
	if OS.get_name() == "Web":
		print("Ads start init")
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		ads = gp.ads
		ads.on('start', func _start(): start.emit())
		ads.on('close', func _close(): close.emit())
		ads.on('fullscreen:start', func _fullscreen_start(): fullsreen_start.emit())
		ads.on('fullscreen:close', func _fullscreen_close(): fullsreen_close.emit())
		ads.on('preloader:start', func _preloader_start(): preloader_start.emit())
		ads.on('preloader:close', func _preloader_close(): preloader_close.emit())
		ads.on('rewarded:start', func _rewarded_start(): rewarded_start.emit())
		ads.on('rewarded:close', func _rewarded_close(): rewarded_close.emit())
		ads.on('rewarded:reward', func _rewarded_reward(): rewarded_reward.emit())
		ads.on('sticky:start', func _sticky_start(): sticky_start.emit())
		ads.on('sticky:close', func _sticky_close(): sticky_close.emit())
		ads.on('sticky:render', func _sticky_render(): sticky_render.emit())
		ads.on('sticky:refresh', func _sticky_refresh(): sticky_refresh.emit())
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


func show_fullscreen(show_countdown_overlay=false) -> void:
	if OS.get_name() == "Web":
		if show_countdown_overlay:
			var conf = JavaScriptBridge.create_object("Object")
			conf.showCountdownOverlay = show_countdown_overlay
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
