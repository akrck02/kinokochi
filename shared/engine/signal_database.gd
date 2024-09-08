extends Node

# Engine signals
@warning_ignore("unused_signal") signal scene_change_requested(scene : String) 
@warning_ignore("unused_signal") signal tilemap_changed(tilemap : TileMapExtended)

# Time signals
@warning_ignore("unused_signal") signal night_started()
@warning_ignore("unused_signal") signal day_started()
@warning_ignore("unused_signal") signal tick_reached()

# Touch screen signals
@warning_ignore("unused_signal") signal screen_touch_started(data : InputData)
@warning_ignore("unused_signal") signal screen_touch_released(data : InputData)
@warning_ignore("unused_signal") signal screen_touch_double_tap(data : InputData)
@warning_ignore("unused_signal") signal screen_touch_pinch(data : InputData)
@warning_ignore("unused_signal") signal three_finger_touch_started(data : InputData)

@warning_ignore("unused_signal") signal screen_touch_drag_move(data : InputData)
@warning_ignore("unused_signal") signal screen_touch_drag_pinch(data : InputData)

@warning_ignore("unused_signal") signal mouse_motion_updated(global_position : Vector2)

# Visual effects
@warning_ignore("unused_signal") signal notification_shown(message : String)
@warning_ignore("unused_signal") signal notification_hidden()
@warning_ignore("unused_signal") signal outline(value:bool)

# Camera signals
@warning_ignore("unused_signal") signal camera_movement_updated(value : bool)
@warning_ignore("unused_signal") signal zoom_in(value : float)
@warning_ignore("unused_signal") signal zoom_out(value : float)

# Savestate signals
@warning_ignore("unused_signal") signal new_game_created
@warning_ignore("unused_signal") signal save_game_requested

# Dino run minigame
@warning_ignore("unused_signal") signal dinorun_update_score
@warning_ignore("unused_signal") signal dinorun_finished
