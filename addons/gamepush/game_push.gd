extends Node
#
@onready var Achievements := preload("res://addons/gamepush/modules/Achievements.gd").new()
@onready var Ads := preload("res://addons/gamepush/modules/Ads.gd").new()
@onready var Analytics := preload("res://addons/gamepush/modules/Analytics.gd").new()
@onready var Triggers := preload("res://addons/gamepush/modules/Triggers.gd").new()
@onready var App := preload("res://addons/gamepush/modules/App.gd").new()
@onready var AvatarGenerator := preload("res://addons/gamepush/modules/AvatarGenerator.gd").new()
@onready var Channels := preload("res://addons/gamepush/modules/Channels.gd").new()
@onready var Device := preload("res://addons/gamepush/modules/Device.gd").new()
@onready var Documents := preload("res://addons/gamepush/modules/Documents.gd").new()
@onready var Events := preload("res://addons/gamepush/modules/Events.gd").new()
@onready var Experiments := preload("res://addons/gamepush/modules/Experiments.gd").new()
@onready var Fullscreen := preload("res://addons/gamepush/modules/Fullscreen.gd").new()
@onready var Files := preload("res://addons/gamepush/modules/Files.gd").new()
@onready var Game := preload("res://addons/gamepush/modules/Game.gd").new()
@onready var GamesCollections := preload("res://addons/gamepush/modules/GameCollections.gd").new()
@onready var Images := preload("res://addons/gamepush/modules/Images.gd").new()
@onready var Language := preload("res://addons/gamepush/modules/Language.gd").new()
@onready var Leaderboard := preload("res://addons/gamepush/modules/Leaderboard.gd").new()
@onready var Logger := preload("res://addons/gamepush/modules/Logger.gd").new()
@onready var Payments := preload("res://addons/gamepush/modules/Payments.gd").new()
@onready var Platform := preload("res://addons/gamepush/modules/Platform.gd").new()
@onready var Player := preload("res://addons/gamepush/modules/Player.gd").new()
@onready var Players := preload("res://addons/gamepush/modules/Players.gd").new()
@onready var Rewards := preload("res://addons/gamepush/modules/Rewards.gd").new()
@onready var Schedulers := preload("res://addons/gamepush/modules/Schedulers.gd").new()
@onready var Segments := preload("res://addons/gamepush/modules/Segments.gd").new()
@onready var Server := preload("res://addons/gamepush/modules/Server.gd").new()
@onready var Socials := preload("res://addons/gamepush/modules/Socials.gd").new()
@onready var System := preload("res://addons/gamepush/modules/System.gd").new()
@onready var Variables := preload("res://addons/gamepush/modules/Variables.gd").new()
@onready var Uniques := preload("res://addons/gamepush/modules/Uniques.gd").new()
@onready var Storage := preload("res://addons/gamepush/modules/Storage.gd").new()

var gp:JavaScriptObject

signal inited(success:bool)
var is_inited := false

func _ready():
	var is_init := false
	if !OS.get_name() == "Web":
		inited.emit(is_init)
		is_inited = true
		push_warning("Not running on Web")
		return
	var project_id := str(ProjectSettings.get_setting("game_push/config/project_id"))
	var public_token := ProjectSettings.get_setting("game_push/config/token")
	var clbk := JavaScriptBridge.create_callback(func(args):
		gp = args[0]
		is_init = true)
	var win := JavaScriptBridge.get_interface("window")
	win.setGpInitCallback(clbk)
	var lib_url := "https://gamepush.com/sdk/game-score.js?projectId=%s&publicToken=%s&callback=onGPInit" % [project_id, public_token]
	var js_code = "var script = document.createElement('script'); script.src = '" + lib_url + "'; document.head.appendChild(script);"
	JavaScriptBridge.eval(js_code, true)
	while not gp:
		await get_tree().create_timer(0.1).timeout
		
	add_child(Achievements)
	add_child(Ads)
	add_child(Analytics)
	add_child(Triggers)
	add_child(App)
	add_child(AvatarGenerator)
	add_child(Channels)
	add_child(Device)
	add_child(Documents)
	add_child(Events)
	add_child(Experiments)
	add_child(Fullscreen)
	add_child(Files)
	add_child(Game)
	add_child(GamesCollections)
	add_child(Images)
	add_child(Language)
	add_child(Leaderboard)
	add_child(Logger)
	add_child(Payments)
	add_child(Platform)
	add_child(Player)
	add_child(Players)
	add_child(Rewards)
	add_child(Schedulers)
	add_child(Segments)
	add_child(Server)
	add_child(Socials)
	add_child(System)
	add_child(Variables)
	add_child(Uniques)
	add_child(Storage)
	
	var timer := Timer.new()
	var is_preloader_show := ProjectSettings.get_setting("game_push/config/is_preloader_show", false)
	var ready_delay := ProjectSettings.get_setting("game_push/config/ready_delay", 0.0)
	if is_preloader_show:
		Ads.show_preloader()
	if ready_delay > 0.0:
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)
		timer.start(ready_delay)
	elif ready_delay == 0.0:
		_on_timer_timeout()
	
	inited.connect(func(is_init): is_inited = true)
	inited.emit(is_init)
	


func _on_timer_timeout():
	Game.game_start()
	
	
func _js_to_dict(js_object:JavaScriptObject) -> Variant:
	var window := JavaScriptBridge.get_interface("window")
	var strn = window.JSON.stringify(js_object)
	return JSON.parse_string(strn)
	
	
class GPObject:
	
	func to_dict() -> Dictionary:
		var result = {}
		for property_info in get_property_list():
			var property_name = property_info.name
			result[property_name] = self.get(property_name)
		return result
