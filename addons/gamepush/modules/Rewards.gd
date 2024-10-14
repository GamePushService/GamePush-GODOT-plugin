extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var rewards:JavaScriptObject

signal reward_given(reward:Reward, player_reward:PlayerReward)
signal reward_error(err:String)
signal reward_accept_error(err:String)
signal reward_accepted(reward:Reward, player_reward:PlayerReward)


var callback_reward_given := JavaScriptBridge.create_callback(_on_reward_given)
var callback_reward_error := JavaScriptBridge.create_callback(_on_reward_error)
var callback_reward_accepted := JavaScriptBridge.create_callback(_on_reward_accepted)
var callback_reward_accept_error := JavaScriptBridge.create_callback(_on_reward_accept_error)


func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		rewards = gp.rewards
		rewards.on("give", callback_reward_given)
		rewards.on("error:give", callback_reward_error)
		rewards.on("error:accept", callback_reward_accept_error)
		rewards.on("accept", callback_reward_accepted)

func give(id:Variant = null, tag:Variant = null, lazy:bool = false) -> Array:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf["id"] = id
		elif tag:
			conf["tag"] = tag
		if lazy:
			conf["lazy"] = lazy
		var _result = await rewards.give(conf)
		var result:Array
		var reward = Reward.new()
		reward._from_js(result[0])
		result.append(reward)
		var player_reward = PlayerReward.new()
		player_reward._from_js(result[1])
		result.append(player_reward)
		return result
	push_warning("Not Web")
	return []


func accept(id:Variant = null, tag:Variant = null) -> Array:
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf["id"] = id
		elif tag:
			conf["tag"] = tag
		var _result = await rewards.accept(conf)
		var result:Array
		var reward = Reward.new()
		reward._from_js(result[0])
		result.append(reward)
		var player_reward = PlayerReward.new()
		player_reward._from_js(result[1])
		result.append(player_reward)
		return result
	push_warning("Not Web")
	return []

func list() -> Array:
	if OS.get_name() == "Web":
		var result:Array
		var _result = rewards.list
		_result.forEach(JavaScriptBridge.create_callback(func (r): result.append(Reward.new()._from_js(r))))
	push_warning("Not Web")
	return []

func given_list() -> Array:
	if OS.get_name() == "Web":
		var result:Array
		var _result = rewards.givenList
		_result.forEach(JavaScriptBridge.create_callback(func (r): result.append(PlayerReward.new()._from_js(r))))
	push_warning("Not Web")
	return []
	
func get_reward(id_or_tag:Variant) -> Array:
	if OS.get_name() == "Web":
		var _result = await rewards.accept(id_or_tag)
		var result:Array
		result.append(Reward.new()._from_js(result[0]))
		result.append(PlayerReward.new()._from_js(result[1]))
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
	var reward = Reward.new()._from_js(args[0][0])
	var player_reward = PlayerReward.new()._from_js(args[0][1])
	reward_given.emit(reward, player_reward)
	
func _on_reward_error(args) -> void:
	reward_error.emit(args[0])

func _on_reward_accept_error(args) -> void:
	reward_accept_error.emit(args[0])
	
func _on_reward_accepted(args) -> void:
	var reward = Reward.new()._from_js(args[0][0])
	var player_reward = PlayerReward.new()._from_js(args[0][1])
	reward_accepted.emit(reward, player_reward)
	
	
class Reward:
	var id: int
	var tag: String
	var name: String
	var description: String
	var icon: String
	var icon_small: String
	var mutations: Array # This will hold DataMutation objects
	var is_auto_accept: bool

	# Function to convert from JS object to GDScript object
	func _from_js(js_object: Dictionary) -> Reward:
		id = js_object["id"]
		tag = js_object["tag"]
		name = js_object["name"]
		description = js_object["description"]
		icon = js_object["icon"]
		icon_small = js_object["iconSmall"]
		is_auto_accept = js_object["isAutoAccept"]
		mutations = []
		var _mutations = js_object["mutations"]
		_mutations.forEach(JavaScriptBridge.create_callback(func (m): DataMutation.new()._from_js(m)))
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
	var reward_id: int
	var count_total: int
	var count_accepted: int

	# Function to convert from JS object to GDScript object
	func _from_js(js_object: Dictionary) -> PlayerReward:
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
	var type: String #TODO need test
	var key: String
	var action: String
	var value: Variant # Supports number, string, or boolean

	# Function to convert from JS object to GDScript object
	func _from_js(js_object: Dictionary) -> DataMutation:
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
