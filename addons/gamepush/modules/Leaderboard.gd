extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var leaderboard:JavaScriptObject

signal opened
signal closed
signal fetched(players:Array[Dictionary], fields:Array[Dictionary],
 top_players:Array[Dictionary], above_players:Array[Dictionary],
belowPlayers:Array[Dictionary], player:Dictionary)
signal fetched_scoped(players:Array[Dictionary], fields:Array[Dictionary],
 top_players:Array[Dictionary], above_players:Array[Dictionary],
belowPlayers:Array[Dictionary], player:Dictionary)
signal fetched_player_rating(player:Dictionary, fields:Array[Dictionary],
 above_players:Array[Dictionary], belowPlayers:Array[Dictionary])
signal fetched_player_rating_scoped(player:Dictionary, fields:Array[Dictionary],
 above_players:Array[Dictionary], belowPlayers:Array[Dictionary])


var _callback_open := JavaScriptBridge.create_callback(_open)
var _callback_close := JavaScriptBridge.create_callback(_close)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.1).timeout
		leaderboard = gp.leaderboard
		leaderboard.on("open", _callback_open)
		leaderboard.on("close", _callback_close)

func open(order_by:Array[String] = [], order:String = "", limit:int = 0,
 include_fields:Array[String] = [], display_fields:Array[String] = [],
 with_me:String = '', show_nearest:int = 0):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if order_by:
			var _order_by := JavaScriptBridge.create_object("Array")
			for t in order_by:
				_order_by.push(t)
			conf["orderBy"] = _order_by
		if order:
			conf['order'] = order
		if limit:
			conf['limit'] = limit
		if include_fields:
			var _include_fields := JavaScriptBridge.create_object("Array")
			for t in include_fields:
				_include_fields.push(t)
			conf["includeFields"] = _include_fields
		if display_fields:
			var _display_fields := JavaScriptBridge.create_object("Array")
			for t in display_fields:
				_display_fields.push(t)
			conf["displayFields"] = _display_fields
		if with_me:
			conf['withMe'] = with_me
		if show_nearest:
			conf['showNearest'] = show_nearest
		leaderboard.open(conf)
	else:
		push_warning("Not Web")
		
var _callback_fetch =JavaScriptBridge.create_callback(_fetch)

func fetch(order_by:Array[String]=[], order:String="", limit:int=0,
 include_fields:Array[String]=[], display_fields:Array[String]=[],
 with_me:String="", show_nearest:int=0):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if order_by:
			var _order_by := JavaScriptBridge.create_object("Array")
			for t in order_by:
				_order_by.push(t)
			conf["orderBy"] = _order_by
		if order:
			conf['order'] = order
		if limit:
			conf['limit'] = limit
		if include_fields:
			var _include_fields := JavaScriptBridge.create_object("Array")
			for t in include_fields:
				_include_fields.push(t)
			conf["includeFields"] = _include_fields
		if display_fields:
			var _display_fields := JavaScriptBridge.create_object("Array")
			for t in display_fields:
				_display_fields.push(t)
			conf["displayFields"] = _display_fields
		if with_me:
			conf['withMe'] = with_me
		if show_nearest:
			conf['showNearest'] = show_nearest
		leaderboard.fetch(conf).then(_callback_fetch)
	else:
		push_warning("Not Web")


var _callback_fetch_player_rating := JavaScriptBridge.create_callback(_fetch_player_rating)

func fetch_player_rating(order_by:Array[String]=[], order:String="",
 include_fields:Array[String]=[], show_nearest:int=0):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if order_by:
			var _order_by := JavaScriptBridge.create_object("Array")
			for t in order_by:
				_order_by.push(t)
			conf["orderBy"] = _order_by
		if order:
			conf['order'] = order
		if include_fields:
			var _include_fields := JavaScriptBridge.create_object("Array")
			for t in include_fields:
				_include_fields.push(t)
			conf["includeFields"] = _include_fields
		if show_nearest:
			conf['showNearest'] = show_nearest
		leaderboard.fetchPlayerRating(conf).then(_callback_fetch_player_rating)
	else:
		push_warning("Not Web")


func open_scoped(variant:String, id:int=0, tag:String="", order:String = "",
 limit:int = 0,
 include_fields:Array[String] = [], display_fields:Array[String] = [],
 with_me:String = '', show_nearest:int = 0):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		if tag:
			conf['tag'] = tag
		if variant:
			conf['variant'] = variant
		if order:
			conf['order'] = order
		if limit:
			conf['limit'] = limit
		if include_fields:
			var _include_fields := JavaScriptBridge.create_object("Array")
			for t in include_fields:
				_include_fields.push(t)
			conf["includeFields"] = _include_fields
		if display_fields:
			var _display_fields := JavaScriptBridge.create_object("Array")
			for t in display_fields:
				_display_fields.push(t)
			conf["displayFields"] = _display_fields
		if with_me:
			conf['withMe'] = with_me
		if show_nearest:
			conf['showNearest'] = show_nearest
		leaderboard.openScoped(conf)
	else:
		push_warning("Not Web")

func publish_record(variant:String, record:Dictionary, id:int=0, tag:String="", 
 override = null):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		if tag:
			conf['tag'] = tag
		if variant:
			conf['variant'] = variant
		if override != null:
			conf["override"] = override
		var records = JavaScriptBridge.create_object("Object")
		for r in record:
			records[r] = record[r]
		conf["record"] = records
		leaderboard.publishRecord(conf)
	else:
		push_warning("Not Web")

var _callback_fetch_scoped =JavaScriptBridge.create_callback(_fetch_scoped)

func fetch_scoped(variant:String, id:int=0, tag:String="", order:String = "",
 limit:int = 0,
 include_fields:Array[String] = [], with_me:String = '', show_nearest:int = 0):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		if tag:
			conf['tag'] = tag
		if variant:
			conf['variant'] = variant
		if order:
			conf['order'] = order
		if limit:
			conf['limit'] = limit
		if include_fields:
			var _include_fields := JavaScriptBridge.create_object("Array")
			for t in include_fields:
				_include_fields.push(t)
			conf["includeFields"] = _include_fields
		if with_me:
			conf['withMe'] = with_me
		if show_nearest:
			conf['showNearest'] = show_nearest
		leaderboard.fetchScoped(conf).then(_callback_fetch_scoped)
	else:
		push_warning("Not Web")


var _callback_fetch_player_rating_scoped := JavaScriptBridge.create_callback(_fetch_player_rating_scoped)

func fetch_player_rating_scoped(variant:String, id:int =0, tag:String ="", order_by:Array[String]=[], order:String="",
 include_fields:Array[String]=[], show_nearest:int=0):
	if OS.get_name() == "Web":
		var conf := JavaScriptBridge.create_object("Object")
		if id:
			conf['id'] = id
		if tag:
			conf['tag'] = tag
		if variant:
			conf['variant'] = variant
		if order_by:
			var _order_by := JavaScriptBridge.create_object("Array")
			for t in order_by:
				_order_by.push(t)
			conf["orderBy"] = _order_by
		if order:
			conf['order'] = order
		if include_fields:
			var _include_fields := JavaScriptBridge.create_object("Array")
			for t in include_fields:
				_include_fields.push(t)
			conf["includeFields"] = _include_fields
		if show_nearest:
			conf['showNearest'] = show_nearest
		leaderboard.fetchPlayerRatingScoped(conf).then(_callback_fetch_player_rating_scoped)
	else:
		push_warning("Not Web")



func _open(args): opened.emit()
func _close(args): closed.emit()
func _fetch(args):
	var players: Array[Dictionary] = []
	var callback_players := JavaScriptBridge.create_callback(func(args):
		players.append(GP._js_to_dict(args[0].players)))
	args[0].players.forEach(callback_players)
	
	var fields: Array[Dictionary] = []
	var callback_fields := JavaScriptBridge.create_callback(func(args):
		fields.append(GP._js_to_dict(args[0].fields)))
	args[0].fields.forEach(callback_fields)

	var top_players: Array[Dictionary] = []
	var callback_top_players := JavaScriptBridge.create_callback(func(args):
		top_players.append(GP._js_to_dict(args[0].topPlayers)))
	args[0].topPlayers.forEach(callback_top_players)
	
	var above_players: Array[Dictionary] = []
	var callback_above_players := JavaScriptBridge.create_callback(func(args):
		above_players.append(GP._js_to_dict(args[0].abovePlayers)))
	args[0].abovePlayers.forEach(callback_above_players)
	
	var below_players: Array[Dictionary] = []
	var callback_below_players := JavaScriptBridge.create_callback(func(args):
		below_players.append(GP._js_to_dict(args[0].belowPlayers)))
	args[0].belowPlayers.forEach(callback_below_players)
	
	var player = GP._js_to_dict(args[0].player)
	
	fetched.emit(players, fields, top_players, above_players, below_players, player)

func _fetch_scoped(args):
	var players: Array[Dictionary] = []
	var callback_players := JavaScriptBridge.create_callback(func(args):
		players.append(GP._js_to_dict(args[0].players)))
	args[0].players.forEach(callback_players)
	
	var fields: Array[Dictionary] = []
	var callback_fields := JavaScriptBridge.create_callback(func(args):
		fields.append(GP._js_to_dict(args[0].fields)))
	args[0].fields.forEach(callback_fields)

	var top_players: Array[Dictionary] = []
	var callback_top_players := JavaScriptBridge.create_callback(func(args):
		top_players.append(GP._js_to_dict(args[0].topPlayers)))
	args[0].topPlayers.forEach(callback_top_players)
	
	var above_players: Array[Dictionary] = []
	var callback_above_players := JavaScriptBridge.create_callback(func(args):
		above_players.append(GP._js_to_dict(args[0].abovePlayers)))
	args[0].abovePlayers.forEach(callback_above_players)
	
	var below_players: Array[Dictionary] = []
	var callback_below_players := JavaScriptBridge.create_callback(func(args):
		below_players.append(GP._js_to_dict(args[0].belowPlayers)))
	args[0].belowPlayers.forEach(callback_below_players)
	
	var player = GP._js_to_dict(args[0].player)
	
	fetched.emit(players, fields, top_players, above_players, below_players, player)



func _fetch_player_rating(args):
	var player = GP._js_to_dict(args[0].player)
	
	var fields: Array[Dictionary] = []
	var callback_fields := JavaScriptBridge.create_callback(func(args):
		fields.append(GP._js_to_dict(args[0].fields)))
	args[0].fields.forEach(callback_fields)
	
	var above_players: Array[Dictionary] = []
	var callback_above_players := JavaScriptBridge.create_callback(func(args):
		above_players.append(GP._js_to_dict(args[0].abovePlayers)))
	args[0].abovePlayers.forEach(callback_above_players)
	
	var below_players: Array[Dictionary] = []
	var callback_below_players := JavaScriptBridge.create_callback(func(args):
		below_players.append(GP._js_to_dict(args[0].belowPlayers)))
	args[0].belowPlayers.forEach(callback_below_players)
	
	fetched_player_rating.emit(player, fields, above_players, below_players)
	
func _fetch_player_rating_scoped(args):
	var player = GP._js_to_dict(args[0].player)
	
	var fields: Array[Dictionary] = []
	var callback_fields := JavaScriptBridge.create_callback(func(args):
		fields.append(GP._js_to_dict(args[0].fields)))
	args[0].fields.forEach(callback_fields)
	
	var above_players: Array[Dictionary] = []
	var callback_above_players := JavaScriptBridge.create_callback(func(args):
		above_players.append(GP._js_to_dict(args[0].abovePlayers)))
	args[0].abovePlayers.forEach(callback_above_players)
	
	var below_players: Array[Dictionary] = []
	var callback_below_players := JavaScriptBridge.create_callback(func(args):
		below_players.append(GP._js_to_dict(args[0].belowPlayers)))
	args[0].belowPlayers.forEach(callback_below_players)
	
	fetched_player_rating_scoped.emit(player, fields, above_players, below_players)
