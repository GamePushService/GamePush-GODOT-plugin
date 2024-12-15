extends Node

var window: JavaScriptObject
var gp: JavaScriptObject
var app: JavaScriptObject

signal after_ready

signal review_requested(success:bool, rating:int, error:String)
signal shortcut_added(sucess:bool)

func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		await _yield_until_app_ready()
	else:
		push_warning("Not running on Web")
	after_ready.emit()

func _yield_until_app_ready():
	gp = GP.gp
	while not gp:
		gp = GP.gp
		await get_tree().create_timer(0.01).timeout
	app = gp.app

func _get_app_property(property_name: String) -> Variant:
	if OS.get_name() == "Web" and app:
		return app[property_name]
	push_warning("Not running on Web")
	return null

func title() -> String:
	return _get_app_property("title")

func description() -> String:
	return _get_app_property("description")

func image() -> String:
	return _get_app_property("image")

func url() -> String:
	return _get_app_property("url")

var _callback_request_review = JavaScriptBridge.create_callback(_request_review)

func request_review() -> void:
	if OS.get_name() == "Web" and app:
		app.requestReview().then(_callback_request_review)
		return
	push_warning("Not running on Web")
	
func _request_review(args):
	review_requested.emit(args[0]["success"], args[0]["rating"], args[0]["error"])

func can_request_review() -> bool:
	return _get_app_property("canRequestReview")

func is_already_reviewed() -> bool:
	return _get_app_property("isAlreadyReviewed")

var _callback_add_shortcut = JavaScriptBridge.create_callback(_add_shortcut)

func add_shortcut() -> void:
	if OS.get_name() == "Web" and app:
		app.addShortcut().then(_callback_add_shortcut)
		return
	push_warning("Not running on Web")
	
func _add_shortcut(args):
	shortcut_added.emit(args[0])

func can_add_shortcut() -> bool:
	return _get_app_property("canAddShortcut")
