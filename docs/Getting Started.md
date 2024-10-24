# Getting Started with Godot

> The GamePush plugin for Godot supports versions 4.0 and higher.

## Plugin Installation

1. Install the plugin via the Godot Asset Library or by downloading the project folder from GitHub.

2. Go to the plugin panel in the project settings: `Project -> Project Settings -> Plugins`, and enable the GamePush plugin.
![Enable plugin](image-1.png)

## Project Setup

1. Go to the plugin configuration panel: `Project -> Project Settings -> Game Push -> Config`.
![Plugin settings](image.png)

2. In the plugin settings, enter the public key (`token`) and project ID (`Project ID`) from the GamePush dashboard.
3. If you want to display an ad immediately when the game opens, check the `Is Preloader Show` option.
4. If you want the GameReady event to trigger automatically right after the plugin initialization, set the delay to 0. If you want to delay the GameReady event, specify the delay in seconds. If you want to disable automatic triggering of the GameReady event, set any negative value.
5. If you want to automatically archive your web build, check the `Is Archive` option. You can also specify the name of the archive.
> To ensure proper archiving, make sure that there are no files in the export folder except for the archive and project files. That is, the folder should be empty before the first export.

## Usage

You have access to the singleton `GP`, which contains the GamePush modules. You can access the modules through the singleton from any script in your project.

### Initialization

To use the plugin, you need to wait for the GamePush library to initialize. Subscribe to the `GP.init(success: bool)` signal.

#### Example of waiting for initialization

```gdscript
func _ready():
    # If the GamePush plugin has already loaded before this scene's initialization
	if GP.is_inited:
		go_to_main_scene()
		return
	GP.inited.connect(go_to_main_scene)

func go_to_main_scene(_is_success_init: bool = false):
	# Switch to the main scene of the project, for example, the main menu
	get_tree().change_scene_to_file("res://path/to/your/scene.tscn")
```
### Displaying Rewarded Ads

```gdscript
func _ready():
	GP.Ads.rewarded_reward.connect(add_25_coins)
	GP.Ads.rewarded_close.connect(func(success):
		if !success:
			GP.Logger.log("Close ads without reward"))

func add_25_coins():
    # Upon successfully watching the ad, the player receives 25 coins
	GP.Player.add_value("coins", 25)

func show_reward_ad():
    # Show the rewarded video ad
    # The 'true' parameter enables the countdown display before the video starts
	GP.Ads.show_rewarded_video(true)
```

## Notes
1. The plugin comes with a demo project that shows examples of how to use the plugin methods.
2. The plugin closely follows the structure of the JS library, so you can refer to the documentation for better understanding.