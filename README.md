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
| [Device](#Device)                             |
| [Logger](#Logger)                             |
| [Payments](#Payments)                         |
| [Platform](#Platform)                         |
| [Player](#Player)                             |
| [Segments](#Segments)                         |
| [Server](#server)                             |

### Device

### Signals

| **Signal Name**      |  **Emitted Parameters**     |    
|----------------------|-----------------------------|
| `change_orientation`  | `is_portrait: bool`        |

### Methods

| **Method Name**           | **Arguments**      | **Return Type** |
|---------------------------|--------------------|-----------------|
| `is_mobile`               | None               | `bool`          |
| `is_portrait`             | None               | `bool`          |



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
### Signals

| **Signal**         | **Emitted Parameters**                                           |
|--------------------|------------------------------------------------------------------|
| `purchased`        | `result: Array`                                                 |
| `error_purchase`   | `error: String`                                                 |
| `consumed`         | `result: Array`                                                 |
| `error_consume`    | `error: String`                                                 |
| `fetched_products` | `result: Array`                                                 |
| `error_fetch_products` | `error: String`                                             |

### Methods

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

### Class: Purchase

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

### Class: PlayerPurchase

| **Variable**        | **Type**             |
|---------------------|----------------------|
| `product_id`        | `int`                |
| `payload`           | `JavaScriptObject`   |
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
| `get_name`              | None                                               | `String`               |
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
| `to_json`               | None                                               | `JavaScriptObject`     |
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
Field
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

FieldVariant
| Variable              | Type                     |
|-----------------------|--------------------------|
| `name`                | `String`                 |
| `value`               | `Variant`                |  # String, int или bool

FieldLimits
| Variable              | Type                     |
|-----------------------|--------------------------|
| `min`                 | `float`                  |
| `max`                 | `float`                  |
| `could_go_over_limit` | `bool`                   |

IntervalIncrement
| Variable              | Type                     |
|-----------------------|--------------------------|
| `interval`            | `float`                  |
| `increment`           | `float`                  |

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
