extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var rewards:JavaScriptObject

signal after_ready

signal reward_given(reward:Reward, player_reward:PlayerReward)
signal _reward_given(arg:JavaScriptObject)
signal reward_error(err:String)
signal reward_accept_error(err:String)
signal reward_accepted(reward:Reward, player_reward:PlayerReward)
signal _reward_accepted(arg:JavaScriptObject)


var _callback_reward_given := JavaScriptBridge.create_callback(_on_reward_given)
var _callback_reward_error := JavaScriptBridge.create_callback(_on_reward_error)
var _callback_reward_accepted := JavaScriptBridge.create_callback(_on_reward_accepted)
var _callback_reward_accept_error := JavaScriptBridge.create_callback(_on_reward_accept_error)


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		rewards = gp.rewards
		rewards.on("give", _callback_reward_given)
		rewards.on("error:give", _callback_reward_error)
		rewards.on("error:accept", _callback_reward_accept_error)
		rewards.on("accept", _callback_reward_accepted)
	after_ready.emit()


func give(id_or_tag:Variant, lazy:bool = false) -> Array:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if _is_valid_id(id_or_tag):
			conf["id"] = id_or_tag
		else:
			conf["tag"] = id_or_tag
		if lazy:
			conf["lazy"] = lazy
		var callback := JavaScriptBridge.create_callback(func(res): _reward_given.emit(res[0]))
		rewards.give(conf).then(callback)
		var _result = await _reward_given
		var result:Array
		var reward = Reward.new()
		reward._from_js(_result.reward)
		result.append(reward)
		var player_reward = PlayerReward.new()
		player_reward._from_js(_result.playerReward)
		result.append(player_reward)
		return result
	push_warning("Not Web")
	return []


func accept(id_or_tag:Variant) -> Array:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if _is_valid_id(id_or_tag):
			conf["id"] = id_or_tag
		else:
			conf["tag"] = id_or_tag
		var callback := JavaScriptBridge.create_callback(func(res): _reward_accepted.emit(res[0]))
		rewards.accept(conf).then(callback)
		var _result = await _reward_accepted
		var result:Array
		var reward = Reward.new()
		reward._from_js(_result.reward)
		result.append(reward)
		var player_reward = PlayerReward.new()
		player_reward._from_js(_result.playerReward)
		result.append(player_reward)
		return result
	push_warning("Not Web")
	return []


func list() -> Array:
	if OS.get_name() == "Web":
		var result:Array
		var _result = rewards.list
		_result.forEach(JavaScriptBridge.create_callback(func (args): result.append(Reward.new()._from_js(args[0]))))
		return result
	push_warning("Not Web")
	return []


func given_list() -> Array:
	if OS.get_name() == "Web":
		var result:Array
		var _result = rewards.givenList
		_result.forEach(JavaScriptBridge.create_callback(func (args): result.append(PlayerReward.new()._from_js(args[0]))))
		return result
	push_warning("Not Web")
	return []
	
	
func get_reward(id_or_tag:Variant) -> Array:
	if OS.get_name() == "Web":
		var _result = rewards.getReward(id_or_tag)
		var result:Array
		result.append(Reward.new()._from_js(_result.reward))
		result.append(PlayerReward.new()._from_js(_result.playerReward))
		return result
	push_warning("Not Web")
	return []


func has(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		return gp.rewards.has(id_or_tag)
	push_warning("Not Web")
	return false
	
	
func has_accepted(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		return gp.rewards.hasAccepted(id_or_tag)
	push_warning("Not Web")
	return false
	
	
func has_unaccepted(id_or_tag: Variant) -> bool:
	if OS.get_name() == "Web":
		return gp.rewards.hasUnaccepted(id_or_tag)
	push_warning("Not Web")
	return false


# Method to handle the reward given event
func _on_reward_given(args) -> void:
	var reward = Reward.new()._from_js(args[0].reward)
	var player_reward = PlayerReward.new()._from_js(args[0].playerReward)
	reward_given.emit(reward, player_reward)
	
func _on_reward_error(args) -> void:
	reward_error.emit(args[0])

func _on_reward_accept_error(args) -> void:
	reward_accept_error.emit(args[0])
	
func _on_reward_accepted(args) -> void:
	var reward = Reward.new()._from_js(args[0].reward)
	var player_reward = PlayerReward.new()._from_js(args[0].playerReward)
	reward_accepted.emit(reward, player_reward)
	
func _is_valid_id(id:Variant):
	if id is int or id is float or id is String:
		var id_int := int(id)
		var list_id := []
		for a in list():
			list_id.append(a.id)
		if id_int in list_id:
			return true
	return false
	
class Reward:
	extends GP.GPObject
	
	var id: int
	var tag: String
	var name: String
	var description: String
	var icon: String
	var icon_small: String
	var mutations: Array # This will hold DataMutation objects
	var is_auto_accept: bool

	# Function to convert from JS object to GDScript object
	func _from_js(js_object: JavaScriptObject) -> Reward:
		id = js_object["id"]
		tag = js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		icon = js_object["icon"]
		icon_small = js_object["iconSmall"]
		is_auto_accept = js_object["isAutoAccept"]
		mutations = []
		var _mutations = js_object["mutations"]
		_mutations.forEach(JavaScriptBridge.create_callback(func (m): 
			mutations.append(DataMutation.new()._from_js(m[0]))))
		return self
		
	
	# Function to convert this object back to JS format
	func _to_js() -> JavaScriptObject:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["id"] = id
		js_object["tag"] = tag
		js_object["name"] = name
		js_object["description"] = description
		js_object["icon"] = icon
		js_object["iconSmall"] = icon_small
		var _mutations := JavaScriptBridge.create_object("Array")
		for m in mutations:
			_mutations.push(m._to_js())
		js_object["mutations"] = _mutations
		js_object["isAutoAccept"] = is_auto_accept
		return js_object


class PlayerReward:
	extends GP.GPObject
	
	var reward_id: int
	var count_total: int
	var count_accepted: int

	# Function to convert from JS object to GDScript object
	func _from_js(js_object: JavaScriptObject) -> PlayerReward:
		reward_id = js_object["rewardId"]
		count_total = js_object["countTotal"]
		count_accepted = js_object["countAccepted"]
		return self

	# Function to convert this object back to JS format
	func _to_js() -> JavaScriptObject:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["rewardId"] = reward_id
		js_object["countTotal"] = count_total
		js_object["countAccepted"] = count_accepted
		return js_object



class DataMutation:
	extends GP.GPObject
	
	var type: String 
	var key: String
	var action: String
	var value: Variant # Supports number, string, or boolean

	# Function to convert from JS object to GDScript object
	func _from_js(js_object: JavaScriptObject) -> DataMutation:
		type = js_object["type"]
		key = js_object["key"]
		action = js_object["action"]
		value = js_object["value"]
		return self

	# Function to convert this object back to JS format
	func _to_js() -> Dictionary:
		var js_object = JavaScriptBridge.create_object("Object")
		js_object["type"] = type
		js_object["key"] = key
		js_object["action"] = action
		js_object["value"] = value
		return js_object
