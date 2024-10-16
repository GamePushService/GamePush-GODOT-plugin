# GamePush-GODOT-plugin

Plugin for using [GamePush](https://gamepush.com/?r=NzQ4) in Godot games

Development of GamePush Godot plugin - [Anatoly Kulagin](https://github.com/talkafk)


## Get started:


## Documentation:

### English:

https://docs.gamepush.com/docs/get-start/

### Russian:

https://docs.gamepush.com/ru/docs/get-start/


## Modules
| Plugin modules                                |
| --------------------------------------------- |
| [Achievements](#achievements)                 |
| [Ads](#ads)                                   |
| [Analytics](#analytics)                       |
| [App](#app)                                   |
| [Avatar Generator](#avatargenerator)          |
| [Channels](#channels)                         |
| [Device](#device)                             |
| [Documents](#documents)                       |
| [Events](#events)                             |
| [Experiments](#experiments)                   |
| [Files](#files)                               |
| [Fullscreen](#fullscreen)                     |
| [Game](#game)                                 |
| [GamesCollections](#gamescollections)         |
| [Images](#images)                             |
| [Language](#language)                         |
| [Leaderboard](#leaderboard)                   |
| [LeaderboardScoped](#leaderboardscoped)       |
| [Logger](#logger)                             |
| [Payments](#payments)                         |
| [Platform](#platform)                         |
| [Player](#player)                             |
| [Players](#players)                           |
| [Rewards](#rewards)                           |
| [Schedulers](#schedulers)                     |
| [Segments](#segments)                         |
| [Server](#server)                             |
| [Socials](#socials)                           |
| [System](#system)                             |
| [Triggers](#triggers)                         |
| [Variables](#variables)                       |
| [Uniques](#uniques)                           |
| [Storage](#storage)                           |



### Achievements

#### Signals

| **Signal**          | **Emitted Parameters**                        |
|---------------------|-----------------------------------------------|
| `unlocked`          | `achievement: Achievement`                    |
| `error_unlock`      | `error: String`                               |
| `progress`          | `achievement: Achievement`                    |
| `error_progress`    | `error: String`                               |
| `opened`            | None                                          |
| `closed`            | None                                          |
| `fetched`           | `achievement: Array[Achievement]`, `achievements_groups: Array[AchievementsGroup]`, `player_achievements: Array[PlayerAchievement]` |
| `error_fetch`       | `error: String`                               |

#### Methods

| **Method**          | **Arguments**                 | **Return Type**   |
|---------------------|-------------------------------|-------------------|
| `unlock`            | `id: int`, `tag: String`      | `void`            |
| `set_progress`      | `progress: int`, `id: int`, `tag: String` | `void`    |
| `has`               | `id_or_tag: Variant`          | `bool`            |
| `get_progress`      | `id_or_tag: Variant`          | `int`             |
| `open`              | None                          | `void`            |
| `fetch`             | None                          | `void`            |
| `list`              | None                          | `Array[Achievement]` |
| `player_achievements_list` | None                  | `Array[PlayerAchievement]` |
| `groups_list`       | None                          | `Array[AchievementsGroup]` |


#### Classes

##### Achievement

| **Property**        | **Type**      |
|---------------------|---------------|
| `id`                | `int`         |
| `tag`               | `String`      |
| `name`              | `String`      |
| `description`       | `String`      |
| `icon`              | `String`      |
| `icon_small`        | `String`      |
| `locked_icon`       | `String`      |
| `locked_icon_small` | `String`      |
| `rare`              | `String`      |
| `max_progress`      | `int`         |
| `progress_step`     | `int`         |
| `is_locked_visible` | `bool`        |
| `is_locked_description_visible` | `bool` |

##### AchievementsGroup

| **Property**        | **Type**      |
|---------------------|---------------|
| `id`                | `int`         |
| `tag`               | `String`      |
| `name`              | `String`      |
| `description`       | `String`      |
| `achievements`      | `Array`       |

##### PlayerAchievement

| **Property**        | **Type**      |
|---------------------|---------------|
| `achievement_id`    | `int`         |
| `created_at`        | `String`      |
| `progress`          | `int`         |
| `unlocked`          | `bool`        |

### Ads


#### Signals

| **Signal**               | **Emitted Parameters**    |
|--------------------------|------------------|
| `start`                  | None             |
| `close`                  | `success: bool`  |
| `fullscreen_start`       | None             |
| `fullscreen_close`       | `success: bool`  |
| `preloader_start`        | None             |
| `preloader_close`        | `success: bool`  |
| `rewarded_start`         | None             |
| `rewarded_close`         | `success: bool`  |
| `rewarded_reward`        | None             |
| `sticky_start`           | None             |
| `sticky_close`           | None             |
| `sticky_render`          | None             |
| `sticky_refresh`         | None             |

#### Methods

| **Method**                                | **Arguments**                            | **Return Type** |
|-------------------------------------------|------------------------------------------|-----------------|
| `is_adblock_enabled`                      | None                                     | `bool`          |
| `is_sticky_available`                     | None                                     | `bool`          |
| `is_fullscreen_available`                 | None                                     | `bool`          |
| `is_rewarded_available`                   | None                                     | `bool`          |
| `is_sticky_playing`                       | None                                     | `bool`          |
| `is_fullscreen_playing`                   | None                                     | `bool`          |
| `is_rewarded_playing`                     | None                                     | `bool`          |
| `is_preloader_playing`                    | None                                     | `bool`          |
| `is_countdown_overlay_enabled`            | None                                     | `bool`          |
| `is_rewarded_failed_overlay_enabled`      | None                                     | `bool`          |
| `can_show_fullscreen_before_game_play`    | None                                     | `bool`          |
| `show_fullscreen`                         | `show_countdown_overlay: bool = false`   | `void`          |
| `show_preloader`                          | None                                     | `void`          |
| `show_rewarded_video`                     | `show_countdown_overlay: bool = false`   | `void`          |
| `show_sticky`                             | None                                     | `void`          |
| `refresh_sticky`                          | None                                     | `void`          |
| `close_sticky`                            | None                                     | `void`          |

### Analytics

#### Methods

| **Method**          | **Arguments**                               | **Return Type** |
|---------------------|---------------------------------------------|-----------------|
| `hit`               | `url: String`                               | `void`          |
| `goal`              | `name: String, value: Variant = null`       | `void`          |

### App

#### Signals

| **Signal**            | **Emitted Parameters**                        |
|-----------------------|--------------------------------------|
| `review_requested`     | `success: bool, rating: int, error: String` |
| `shortcut_added`       | `success: bool`                     |

#### Methods

| **Method**                | **Arguments**                  | **Return Type** |
|---------------------------|-------------------------------|-----------------|
| `title()`                 | `None`                        | `String`        |
| `description()`           | `None`                        | `String`        |
| `image()`                 | `None`                        | `String`        |
| `url()`                   | `None`                        | `String`        |
| `request_review()`        | `None`                        | `void`          |
| `can_request_review()`    | `None`                        | `bool`          |
| `is_already_reviewed()`   | `None`                        | `bool`          |
| `add_shortcut()`          | `None`                        | `void`          |
| `can_add_shortcut()`      | `None`                        | `bool`          |


### AvatarGenerator

#### Methods

| **Method**                 | **Arguments**                  | **Return Type** |
|----------------------------|-------------------------------|-----------------|
| `current()`                | `None`                        | `String`        |
| `generate_avatar(has, size)`| `has: Variant, size: int`     | `String`        |

### Channels

### Device

#### Signals

| **Signal Name**      |  **Emitted Parameters**     |    
|----------------------|-----------------------------|
| `change_orientation` | `is_portrait: bool`         |

#### Methods

| **Method Name**           | **Arguments**      | **Return Type** |
|---------------------------|--------------------|-----------------|
| `is_mobile`               | None               | `bool`          |
| `is_portrait`             | None               | `bool`          |

### Documents

#### Signals

| **Signal Name**    |  **Emitted Parameters**   |
|--------------------|---------------------------|
| `opened`           | None                      |
| `closed`           | None                      |
| `fetched`          | `document: Dictionary` |
| `error_fetch`      | `error: String`           |

#### Methods

| **Method Name**     | **Arguments**                                  | **Return Type** |
|---------------------|------------------------------------------------|-----------------|
| `ready`             | None                                           | `void`          |
| `open`              | `type: String`                                 | `void`          |
| `fetch`             | `type: String`, `format: String = "HTML"`      | `void`          |

### Events

#### Signals

| **Signal Name**    | **Emitted Parameters**                                 |
|--------------------|-----------------------------------------------|
| `joined`           | `event: Event`, `player_event: PlayerEvent`   |
| `error_join`       | `error: String`                               |

#### Methods

| **Method Name**     | **Arguments**                                         | **Return Type**  |
|---------------------|-------------------------------------------------------|------------------|
| `join`              | `id: int = 0`, `tag: String = ""`                     | `void`           |
| `list`              | None                                                  | `Array`          |
| `active_list`       | None                                                  | `Array`          |
| `get_event`         | `id_or_tag: String`                                   | `Event`          |
| `has`               | `id_or_tag: String`                                   | `bool`           |
| `is_joined`         | `id_or_tag: String`                                   | `bool`           |

#### Classes

##### Event

| **Property Name**    | **Type**  |
|----------------------|-----------|
| `id`                 | `int`     |
| `tag`                | `String`  |
| `name`               | `String`  |
| `description`        | `String`  |
| `icon`               | `String`  |
| `icon_small`         | `String`  |
| `date_start`         | `String`  |
| `date_end`           | `String`  |
| `is_active`          | `bool`    |
| `time_left`          | `int`     |
| `is_auto_join`       | `bool`    |
| `triggers`           | `Array`   |


##### PlayerEvent 

| **Property Name**    | **Type**  |
|----------------------|-----------|
| `event_id`           | `int`     |
| `stats`              | `PlayerStats` |


##### PlayerStats 

| **Property Name**        | **Type**  |
|--------------------------|-----------|
| `active_days`            | `int`     |
| `active_days_consecutive`| `int`     |

### Experiments

#### Methods

| **Method** | **Arguments** | **Return Type** |
|------------|---------------|-----------------|
| `map`      | None          | `Dictionary` |
| `has`      | `tag: String`, `cohort: String` | `bool` |

### Files 

### Fullscreen

#### Signals

| **Signal**     | **Emitted Parameters**  |
|----------------|----------------|
| `opened`       | None           |
| `closed`       | None           |
| `changed`      | None           |

#### Methods

| **Method**     | **Arguments**  | **Return Type** |
|----------------|----------------|-----------------|
| `open`         | None           | `void`          |
| `close`        | None           | `void`          |
| `toggle`       | None           | `void`          |
| `is_enabled`   | None           | `bool`          |

### Game

### Signals

| **Signal**  | **Emitted Parameters** |
|-------------|------------------------|
| `paused`    | None                   |
| `resumed`   | None                   |

### Methods

| **Method**          | **Arguments**    | **Return Type** |
|---------------------|------------------|-----------------|
| `is_paused`       | `None`           | `bool`          | 
| `pause`           | `None`           | `void`          |
| `resume`          | `None`           | `void`          |
| `game_start`      | `None`           | `void`          |
| `gameplay_start`  | `None`           | `void`          |
| `gameplay_stop`   | `None`           | `void`          |

### GamesCollections

### Images

### Language

#### Methods

| **Method** | **Arguments**          | **Return Type** |
|------------|------------------------|-----------------|
| `current`  | None                   | `String`        |
| `change`   | `lang: String`         | `void`          |

### Leaderboard

### LeaderboardScoped

### Logger

#### Methods

| **Method Name**  | **Arguments**                               | **Return Type** |
|------------------|---------------------------------------------|-----------------|
| `info`           | `arg1`, `arg2`, `arg3`, `arg4`              | `void`          |
| `warn`           | `arg1`, `arg2`, `arg3`, `arg4`              | `void`          |
| `error`          | `arg1`, `arg2`, `arg3`, `arg4`              | `void`          |
| `log`            | `arg1`, `arg2`, `arg3`, `arg4`              | `void`          |
| `info_array`     | `args: Array`                               | `void`          |
| `warn_array`     | `args: Array`                               | `void`          |
| `error_array`    | `args: Array`                               | `void`          |


### Payments

#### Signals

| **Signal**         | **Emitted Parameters**                                           |
|--------------------|------------------------------------------------------------------|
| `purchased`        | `result: Array`                                                 |
| `error_purchase`   | `error: String`                                                 |
| `consumed`         | `result: Array`                                                 |
| `error_consume`    | `error: String`                                                 |
| `fetched_products` | `result: Array`                                                 |
| `error_fetch_products` | `error: String`                                             |

#### Methods

| **Method Name**                | **Arguments**                         | **Return Type**  |
|---------------------------------|---------------------------------------|------------------|
| `ready`                         | None                                  | `void`           |
| `is_available`                  | None                                  | `bool`           |
| `consume`                       | `id :int , tag :String`               | `Array`          |
| `purchase`                      | `id :int , tag :String`               | `Array`          |
| `get_products`                  | None                                  | `Array`          |
| `get_purchases`                 | None                                  | `Array`          |
| `fetch_products`                | None                                  | `void`           |
| `is_subscriptions_available`    | None                                  | `bool`           |
| `subscribe`                     | `id :int , tag :String`               | `void`           |
| `unsubscribe`                   | `id :int , tag :String`               | `void`           |

#### Classes

##### Purchase

| **Variable**        | **Type**           |
|---------------------|--------------------|
| `id`                | `int`              |
| `tag`               | `String`           |
| `name`              | `String`           |
| `description`       | `String`           |
| `icon`              | `String`           |
| `icon_small`        | `String`           |
| `price`             | `String`           |
| `currency`          | `String`           |
| `currency_symbol`   | `String`           |
| `is_subscription`   | `String`           |
| `period`            | `int`              |
| `trial_period`      | `int`              |

##### PlayerPurchase

| **Variable**        | **Type**             |
|---------------------|----------------------|
| `product_id`        | `int`                |
| `payload`           | `Dictionary`         |
| `created_at`        | `String`             |
| `gift`              | `bool`               |
| `subscribed`        | `bool`               |
| `expired_at`        | `String`             |


### Platform

#### Methods

| Method name                          | Arguments                     | Return Type          |
|---------------------------------|-------------------------------|----------------------|
| `type`                          | None                          | `String`             |
| `has_integrated_auth`           | None                          | `bool`               |
| `is_logout_available`           | None                          | `bool`               |
| `is_external_links_allowed`     | None                          | `bool`               |
| `is_secret_code_auth_available` | None                          | `bool`               |
| `get_SDK`                      | None                          | `JavaScriptObject`   |
| `get_native_SDK`               | None                          | `JavaScriptObject`   |


### Player

#### Signals
| Signal                 | Emitted Parameters                                     |
|------------------------|-------------------------------------------------------|
| `synced`               | `success_status: bool`                                |
| `loaded`               | `success_status: bool`                                |
| `logged_in`            | `success_status: bool`                                |
| `logged_out`           | `success_status: bool`                                |
| `fields_fetched`       | `success_status: bool`                             |
| `window_connected`     | `None`                                                |
| `player_state_changed` | `None`                                                |
| `field_maximum_reached`| `field: Field`                                        |
| `field_minimum_reached`| `field: Field`                                        |
| `field_incremented`    | `field: Field, old_value: Variant, new_value: Variant`|

#### Methods

| **Method Name**         | **Arguments**                                      | **Return Type**        |
|-------------------------|---------------------------------------------------|------------------------|
| `get_id`                | None                                               | `Variant`              |
| `get_score`             | None                                               | `Variant`              |
| `get_player_name`              | None                                               | `String`               |
| `get_avatar`            | None                                               | `String`               |
| `is_stub`               | None                                               | `bool`                 |
| `is_logged_in`          | None                                               | `bool`                 |
| `has_any_credentials`   | None                                               | `bool`                 |
| `is_ready`              | None                                               | `Variant`              |
| `sync`                  | `override: Variant = null`, `storage: Variant = null` | `void`                 |
| `enable_auto_sync`      | `interval: int = 30`, `storage: String = "preferred"` | `void`                 |
| `disable_auto_sync`     | `storage: String = "preferred"`                    | `void`                 |
| `load`                  | None                                               | `void`                 |
| `login`                 | None                                               | `void`                 |
| `logout`                | None                                               | `void`                 |
| `fetch_fields`          | None                                               | `void`                 |
| `get_value`             | `key: String`                                      | `Variant`              |
| `set_value`             | `key: String`, `value: Variant`                    | `void`                 |
| `add_value`             | `key: String`, `value: Variant`                    | `void`                 |
| `toggle`                | `key: String`                                      | `void`                 |
| `has`                   | `key: String`                                      | `bool`                 |
| `to_json`               | None                                               | `Dictionary`           |
| `from_json`             | `data: Dictionary`                                 | `void`                 |
| `reset`                 | None                                               | `void`                 |
| `remove`                | None                                               | `void`                 |
| `get_min_value`         | `key: String`                                      | `int`                  |
| `set_min_value`         | `key: String`, `value: Variant`                    | `void`                 |
| `get_max_value`         | `key: String`                                      | `int`                  |
| `set_max_value`         | `key: String`, `value: Variant`                    | `void`                 |
| `get_active_days`       | None                                               | `int`                  |
| `get_active_days_consecutive`| None                                          | `int`                  |
| `get_playtime_today`    | None                                               | `int`                  |
| `get_playtime_all`      | None                                               | `int`                  |
| `get_field`             | `key: String`                                      | `Field`                |
| `get_field_name`        | `key: String`                                      | `String`               |
| `get_field_variant_name`| `key: String`, `value: Variant`                    | `String`               |


#### Classes

##### Field

| Variable              | Type                     |
|-----------------------|--------------------------|
| `name`                | `String`                 |
| `key`                 | `String`                 |
| `type`                | `String`                 |  # 'stats' | 'data' | 'flag' | 'service' | 'accounts'
| `important`           | `bool`                   |
| `public`              | `bool`                   |
| `default_value`       | `Variant`                |  # String, int, bool
| `variants`            | `Array[FieldVariant]`    | 
| `limits`              | `FieldLimits` or `null`  |
| `interval_increment`   | `IntervalIncrement` or `null` |

##### FieldVariant

| Variable              | Type                     |
|-----------------------|--------------------------|
| `name`                | `String`                 |
| `value`               | `Variant`                |  # String, int или bool

##### FieldLimits

| Variable              | Type                     |
|-----------------------|--------------------------|
| `min`                 | `float`                  |
| `max`                 | `float`                  |
| `could_go_over_limit` | `bool`                   |

##### IntervalIncrement

| Variable              | Type                     |
|-----------------------|--------------------------|
| `interval`            | `float`                  |
| `increment`           | `float`                  |

### Players

### Rewards

### Schedulers

### Segments

#### Signals

| **Signal** | **Emitted Parameters** |
|------------|------------------------|
| `entered`  | `segment_tag: String`  |
| `left`     | `segment_tag: String`  |

#### Methods

| **Method Name** | **Arguments**            | **Return Type** |
|-----------------|--------------------------|-----------------|
| `list`          | None                     | `Array`         |
| `has`           | `tag: String`            | `bool`          |


### Server

#### Methods

| **Method Name** | **Arguments** | **Return Type** |
|-----------------|---------------|-----------------|
| `time`          | None          | `String`        |


### Socials

### System

### Triggers

### Variables

### Uniques

### Storage