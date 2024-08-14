extends Node

# Engine signals
signal scene_change_requested(scene : String) 
signal night_started()
signal day_started()
signal tick_reached();
signal notification_shown(message : String)
signal notification_hidden()

# Camera signals
signal zoom_in(value : float)
signal zoom_out(value : float)

# Savestate signals
signal new_game_created
signal save_game_requested

# Pet signals
signal pet_hunger_changed(value : int)
signal pet_fun_changed(value : int)
signal pet_affection_changed(value : int)
signal pet_energy_changed(value : int)
signal pet_evolved(value : int)
