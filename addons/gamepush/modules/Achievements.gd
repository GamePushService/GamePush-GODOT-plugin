extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var achievements:JavaScriptObject

signal unlocked(achievement:Achievement)
signal error_unlock(error:String)
signal progress(achievement:Achievement)
signal error_progress(error:String)
signal opened
signal closed
signal fetched(achievement:Array[Achievement], achievements_groups:Array[AchievementsGroup], player_achievements:Array[PlayerAchievement])
signal error_fetch(error:String)

var _callback_unlock = JavaScriptBridge.create_callback(_unlock)
var _callback_error_unlock = JavaScriptBridge.create_callback(_error_unlock)
var _callback_progress = JavaScriptBridge.create_callback(_progress)
var _callback_error_progress = JavaScriptBridge.create_callback(_error_progress)
var _callback_opened = JavaScriptBridge.create_callback(_opened)
var _callback_closed = JavaScriptBridge.create_callback(_closed)
var _callback_fetched = JavaScriptBridge.create_callback(_fetched)
var _callback_error_fetched = JavaScriptBridge.create_callback(_error_fetched)


func _ready():
	if OS.get_name() == "Web":
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		achievements = gp.achievements
		achievements.on("unlock", _callback_unlock)
		achievements.on("error:unlock", _callback_error_unlock)
		achievements.on("progress", _callback_unlock)
		achievements.on("error:progress", _callback_error_unlock)
		achievements.on("open", _callback_opened)
		achievements.on("close", _callback_closed)
		achievements.on("fetch", _callback_fetched)
		achievements.on("error:fetch", _callback_error_fetched)


func unlock(id_or_tag:Variant) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id_or_tag is int:
			conf["id"] = id_or_tag
			achievements.unlock(conf)
			return
		else:
			conf["tag"] = id_or_tag
			achievements.unlock(conf)
			return
		push_error("No id or tag")
		return
	push_warning("Not Web")
	

func set_progress(progress:int, id_or_tag:Variant) -> void:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		conf["progress"] = progress
		if id_or_tag is int:
			conf["id"] = id_or_tag
			achievements.setProgress(conf)
			return
		else:
			conf["tag"] = id_or_tag
			achievements.setProgress(conf)
			return
		push_error("No id or tag")
		return
	push_warning("Not Web")
	
	
func has(id_or_tag:Variant ) -> bool:
	if OS.get_name() == "Web":
		return achievements.has(id_or_tag)
	push_warning("Not Web")
	return false		


func get_progress(id_or_tag:Variant) -> int:
	if OS.get_name() == "Web":
		return achievements.getProgress(id_or_tag)
	push_warning("Not Web")
	return 0
		
		
func open() -> void:
	if OS.get_name() == "Web":
		achievements.open()
	else:
		push_warning("Not Web")


func fetch() -> void:
	if OS.get_name() == "Web":
		achievements.fetch()
	else:
		push_warning("Not Web")
	
	
func list() -> Array[Achievement]:
	var result : Array[Achievement] = []
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args):
			result.append(Achievement.new()._from_js(args[0])))
		achievements.list.forEach(callback)
	else:
		push_warning("Not Web")
	return result
	

func player_achievements_list() -> Array[PlayerAchievement]:
	var result : Array[PlayerAchievement] = []
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args):
			result.append(PlayerAchievement.new()._from_js(args[0])))
		achievements.playerAchievementsList.forEach(callback)
	else:
		push_warning("Not Web")
	return result
	
	
func groups_list() -> Array[AchievementsGroup]:
	var result : Array[AchievementsGroup] = []
	if OS.get_name() == "Web":
		var callback := JavaScriptBridge.create_callback(func(args):
			result.append(AchievementsGroup.new()._from_js(args[0])))
		achievements.groupsList.forEach(callback)
	else:
		push_warning("Not Web")
	return result


func _unlock(args): unlocked.emit(Achievement.new()._from_js(args[0]))
func _error_unlock(args): error_unlock.emit(args[0])
func _progress(args): progress.emit(Achievement.new()._from_js(args[0]))
func _error_progress(args): error_progress.emit(args[0])
func _opened(args): opened.emit()
func _closed(args): closed.emit()
func _fetched(args):
	var achive:JavaScriptObject = args[0]
	var achievements := []
	var achievements_groups := []
	var player_achievements := []
	var _callback_achievements := JavaScriptBridge.create_callback(func(args):
		achievements.append(Achievement.new()._from_js(args[0])))
	achive.achievements.forEach(_callback_achievements)
	var _callback_achievements_groups:= JavaScriptBridge.create_callback(func(args):
		achievements_groups.append(AchievementsGroup.new()._from_js(args[0])))
	achive.achievementsGroups.forEach(_callback_achievements_groups)
	var _callback_player_achievements:= JavaScriptBridge.create_callback(func(args):
		player_achievements.append(PlayerAchievement.new()._from_js(args[0])))
	achive.playerAchievements.forEach(_callback_player_achievements)
	fetched.emit(achievements, achievements_groups, player_achievements)
	
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
	var is_locked_visible: bool
	var is_locked_description_visible: bool

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
		is_locked_visible = js_object["isLockedVisible"]
		is_locked_description_visible = js_object["isLockedDescriptionVisible"]
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
		js_object["isLockedVisible"] = is_locked_visible
		js_object["isLockedDescriptionVisible"] = is_locked_description_visible
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
		var callback := JavaScriptBridge.create_callback(func(args):
			achievements.append(args[0]))
		js_object["achievements"].forEach(callback)
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
