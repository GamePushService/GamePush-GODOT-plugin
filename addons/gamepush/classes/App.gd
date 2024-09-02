extends Node

var window:JavaScriptObject
var gp:JavaScriptObject
var app:JavaScriptObject

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Web":
		window = JavaScriptBridge.get_interface("window")
		while not gp:
			gp = window.gp
			await get_tree().create_timer(0.1).timeout
		app = gp.app
		
func title():
	if OS.get_name() == "Web":
		return app.title
	push_warning("Not Web")
	
func description():
	if OS.get_name() == "Web":
		return app.description
	push_warning("Not Web")
	
func image():
	# Return url? need test
	if OS.get_name() == "Web":
		return app.image
	push_warning("Not Web")
	
func url():
	if OS.get_name() == "Web":
		return app.url
	push_warning("Not Web")

func request_review():
	if OS.get_name() == "Web":
		var result:Dictionary = {"success": null, "rating": null, "error": null}
		var js_result = await app.requestReview()
		result["success"] = js_result["success"] # bool true/false
		result["rating"] = js_result["rating"] # int 0-5
		result["error"] = js_result["error"] # String 
		return result
	push_warning("Not Web")
	
func can_request_review():
	if OS.get_name() == "Web":
		return app.canRequestReview
	push_warning("Not Web")
	
func is_already_reviewed():
	if OS.get_name() == "Web":
		return app.isAlreadyReviewed
	push_warning("Not Web")

func add_shortcut():
	if OS.get_name() == "Web":
		return await app.addShortcut() #true/false
	push_warning("Not Web")

func can_add_shortcut():
	if OS.get_name() == "Web":
		return app.canAddShortcut #true/false
	push_warning("Not Web")
