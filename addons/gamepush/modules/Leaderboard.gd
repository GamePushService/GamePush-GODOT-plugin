extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var leaderboard:JavaScriptObject

signal after_ready
signal opened
signal closed
signal fetched(result:Dictionary)
signal fetched_scoped(result:Dictionary)
signal fetched_player_rating(result:Dictionary)
signal fetched_player_rating_scoped(result:Dictionary)


var _callback_open := JavaScriptBridge.create_callback(_open)
var _callback_close := JavaScriptBridge.create_callback(_close)

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		gp = GP.gp
		while not gp:
			gp = GP.gp
			await get_tree().create_timer(0.01).timeout
		leaderboard = gp.leaderboard
		leaderboard.on("open", _callback_open)
		leaderboard.on("close", _callback_close)
	after_ready.emit()

func open(order_by:Array = [], order:String = "", limit:int = 0,
 include_fields:Array = [], display_fields:Array = [],
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

func fetch(order_by:Array=[], order:String="", limit:int=0,
 include_fields:Array=[], display_fields:Array=[],
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

func fetch_player_rating(order_by:Array=[], order:String="",
 include_fields:Array=[], show_nearest:int=0):
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
 include_fields:Array = [], display_fields:Array = [],
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
 include_fields:Array = [], with_me:String = '', show_nearest:int = 0):
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

func fetch_player_rating_scoped(variant:String, id:int =0, tag:String ="", order_by:Array=[], order:String="",
 include_fields:Array=[], show_nearest:int=0):
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


signal _lb_inited

func set_yandex_lb_score(leaderboardName:String, score:int, extraData:String="") -> void:
	if OS.get_name() == "Web" and GP.Platform.type() == "Yandex":
		var yandex_sdk = GP.Platform.get_nativ_SDK()
		var lb
		yandex_sdk.getLeaderboards().then(JavaScriptBridge.create_callback(func(args):
			lb = args[0]
			_lb_inited.emit()
			))
		await _lb_inited
		lb.setLeaderboardScore(leaderboardName, score, extraData)


func _open(args): opened.emit()
func _close(args): closed.emit()
func _fetch(args):
	fetched.emit(GP._js_to_dict(args[0]))
func _fetch_scoped(args):
	fetched_scoped.emit(GP._js_to_dict(args[0]))
func _fetch_player_rating(args):
	fetched_player_rating.emit(GP._js_to_dict(args[0]))
func _fetch_player_rating_scoped(args):
	fetched_player_rating_scoped.emit(GP._js_to_dict(args[0]))
