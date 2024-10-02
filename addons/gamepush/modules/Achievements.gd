extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var achievements:JavaScriptObject

signal unlocked
signal error_unlock 
signal progress
signal error_progress
signal opened
signal closed
signal fetched
signal error_fetch

var callback_unlock = JavaScriptBridge.create_callback(_unlock)
var callback_error_unlock = JavaScriptBridge.create_callback(_error_unlock)
var callback_progress = JavaScriptBridge.create_callback(_progress)
var callback_error_progress = JavaScriptBridge.create_callback(_error_progress)
var callback_opened = JavaScriptBridge.create_callback(_opened)
var callback_closed = JavaScriptBridge.create_callback(_closed)
var callback_fetched = JavaScriptBridge.create_callback(_fetched)
var callback_error_fetched = JavaScriptBridge.create_callback(_error_fetched)


func _ready():
	if OS.get_name() == "Web":
		print("Achievements start init")
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		achievements = gp.achievements
		
		achievements.on("unlock", callback_unlock)
		achievements.on("error:unlock", callback_error_unlock)
		#TODO FIX IT
		
		print("Achievements init")


func unlock(id=null, tag=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf["id"] = id
			achievements.unlock(conf)
			return
		if tag:
			conf["tag"] = tag
			achievements.unlock(conf)
			return
		push_error("No id or tag")
	push_warning("Not Web")
	

func set_progress(progress:int, id=null, tag=null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf["id"] = id
			conf["progress"] = progress
			achievements.setProgress(conf)
			return
		if tag:
			conf["tag"] = tag
			conf["progress"] = progress
			achievements.setProgress(conf)
			return
		push_error("No id or tag")
	push_warning("Not Web")
	
	
func has(id=null, tag=null):
	if OS.get_name() == "Web":
		if id:
			return achievements.has(id)
		if tag:
			return achievements.has(tag)
		push_error("No id or tag")
	push_warning("Not Web")

func get_progress(id=null, tag=null):
	if OS.get_name() == "Web":
		if id:
			return achievements.getProgress(id)
		if tag:
			return achievements.getProgress(tag)
		push_error("No id or tag")
	push_warning("Not Web")
		
		
func open():
	if OS.get_name() == "Web":
		return await achievements.open() # Need rewrite
	push_warning("Not Web")
	
func fetch():
	if OS.get_name() == "Web":
		# нужно ли переделывать в словарь????
		var result:Dictionary = {
			"achievements": {"id": null, "tag": null, "name": null,
			"description": null, "icon": null, "iconSmall": null,
			"lockedIcon": null, "lockedIconSmall": null, "rare": null,
			"maxProgress": null, "progressStep": null, "lockedVisible": null,
			"lockedDescriptionVisible": null},
			"achievementsGroup": {"id": null, "tag": null, "name": null,
			"description": null, "achievements": null},
			"playerAchievement": {"achievementId": null, "createdAt": null,
			"progress": null, "unlocked": null},
		}
		var achive:JavaScriptObject
		achive = await achievements.fetch()
		if achive.achievements:
			result["achievements"]["id"] = achive.achievements.id
			result["achievements"]["tag"] = achive.achievements.tag
			result["achievements"]["name"] = achive.achievements.name
			result["achievements"]["description"] = achive.achievements.description
			result["achievements"]["icon"] = achive.achievements.icon
			result["achievements"]["iconSmall"] = achive.achievements.iconSmall
			result["achievements"]["lockedIcon"] = achive.achievements.lockedIcon
			result["achievements"]["lockedIconSmall"] = achive.achievements.lockedIconSmall
			result["achievements"]["maxProgress"] = achive.achievements.maxProgress
			result["achievements"]["progressStep"] = achive.achievements.progressStep
			result["achievements"]["lockedVisible"] = achive.achievements.lockedVisible
			result["achievements"]["lockedDescriptionVisible"] = achive.achievements.lockedDescriptionVisible
		if achive.achievementsGroup:
			result["achievementsGroup"]["id"] = achive.achievementsGroup.id
			result["achievementsGroup"]["tag"] = achive.achievementsGroup.tag
			result["achievementsGroup"]["name"] = achive.achievementsGroup.name
			result["achievementsGroup"]["description"] = achive.achievementsGroup.description
			result["achievementsGroup"]["achievements"] = achive.achievementsGroup.achievements
		if achive.playerAchievement:
			result["playerAchievement"]["achievementId"] = achive.playerAchievement.achievementId
			result["playerAchievement"]["createdAt"] = achive.playerAchievement.createdAt
			result["playerAchievement"]["progress"] = achive.playerAchievement.progress
			result["playerAchievement"]["unlocked"] = achive.playerAchievement.unlocked
		return result
	push_warning("Not Web")
	

func _unlock(args): unlocked.emit(args[0])
func _error_unlock(args): error_unlock.emit(args[0])
func _progress(args): progress.emit(args[0])
func _error_progress(args): error_progress.emit(args[0])
func _opened(args): opened.emit(args[0])
func _closed(args): closed.emit(args[0])
func _fetched(args): fetched.emit(args[0])
func _error_fetched(args): error_fetch.emit(args[0])
