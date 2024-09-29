extends Node

var Achievements:Node
var Ads:Node
var Analytics:Node
var App:Node
var AvatarGenerator:Node
var Channels:Node
var Custom:Node
var Device:Node
var Documents:Node
var Events:Node
var Experiments:Node
var Fullscreen:Node
var Game:Node
var GamesCollections:Node
var Images:Node
var Language:Node 
var Leaderboard:Node
var LeaderboardScoped:Node
var Payments:Node
var Platform:Node
var Player:Node
var Players:Node
var Rewards:Node
var Schedulers:Node
var Segments:Node
var Server:Node
var Socials:Node
var System:Node
@onready var Triggers := preload("res://addons/gamepush/classes/Triggers.gd").new()
var Variables:Node
var Uniques:Node
var Storage:Node


func _ready():
	Achievements = await preload("res://addons/gamepush/classes/Achievements.gd").new()
	Ads = await preload("res://addons/gamepush/classes/Ads.gd").new()
	Analytics = await preload("res://addons/gamepush/classes/Analytics.gd").new()
	#App = await preload("res://addons/gamepush/classes/App.gd").new()
	#AvatarGenerator = await preload("res://addons/gamepush/classes/AvatarGenerator.gd").new()
	#Channels = await preload("res://addons/gamepush/classes/Channels.gd").new()
	#Custom = await preload("res://addons/gamepush/classes/Custom.gd").new()
	#Device = await preload("res://addons/gamepush/classes/Device.gd").new()
	#Documents = await preload("res://addons/gamepush/classes/Documents.gd").new()
	#Events = await preload("res://addons/gamepush/classes/Events.gd").new()
	#Experiments = await preload("res://addons/gamepush/classes/Experiments.gd").new()
	#Fullscreen = await preload("res://addons/gamepush/classes/Fullscreen.gd").new()
	#Game = await preload("res://addons/gamepush/classes/Game.gd").new()
	#GamesCollections = await preload("res://addons/gamepush/classes/GamesCollections.gd").new()
	#Images = await preload("res://addons/gamepush/classes/Images.gd").new()
	#Language = await preload("res://addons/gamepush/classes/Language.gd").new()
	#Leaderboard = await preload("res://addons/gamepush/classes/Leaderboard.gd").new()
	#LeaderboardScoped = await preload("res://addons/gamepush/classes/LeaderboardScoped.gd").new()
	#Payments = await preload("res://addons/gamepush/classes/Payments.gd").new()
	#Platform = await preload("res://addons/gamepush/classes/Platform.gd").new()
	#Player = await preload("res://addons/gamepush/classes/Player.gd").new()
	#Players = await preload("res://addons/gamepush/classes/Players.gd").new()
	#Rewards = await preload("res://addons/gamepush/classes/Rewards.gd").new()
	#Schedulers = await preload("res://addons/gamepush/classes/Schedulers.gd").new()
	#Segments = await preload("res://addons/gamepush/classes/Segments.gd").new()
	#Server = await preload("res://addons/gamepush/classes/Server.gd").new()
	#Socials = await preload("res://addons/gamepush/classes/Socials.gd").new()
	#System = await preload("res://addons/gamepush/classes/System.gd").new()
	Triggers = await preload("res://addons/gamepush/classes/Triggers.gd").new()
	#Variables = await preload("res://addons/gamepush/classes/Variables.gd").new()
	#Uniques = await preload("res://addons/gamepush/classes/Uniques.gd").new()
	#Storage = await preload("res://addons/gamepush/classes/Storage.gd").new()


	add_child(Achievements)
	add_child(Ads)
	add_child(Analytics)
	add_child(Triggers)
	
