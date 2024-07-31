extends Node

class Ads:
	static var window = JavaScriptBridge.get_interface("window")
	static var gp = window.gp
	static var ads = gp.ads
	
	static func is_adblock_enabled() -> bool:
		return ads.isAdblockEnabled
		
	static func is_sticky_available() -> bool:
		return ads.isStickyAvailable
		
	static func is_fullscreen_available() -> bool:
		return ads.isFullscreenAvailable
		
	static func is_rewarded_available() -> bool:
		return ads.isRewardedAvailable
	
	# Is the ads playing now	
	static func is_sticky_playing() -> bool:
		return ads.isStickyPlaying
		
	static func is_fullscreen_playing() -> bool:
		return ads.isFullscreenPlaying

	static func is_rewarded_playing() -> bool:
		return ads.isRewardedPlaying

	static func is_preloader_playing() -> bool:
		return ads.isStickyPlaying
