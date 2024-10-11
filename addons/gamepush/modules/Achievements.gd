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
		return await achievements.open()
	push_warning("Not Web")
	
func fetch():
	if OS.get_name() == "Web":
		var achive:JavaScriptObject
		achive = achievements.fetch()
		var achievements := []
		var achievements_groups := []
		var player_achievements := []
		for a in achive.achievements:
			achievements.append(Achievement.new()._from_js(a))
		for ag in achive.achievementsGroups:
			achievements.append(AchievementsGroup.new()._from_js(ag))
		for pa in achive.playerAchievements:
			achievements.append(PlayerAchievement.new()._from_js(pa))
		return [achievements, achievements_groups, player_achievements]
	push_warning("Not Web")
	

func _unlock(args): unlocked.emit(args[0])
func _error_unlock(args): error_unlock.emit(args[0])
func _progress(args): progress.emit(args[0])
func _error_progress(args): error_progress.emit(args[0])
func _opened(args): opened.emit(args[0])
func _closed(args): closed.emit(args[0])
func _fetched(args):
	var achive:JavaScriptObject = args[0]
	var achievements := []
	var achievements_groups := []
	var player_achievements := []
	for a in achive.achievements:
		achievements.append(Achievement.new()._from_js(a))
	for ag in achive.achievementsGroups:
		achievements.append(AchievementsGroup.new()._from_js(ag))
	for pa in achive.playerAchievements:
		achievements.append(PlayerAchievement.new()._from_js(pa))
	fetched.emit([achievements, achievements_groups, player_achievements])
	
func _error_fetched(args): error_fetch.emit(args[0])


class Achievement:
	var id: int
	var tag: String
	var name: String
	var description: String
	var icon: String
	var icon_small: String
	var locked_icon: String
	var locked_icon_small: String
	var rare: String
	var max_progress: int
	var progress_step: int
	var locked_visible: bool
	var locked_description_visible: bool

	func _from_js(js_object: JavaScriptObject) -> Achievement:
		id = js_object["id"]
		tag = js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		icon = js_object["icon"]
		icon_small = js_object["iconSmall"]
		locked_icon = js_object["lockedIcon"]
		locked_icon_small = js_object["lockedIconSmall"]
		rare = js_object["rare"]
		max_progress = js_object["maxProgress"]
		progress_step = js_object["progressStep"]
		locked_visible = js_object["lockedVisible"]
		locked_description_visible = js_object["lockedDescriptionVisible"]
		return self

	func _to_js() -> JavaScriptObject:
		var js_object: = JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["name"] = name
		js_object["description"] = description
		js_object["icon"] = icon
		js_object["iconSmall"] = icon_small
		js_object["lockedIcon"] = locked_icon
		js_object["lockedIconSmall"] = locked_icon_small
		js_object["rare"] = rare
		js_object["maxProgress"] = max_progress
		js_object["progressStep"] = progress_step
		js_object["lockedVisible"] = locked_visible
		js_object["lockedDescriptionVisible"] = locked_description_visible
		return js_object

class AchievementsGroup:
	var id: int
	var tag: String
	var name: String
	var description: String
	var achievements: Array # Array of achievement IDs

	func _from_js(js_object: JavaScriptObject) -> AchievementsGroup:
		id = js_object["id"]
		tag = js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		achievements = []
		for a in js_object["achievements"]:
			achievements.append(a)
		return self

	func _to_js() -> JavaScriptObject:
		var js_object: = JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["name"] = name
		js_object["description"] = description
		var _achievements := JavaScriptBridge.create_object("Array")
		for a in achievements:
			_achievements.push(a)
		js_object["achievements"] = _achievements
		return js_object

class PlayerAchievement:
	var achievement_id: int
	var created_at: String
	var progress: int
	var unlocked: bool

	func _from_js(js_object: JavaScriptObject) -> PlayerAchievement:
		achievement_id = js_object["achievementId"]
		created_at = js_object["createdAt"]
		progress = js_object["progress"]
		unlocked = js_object["unlocked"]
		return self

	func _to_js() -> JavaScriptObject:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["achievementId"] = achievement_id
		js_object["createdAt"] = created_at
		js_object["progress"] = progress
		js_object["unlocked"] = unlocked
		return js_object
