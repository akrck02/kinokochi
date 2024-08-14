extends Node

# Engine signals
signal scene_change_requested(scene : String) 
signal tick_reached();

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
