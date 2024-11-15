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
| [Logger](#logger)                             |
| [Payments](#payments)                         |
| [Platform](#platform)                         |
| [Player](#player-1)                           |
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
| `unlock`            | `id_or_tag: Variant`      | `void`            |
| `set_progress`      | `progress: int`, `id_or_tag: Variant` | `void`    |
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

#### Signals

| **Signal**                           | **Emitted Parameters**                       |
|--------------------------------------|----------------------------------------------|
| `event_message`                      | `message: Message`                           |
| `message_received`                   | `message: Message`                           |
| `message_sent`                       | `message: Message`                           |
| `message_error`                      | `error: String`                              |
| `message_edited`                     | `message: Message`                           |
| `error_edit_message`                 | `error: String`                              |
| `event_edit_message`                 | `message: Message`                           |
| `message_deleted`                    | `message: Message`                           |
| `error_delete_message`               | `error: String`                              |
| `event_delete_message`               | `message: Message`                           |
| `messages_fetched`                   | `result: Dictionary`                         |
| `error_fetch_messages`               | `error: String`                              |
| `fetched_more_messages`              | `result: Dictionary`                         |
| `error_fetch_more_messages`          | `error: String`                              |
| `channel_created`                    | `channel: Channel`                           |
| `error_create_channel`               | `error: String`                              |
| `channel_updated`                    | `channel: Channel`                           |
| `error_update_channel`               | `error: String`                              |
| `event_channel_updated`              | `channel: Channel`                           |
| `channel_deleted`                    | `channel: Channel`                           |
| `error_delete_channel`               | `error: String`                              |
| `event_channel_deleted`              | `channel: Channel`                           |
| `channel_fetched`                    | `channel: Channel`                           |
| `fetch_channel_error`                | `error: String`                              |
| `channels_fetched`                   | `channels: Array`, `can_load_more: bool`     |
| `fetch_channels_error`               | `error: String`                              |
| `more_channels_fetched`              | `channels: Array`, `can_load_more: bool`     |
| `fetch_more_channels_error`          | `error: String`                              |
| `chat_opened`                        | (None)                                       |
| `chat_closed`                        | (None)                                       |
| `chat_error`                         | `error: String`                              |
| `joined`                             | (None)                                       |
| `error_join`                         | `error: String`                              |
| `event_joined`                       | `member: Dictionary`                         |
| `join_request_received`              | `join_request: Dictionary`                   |
| `cancel_joined`                      | (None)                                       |
| `cancel_join_error`                  | `error: String`                              |
| `event_cancel_join`                  | `join_request: Dictionary`                   |
| `leave_successful`                   | (None)                                       |
| `leave_error`                        | `error: String`                              |
| `leave_event`                        | `member: Dictionary`                         |
| `kick_successful`                    | (None)                                       |
| `kick_error`                         | `error: String`                              |
| `members_fetched`                    | `members: Array`, `can_load_more: bool`      |
| `fetch_members_error`                | `error: String`                              |
| `fetch_more_members_success`         | `members: Array`, `can_load_more: bool`      |
| `fetch_more_members_error`           | `error: String`                              |
| `mute_success`                       | (None)                                       |
| `mute_error`                         | `error: String`                              |
| `event_mute`                         | `mute: Mute`                                 |
| `unmute_success`                     | (None)                                       |
| `unmute_error`                       | `error: String`                              |
| `event_unmute`                       | `unmute: Dictionary`                         |
| `sent_invite`                        | (None)                                       |
| `sent_invite_error`                  | `error: String`                              |
| `event_invite`                       | `invite: Dictionary`                         |
| `canceled_invite`                    | (None)                                       |
| `cancel_invite_error`                | `error: String`                              |
| `event_cancel_invite`                | `invite: Dictionary`                         |
| `accepted_invite`                    | (None)                                       |
| `error_accept_invite`                | `error: String`                              |
| `rejected_invite`                    | (None)                                       |
| `error_reject_invite`                | `error: String`                              |
| `event_reject_invite`                | `invite: Dictionary`                         |
| `fetched_invites`                    | `result: Dictionary`                         |
| `error_fetch_invites`                | `error: String`                              |
| `fetched_more_invites`               | `result: Dictionary`                         |
| `error_fetch_more_invites`           | `error: String`                              |
| `fetched_channel_invites`            | `result: Dictionary`                         |
| `error_fetch_channel_invites`        | `error: String`                              |
| `fetched_more_channel_invites`       | `result: Dictionary`                         |
| `error_fetch_more_channel_invites`   | `error: String`                              |
| `fetched_sent_invites`               | `result: Dictionary`                         |
| `error_fetch_sent_invites`           | `error: String`                              |
| `fetched_more_sent_invites`          | `result: Dictionary`                         |
| `error_fetch_more_sent_invites`      | `error: String`                              |

#### Methods

| **Method**               | **Arguments**           | **Return Type**      |
|----------------------|----------|-------------------------|
| `join`        | `channel_id: int`, `password: String = ""`            | `void`                                           |
| `leave`                         | `channel_id: int`                   | `void`                                           |
| `send_message`                  | `channel_id: int`, `text: String`   | `void`                                           |
| `send_personal_message`         | `player_id: int`, `text: String`, `tags: Array = []` | `void`                                           |
| `send_feed_message`             | `player_id: int`, `text: String`, `tags: Array = []` | `void`                                           |
| `edit_message`                  | `message_id: String`, `text: String`                                                                                                                         | `void`                                           |
| `delete_message`                | `message_id: String`                                                                                                                                        | `void`                                           |
| `fetch_messages`                | `channel_id: int`, `tags: Array`, `limit: int = 100`, `offset: int = 0`                                                                                      | `Dictionary` (contains `items`, `can_load_more`) |
| `fetch_personal_messages`       | `channel_id: int`, `tags: Array`, `limit: int = 100`, `offset: int = 0`                                                                                      | `Dictionary` (contains `items`, `can_load_more`) |
| `fetch_feed_messages`           | `channel_id: int`, `tags: Array`, `limit: int = 100`, `offset: int = 0`                                                                                      | `Dictionary` (contains `items`, `can_load_more`) |
| `fetch_more_messages`           | `channel_id: int`, `tags: Array`, `limit: int = 100`                                                                                                         | `Dictionary` (contains `items`, `can_load_more`) |
| `fetch_more_personal_messages`  | `player_id: int`, `tags: Array`, `limit: int = 100`                                                                                                          | `Dictionary` (contains `items`, `can_load_more`) |
| `fetch_more_feed_messages`      | `player_id: int`, `tags: Array`, `limit: int = 100`                                                                                                          | `Dictionary` (contains `items`, `can_load_more`) |
| `create_channel(channel: Channel)` | `channel: Channel`                                                                                                                 | `void` |
| `update_channel(channel: Channel)` | `channel: Channel`                                                                                                                 | `void` |
| `delete_channel(channel_id: int)`  | `channel_id: int`                                                                                                                  | `void` |
| `fetch_channel(channel_id: int)`   | `channel_id: int`                                                                                                                  | `Channel` |
| `fetch_channels(ids: Array, tags: Array, search: String = "", only_joined: bool = true, only_owned: bool = true, limit: int = 100, offset: int = 0)` | `ids: Array`, `tags: Array`, `search: String`, `only_joined: bool`, `only_owned: bool`, `limit: int`, `offset: int` | `Dictionary` |
| `fetch_more_channels(channel_id: int, tags: Array, limit: int = 100)` | `channel_id: int`, `tags: Array`, `limit: int`                                                                                     | `Dictionary` |
| `open_chat(channel_id: int = 0, tags: Array = [])` | `channel_id: int`, `tags: Array`                                                                                                       | `void`          |
| `is_main_chat_enabled()`                      | N/A                                                                                                                                  | `bool`          |
| `main_chat_id()`                              | N/A                                                                                                                                  | `int`           |
| `open_personal_chat(player_id: int, tags: Array)` | `player_id: int`, `tags: Array`                                                                                                       | `void`          |
| `open_feed(player_id: int, tags: Array)`      | `player_id: int`, `tags: Array`                                                                                                       | `void`          |
| `cancel_join(channel_id: int)`                | `channel_id: int`                                                                                                                     | `void`          |
| `kick(channel_id: int, player_id: int)`       | `channel_id: int`, `player_id: int`                                                                                                    | `void`          |
| `fetch_members(channel_id: int, search: String = "", only_online: bool = true, limit: int = 100, offset: int = 0)` | `channel_id: int`, `search: String`, `only_online: bool`, `limit: int`, `offset: int`                                                  | `void`          |
| `fetch_more_members(channel_id: int, search: String = "", only_online: bool = true, limit: int = 100)` | `channel_id: int`, `search: String`, `only_online: bool`, `limit: int`                                                                 | `void`          |
| `mute(channel_id: int, player_id: int, unmute_at: String)` | `channel_id: int`, `player_id: int`, `unmute_at: String`                                                                               | `void`          |
| `unmute(channel_id: int, player_id: int)`     | `channel_id: int`, `player_id: int`                                                                                                    | `void`          |
| `send_invite(channel_id: int, player_id: int)`     | `channel_id: int`, `player_id: int`                                                                                                   | `void`          |
| `cancel_invite(channel_id: int, player_id: int)`   | `channel_id: int`, `player_id: int`                                                                                                   | `void`          |
| `accept_invite(channel_id: int)`                    | `channel_id: int`                                                                                                                     | `void`          |
| `reject_invite(channel_id: int)`                    | `channel_id: int`                                                                                                                     | `void`          |
| `fetch_invites(limit: int, offset: int)`           | `limit: int`, `offset: int`                                                                                                          | `Dictionary`    |
| `fetch_more_invites(limit: int)`                    | `limit: int`                                                                                                                          | `Dictionary`    |
| `fetch_channel_invites(channel_id: int, limit: int, offset: int)` | `channel_id: int`, `limit: int`, `offset: int`                                                                                      | `Dictionary`    |
| `fetch_more_channel_invites(channel_id: int, limit: int)` | `channel_id: int`, `limit: int`                                                                                                      | `Dictionary`    |
| `fetch_sent_invites(limit: int, offset: int)`      | `limit: int`, `offset: int`                                                                                                          | `Dictionary`    |
| `fetch_more_sent_invites(limit: int)`               | `limit: int`                                                                                                                          | `Dictionary`    |
| `send_invite(channel_id: int, player_id: int)`          | `channel_id: int`, `player_id: int`                                                                                                    | `void`          |
| `cancel_invite(channel_id: int, player_id: int)`        | `channel_id: int`, `player_id: int`                                                                                                    | `void`          |
| `accept_invite(channel_id: int)`                         | `channel_id: int`                                                                                                                       | `void`          |
| `reject_invite(channel_id: int)`                         | `channel_id: int`                                                                                                                       | `void`          |
| `fetch_invites(limit: int, offset: int)`                | `limit: int`, `offset: int`                                                                                                            | `Dictionary`    |
| `fetch_more_invites(limit: int)`                         | `limit: int`                                                                                                                            | `Dictionary`    |
| `fetch_channel_invites(channel_id: int, limit: int, offset: int)` | `channel_id: int`, `limit: int`, `offset: int`                                                                                         | `Dictionary`    |
| `fetch_more_channel_invites(channel_id: int, limit: int)` | `channel_id: int`, `limit: int`                                                                                                        | `Dictionary`    |
| `fetch_sent_invites(limit: int, offset: int)`           | `limit: int`, `offset: int`                                                                                                            | `Dictionary`    |
| `fetch_more_sent_invites(limit: int)`                    | `limit: int`                                                                                                                            | `Dictionary`    |
| `accept_join_request(channel_id: int, player_id: int)`  | `channel_id: int`, `player_id: int`                                                                                                    | `void`          |
| `reject_join_request(channel_id: int, player_id: int)`  | `channel_id: int`, `player_id: int`                                                                                                    | `void`          |
| `fetch_join_requests(channel_id: int, limit: int, offset: int)` | `channel_id: int`, `limit: int`, `offset: int`                                                                                         | `void`          |
| `fetch_more_join_requests(channel_id: int, limit: int)`  | `channel_id: int`, `limit: int`                                                                                                        | `void`          |
| `fetch_sent_join_requests(limit: int, offset: int)`      | `limit: int`, `offset: int`                                                                                                            | `void`          |
| `fetch_more_sent_join_requests(limit: int)`               | `limit: int`                                                                                                                            | `void`          |


#### Classes

##### Message
| Property     | Type   |
|--------------|--------|
| id           | String |
| channel_id   | String |
| author_id    | String |
| text         | String |
| tags         | Array  |
| player       | Player |
| created_at   | int    |


##### Player
| Property | Type   |
|----------|--------|
| id       | String |
| name     | String |
| avatar   | String |

##### Channel
| Property         | Type       |
|------------------|------------|
| id               | int        |
| tags             | Array      |
| message_tags     | Array      |
| template_id      | String     |
| capacity         | int        |
| owner_id         | int        |
| name             | String     |
| description      | String     |
| private          | bool       |
| visible          | bool       |
| permanent        | bool       |
| has_password     | bool       |
| is_joined        | bool       |
| is_request_sent   | bool       |
| is_invited       | bool       |
| is_muted         | bool       |
| password         | String     |
| members_count    | int        |
| owner_acl        | Dictionary |
| member_acl       | Dictionary |
| guest_acl        | Dictionary |

##### Member 
| Property  | Type   |
|-----------|--------|
| id        | int    |
| is_online | bool   |
| state     | Player |
| mute      | Mute   |

##### Mute
| Property   | Type   |
|------------|--------|
| is_muted   | bool   |
| unmute_at  | String |

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
| `join`              | `id_or_tag: Variant`                                  | `void`           |
| `list`              | None                                                  | `Array`          |
| `active_list`       | None                                                  | `Array`          |
| `get_event`         | `id_or_tag: Variant`                                   | `Event`          |
| `has`               | `id_or_tag: Variant`                                   | `bool`           |
| `is_joined`         | `id_or_tag: Variant`                                   | `bool`           |

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

#### Signals

| **Signal**                     | **Emitted Parameters**    |
|----------------------------|-----------------------|
| `uploaded`                   | `file: File`             | 
| `error_upload`               | `err:Dictionary`           | 
| `loaded_content`             | None                  | 
| `error_load_content`         | `err:Dictionary`           | 
| `choosed`                    | `file:File, temp_url:String`              | 
| `error_choose`               | `err:Dictionary`           | 
| `fetched`                    | `result: Array`         | 
| `error_fetch`                | `err:Dictionary`           |
| `fetched_more`               | `result: Array`         | 
| `error_fetch_more`           | `err:Dictionary`           |

#### Methods
| **Method**                  | **Arguments**                                     | **Return Type** |
|-------------------------|------------------------------------------------|--------------|
| `upload`                  | `tags: Array`                                    | `void`         |
| `upload_url`              | `file_name:String, url:String, tags:Array=[]`                  | `void`         |
| `upload_content`          | `file_name: String`, `content: String=""`, `tags: Array= []` | void         |
| `load_content`            | `url: String`                                    | `String`       |
| `choose_file`             | `type_file: String=""`                           | `Array`        |
| `fetch`                   | `player_id: Variant=null`, `tags: Variant=null`, `limit: Variant=null`, `offset: Variant=null` | `Array`        |
| `fetch_more`              | `player_id: Variant=null`, `tags: Variant=null`, `limit: Variant=null`, `offset: Variant=null` | `Array`        |

#### Classes

##### File
| **Property**     | **Type**   |
|--------------|--------|
| `id`           | `String` |
| `player_id`    | `int`    |
| `name`         | `String` |
| `src`          | `String` |
| `size`         | `int`    |
| `tags`         | `Array`  |


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

#### Signals
| **Signal**               | **Emitted Parameters** | 
|----------------------|--------------------|
| `opened`               | None               | 
| `closed`               | None               | 
| `fetched`              | `rsdult:Dictionary` | 
| `error_fetch`          | `error: String`      |

#### Methods
| **Method**          | **Arguments**                                      | **Return Type** |
|-----------------|-------------------------------------------------|-------------|
| `open`            | `tag: String=""`, `id: int=0`, `share_params: Dictionary={}` | `void`        |
| `fetch`           | `tag: String=""`, `id: int=0`                       | `void`        |

#### Classes
##### Collection
| **Parameter**    | **Type**              |
|--------------|-------------------|
| `id`           | `int`               | 
| `tag`          | `String`            |
| `name`         | `String`            |
| `description`  | `String`            | 
| `games`        | `Array`             | 

##### Game

| **Parameter**    | **Type**              |
|--------------|-------------------|
| `id`           | `int`               |
| `name`         | `String`            | 
| `description`  | `String`            |
| `icon`         | `String`            | 
| `url`          | `String`            | 


### Images

#### Signals
| **Signal**             | **Emitted Parameters**       |
|--------------------|--------------------------|
| `uploaded`            | `image:GPImage`                  |
| `error_upload`        | `error:Dictionary`                   |
| `choosed`             | `image:GPImage, temp_url:String`                   |
| `error_choose`        | `error:Dictionary`                   |
| `fetched`             | `result:Array`                    |
| `error_fetch`         | `error:Dictionary`                   |
| `fetched_more`        | `result:Array`                    |
| `error_fetch_more`    | `error:Dictionary`                   |
#### Methods
| **Method**             | **Arguments**                    | **Return Type** |
|--------------------|-------------------------------|-------------|
| `upload`             | `tags: Array = []`              | `void`        |
| `upload_url`        | `url: String`, `tags: Array = []` | `void`        |
| `choose_file`        | `type_file: String = ""`        | `Array`       |
| `fetch`              | `player_id = null`, `tags = null`, `limit = null`, `offset = null` | `Array`       |
| `fetch_more`         | `player_id = null`, `tags = null`, `limit = null`, `offset = null` | `Array`       |
| `resize`             | `url: String`, `width: int`, `height: int`, `crop: bool` | `String`      |
#### Classes
##### GPImage
| **Parameter**   | **Type**        |
|-------------|-------------|
| `id`          | `String`      |
| `player_id`   | `int`         |
| `name`        | `String`      |
| `src`         | `String`      |
| `width`       | `int`         |
| `height`      | `int`         |
| `tags`        | `Array`       |
### Language

#### Methods

| **Method** | **Arguments**          | **Return Type** |
|------------|------------------------|-----------------|
| `current`  | None                   | `String`        |
| `change`   | `lang: String`         | `void`          |

### Leaderboard

#### Signals

|**Signal**|	**Emitted Parameters**|
|----------|--------------------------|
|`opened`	||
|`closed`	||
|`fetched`|	`result:Dictionary`|
| `fetched_scoped` | `result:Dictionary` |
|`fetched_player_rating` |	`result:Dictionary`|
|`fetched_player_rating_scoped` |	`result:Dictionary`|

#### Methods
| **Method**                        | **Arguments**                                                                                                    | **Type Return**  |
|------------------------------|--------------------------------------------------------------------------------------------------------------|-------------------|
| `open`                        | `order_by: Array = []`, `order: String = ""`, `limit: int = 0`, `include_fields: Array = []`, `display_fields: Array = []`,` with_me: String = ''`, `show_nearest: int = 0` | `void`              |
| `fetch`                       | `order_by: Array = []`, `order: String = ""`, `limit: int = 0`, `include_fields: Array = []`, `display_fields: Array = []`, `with_me: String = ""`, `show_nearest: int = 0` | `void`              |
| `fetch_player_rating`        | `order_by: Array = []`, `order: String = ""`, `include_fields: Array = []`, `show_nearest: int = 0` | `void`              |
| `open_scoped`                | `variant: String`, `id: int = 0`, `tag: String = ""`, `order: String = ""`, l`imit: int = 0`, `include_fields: Array = []`, `display_fields: Array = []`,` with_me: String = ''`, `show_nearest: int = 0` | `void`              |
| `publish_record`             | `variant: String`, `record: Dictionary`, `id: int = 0`, `tag: String = ""`,` override = null `                       | `void`              |
| `fetch_scoped`               | `variant: String`, `id: int = 0`, `tag: String = ""`, `order: String = ""`, `limit: int = 0`, `include_fields: Array = []`, `with_me: String = ''`, `show_nearest: int = 0` | `void`              |
| `fetch_player_rating_scoped`  | `variant: String`, `id: int = 0`, `tag: String = ""`, `order_by: Array = []`, `order: String = ""`, `include_fields: Array = []`, `show_nearest: int = 0` | `void`              |

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
| `subscribed`        | `result: Array`                                                 |
| `error_subscribe`        | `error: String`                                                 |
| `unsubscribed`        | `result: Array`                                                 |
| `error_unsubscribe`        | `error: String`                                                 |
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
| `consume`                       | `id :int , tag :String`               | `void`          |
| `purchase`                      | `id :int , tag :String`               | `void`          |
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
| **Signal**                 | **Emitted Parameters**                                     |
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
|-------------------------|----------------------------------------------------|------------------------|
| `get_id`                | None                                               | `Variant`              |
| `get_score`             | None                                               | `Variant`              |
| `get_player_name`       | None                                               | `String`               |
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
| `to_dict`               | None                                               | `Dictionary`           |
| `from_dict`             | `data: Dictionary`                                 | `void`                 |
| `reset`                 | None                                               | `void`                 |
| `remove`                | None                                               | `void`                 |
| `get_min_value`         | `key: String`                                      | `Variant`              |
| `set_min_value`         | `key: String`, `value: Variant`                    | `void`                 |
| `get_max_value`         | `key: String`                                      | `Variant`                  |
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

| **Variable**              | **Type**                     |
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

| **Variable**              | **Type**                     |
|-----------------------|--------------------------|
| `name`                | `String`                 |
| `value`               | `Variant`                |  # String, int или bool

##### FieldLimits

| **Variable**              | **Type**                     |
|-----------------------|--------------------------|
| `min`                 | `float`                  |
| `max`                 | `float`                  |
| `could_go_over_limit` | `bool`                   |

##### IntervalIncrement

| **Variable**              | **Type**                     |
|-----------------------|--------------------------|
| `interval`            | `float`                  |
| `increment`           | `float`                  |

### Players
#### Methods


|**Method**|	**Arguments**|	**Return Type**|
|------|--------------|-----------|
|`fetch`|	`ids: Array`|	`Dictionary`|

### Rewards
#### Signals
| **Signal**             | **Emitted Parameters**            |
|--------------------|-------------------------------|
| `reward_given`       | `reward: Reward`, `player_reward: PlayerReward` |
| `reward_error`       | `err: String`                   |
| `reward_accepted`    | `reward: Reward`, `player_reward: PlayerReward` |
| `reward_accept_error` | `err: String`                   |

#### Methods
| **Method**      | **Arguments**                         | **Return Type** |
|-------------|------------------------------------|-------------|
| `give`        | `id_or_tag: Variant` , `lazy: bool = false` | `Array`       |
| `accept`      | `id_or_tag: Variant`               | `Array`       |
| `list`        |                                    | `Array`       |
| `given_list`  |                                    | `Array`       |
| `get_reward`  | `id_or_tag: Variant`                | `Array`       |
| `has`         | `id_or_tag: Variant`                | `bool`        |
| `has_accepted` | `id_or_tag: Variant`                | `bool`        |
| `has_unaccepted` | `id_or_tag: Variant`             | `bool`        |

#### Classes

##### Reward
| **Parameter**       | **Type**          |
|------------------|---------------|
| `id`               | `int`           |
| `tag`              | `String`        |
| `name`             | `String`        |
| `description`      | `String`        |
| `icon`             | `String`        |
| `icon_small`       | `String`        |
| `mutations`        | `Array`         |
| `is_auto_accept`    | `bool`         |

##### PlayerReward

| **Parameter**       | **Type**          |
|------------------|---------------|
| `reward_id`       | `int`           |
| `count_total`     | `int`           |
| `count_accepted`   | `int`           |

##### DataMutation

| **Parameter**       | **Type**          |
|------------------|---------------|
| `type`            | `String`        |
| `key`             | `String`        |
| `action`          | `String`        |
| `value`           | `Variant`       |

### Schedulers
#### Signals

| **Signal**                             | **Emitted Parameters**                    |
|------------------------------------|----------------------------------------|
| `error_register`                     | `error_message: String`                  |
| `signal_claim_day`                   | `scheduler_day_info: SchedulerDayInfo`   |
| `error_claim_day`                    | `error_message: String`                  |
| `signal_register`                     | `scheduler_info: SchedulerInfo`          |
| `signal_claim_day_additional`        | `scheduler_day_info: SchedulerDayInfo`   |
| `error_claim_day_additional`         | `error_message: String`                  |
| `signal_claim_all_day`               | `scheduler_day_info: SchedulerDayInfo`   |
| `error_claim_all_day`                | `error_message: String`                  |
| `signal_claim_all_days`              | `scheduler_info: SchedulerInfo`          |
| `error_claim_all_days`               | `error_message: String`                  |
| `signal_join`                        | `scheduler: Scheduler`, `player_scheduler: PlayerScheduler` |
| `error_join`                         | `error_message: String`                  |

#### Methods

| **Method**                       | **Arguments**                                | **Return Type**          |
|------------------------------|-------------------------------------------|----------------------|
| `register`                     | `id_or_tag: Variant `                       | `SchedulerInfo`        |
| `claim_day`                    | `id_or_tag: Variant`, `day: int`             | `SchedulerDayInfo`     |
| `claim_day_additional`         | `id_or_tag: Variant`, `day: int`, `trigger_id_or_tag: Variant` | `SchedulerDayInfo`     |
| `claim_all_day`                | `id_or_tag: Variant`, `day: int`             | `SchedulerDayInfo`     |
| `claim_all_days`               | `id_or_tag: Variant`                        | `SchedulerInfo`        |
| `list`                         |                                           | `Array`                |
| `active_list`                  |                                           | `Array`                |
| `get_scheduler`                | `id_or_tag: Variant`                        | `SchedulerInfo`        |
| `get_scheduler_day`            | `id_or_tag: Variant`, `day: int`             | `SchedulerDayInfo`     |
| `get_scheduler_current_day`     | `id_or_tag: Variant`                        | `SchedulerDayInfo`     |
| `is_registered`                | `id_or_tag: Variant`                        | `bool`                 |
| `is_today_reward_claimed`      | `id_or_tag: Variant`                        | `bool`                 |
| `can_claim_day`                | `id_or_tag: Variant`, `day: int`             | `bool`                 |
| `can_claim_day_additional`     | `id_or_tag: Variant`, `day: int`, `trigger_id_or_tag: Variant` | `bool`                 |
| `can_claim_all_day`            | `id_or_tag: Variant`, `day: int`             | `bool`                 |

##### Scheduler

| **Parameter**       | **Type**       |
|------------------|------------|
| `id`               | `int`        |
| `tag`              | `String`     |
| `type`             | `String`     |
| `days`             | `int`        |
| `is_repeat`        | `bool`       |
| `is_auto_register` | `bool`       |
| `triggers`         | `Array`      |

##### PlayerScheduler

| **Parameter**       | **Type**       |
|------------------|------------|
| `scheduler_id`     | `int`        |
| `days_claimed`     | `Array[int]` |
| `stats`            | `PlayerStats` |

##### PlayerStats

| **Parameter**       | **Type**       |
|------------------|------------|
| `active_days`      | `int`        |
| `active_days_consecutive` | `int`  |

##### SchedulerInfo

| **Parameter**       | **Type**              |
|------------------|------------------|
| `scheduler`        | `Scheduler`         |
| `stats`            | `PlayerStats`       |
| `days_claimed`     | `Array[int]`       |
| `is_registered`     | `bool`             |
| `current_day`      | `int`              |

##### SchedulerDayInfo

| **Parameter**         | **Type**              |
|--------------------|------------------|
| `scheduler`          | `Scheduler`         |
| `day`                | `int`              |
| `is_day_reached`     | `bool`             |
| `is_day_complete`    | `bool`             |
| `is_day_claimed`     | `bool`             |
| `is_all_day_claimed` | `bool`             |
| `can_claim_day`      | `bool`             |
| `can_claim_all_day`  | `bool`             |
| `bonuses`            | `Array`            |
| `triggers`           | `Array`            |

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
#### Signals

| **Signal**                | **Emitted Parameters** |
|-----------------------|--------------------|
| `shared`                | `success: bool`      |
| `posted`                | `success: bool`      |
| `invited`               | `success: bool`      |
| `joined_community`      | `success: bool`      |

#### Methods

| **Method**                         | **Arguments**                        | **Return Type** |
|--------------------------------|-----------------------------------|-------------|
| `is_supports_share`              |                                   | `bool`        |
| `is_supports_native_share`       |                                   | `bool`        |
| `share`                          | `text: String = ""`, `url: String = ""`, `image: String = ""` | `void`        |
| `is_supports_native_posts`       |                                   | `bool`        |
| `post`                           | `text: String = ""`, `url: String = ""`, `image: String = "" `| `void`        |
| `is_supports_native_invite`      |                                   | `bool`        |
| `invite`                         | `text: String = ""`                 | `void`        |
| `can_join_community`             |                                   | `bool`        |
| `is_supports_native_community_join` |                                 | `bool`        |
| `join_community`                 |                                   | `void`        |
| `make_share_url`                 | `param: Dictionary`    | `String`      |
| `get_share_param`                | `param: String `                    | `String`      |

### System
#### Methods

| **Method**             | **Arguments** | **Return Type** |
|--------------------|------------|-------------|
| `is_dev`             | None           | `bool`        |
| `is_allowed_origin`   | None           | `bool`        |

### Triggers
#### Signals

| **Signal**          | `Emitted Parameters` |
|-----------------|--------------------|
| `activated`       | `trigger: Trigger`    |
| `claimed`         | `trigger: Trigger`    |
| `error_claim`     | `err: String`         |

#### Methods

| **Method**                | **Arguments**               | **Return Type**    |
|-----------------------|-------------------------|----------------|
| `claim`                 | `id_or_tag: Variant`  | `Dictionary`    |
| `list`                  |                         | `Array`          |
| `activated_list`         |                         | `Array`          |
| `get_trigger`           | `trigger_id: String`       | `Dictionary`     |
| `is_trigger_activated`  | `id_or_tag: Variant`        | `bool`           |
| `is_claimed`            | `id_or_tag: Variant`        | `bool`           |

#### Classes

##### Trigger

| **Property Name**  | **Type**           |
|----------------|----------------|
| `id`             | `String`         |
| `tag`            | `String`         |
| `description`    | `String`         |
| `is_auto_claim`  | `bool`           |
| `conditions`     | `Array`          |
| `bonuses`        | `Array`          |

##### Bonus

| **Property Name**  | **Type**           |
|----------------|----------------|
| `type`           | `String`         |
| `id`             | `int`            |

##### Condition

| **Property Name**  | **Type**           |
|----------------|----------------|
| `type`           | `String`         |
| `key`            | `String`         |
| `operator`       | `String`         |
| `value`          | `Variant`        |

### Variables
#### Signals

| **Signal**                         | **Emitted Parameters**             |
|---------------------------------|--------------------------------|
| `fetched`                        | `Variables: Array`            |
| `fetched_error`                  | `error: String`                  |
| `platform_variables_fetched`      | `variables: Dictionary`          |
| `platform_variables_error`        | `error: String`                  |

#### Methods

| **Method**                         | **Arguments**                          | **Return Type** |
|---------------------------------|------------------------------------|-------------|
| `fetch`                          |  None                                  | `void`        |
| `get_variable`                   | `variable_name: String`              | `Variant`     |
| `has_variable`                   | `variable_name: String`              | `bool`        |
| `type`                           | `variable_name: String`             | `String`      |
| `is_platform_variables_available`|   None                                 | `bool`        |
| `fetch_platform_variables`       | `client_params: Dictionary = {}`     | `Dictionary`  |

### Uniques
#### Signals

| **Signal**         | **Emitted Parameters**    |
|----------------|-----------------------|
| `registered`     | `unique_value: UniqueValue` |
| `register_error` | `error: String`          |
| `checked`        | `unique_value: UniqueValue` |
| `check_error`    | `error: String`          |
| `deleted`        | `unique_value: UniqueValue` |
| `delete_error`   | `error: String`         |

#### Methods

| **Method**         | **Arguments**                          | **Return Type** |
|----------------|------------------------------------|-------------|
| `register`       | `tag: String`, `value: String`         | `bool`        |
| `get_value`      | `tag: String`                        | `String`      |
| `list`           |                                    | `Array`       |
| `check`          | `tag: String`, `value: String`         | `bool`        |
| `delete_unique`  | `tag: String`                        | `void`        |

#### Classes
##### UniqueValue

| **Property Name**  | **Type**   |
|----------------|--------|
| `tag`            | `String` |
| `value`          | `String` |

### Storage

#### Signals

| **Signal**              | **Emitted Parameters**          |
|----------------------|-----------------------------|
| `set_success`          | `key: String`, `value: Variant` |
| `get_success`          | `key: String`, `value: Variant`   |
| `set_global_success`   | `key: String`, `value: Variant` |
| `get_global_success`   | `key: String`, `value: Variant`    |

#### Methods

| **Method**              | **Arguments**                          | **Return Type** |
|---------------------|------------------------------------|-------------|
| `set_storage`         | `storage_type: String`               | `void`        |
| `set_value`           | `key: String`, `value: Variant`        | `void`        |
| `get_value`           | `key: String`                        | `String`      |
| `set_global_value`    | `key: String`, `value: Variant`        | `void`        |
| `get_global_value`    | `key: String`                        | `String`      |

