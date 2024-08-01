extends Node


class Ads:
	static var window:JavaScriptObject
	static var gp:JavaScriptObject
	static var ads:JavaScriptObject
	
	
	static func _static_init():
		if OS.get_name() == "Web":
			window = JavaScriptBridge.get_interface("window")
			while not gp:
				gp = window.gp
				ads = gp.ads
			#ads.on('start', func _start(): start.emit())
		
	static func is_adblock_enabled() -> bool:
		if OS.get_name() == "Web":
			return ads.isAdblockEnabled
		return false
		
	static func is_sticky_available() -> bool:
		if OS.get_name() == "Web":
			return ads.isStickyAvailable
		return false
		
	static func is_fullscreen_available() -> bool:
		if OS.get_name() == "Web":
			return ads.isFullscreenAvailable
		return false
		
	static func is_rewarded_available() -> bool:
		if OS.get_name() == "Web":
			return ads.isRewardedAvailable
		return false
		
	# Is the ads playing now	
	static func is_sticky_playing() -> bool:
		if OS.get_name() == "Web":
			return ads.isStickyPlaying
		return false
		
	static func is_fullscreen_playing() -> bool:
		if OS.get_name() == "Web":
			return ads.isFullscreenPlaying
		return false
		
	static func is_rewarded_playing() -> bool:
		if OS.get_name() == "Web":
			return ads.isRewardedPlaying
		return false

	static func is_preloader_playing() -> bool:
		if OS.get_name() == "Web":
			return ads.isStickyPlaying
		return false
