class_name Constants

# Project paths
const NODE_PATH = "res://nodes/"
const SCENE_PATH = "res://scenes/"

const UI_NODE_PATH = NODE_PATH + "ui/"
const SPRITE_PATH = "res://sprites/"
const MATERIAL_PATH = "res://materials/"
const CAMERA_MATERIAL_PATH = MATERIAL_PATH + "camera/"
const UI_SPRITE_PATH = SPRITE_PATH + "ui/"
const UI_SPRITE_CONTROLS_PATH = UI_SPRITE_PATH + "controls/"
const UI_SPRITE_GAMEPAD_PATH = UI_SPRITE_CONTROLS_PATH + "gamepad/"
const UI_SPRITE_KEYBOARD_PATH = UI_SPRITE_CONTROLS_PATH + "keyboard/"

const SHARED_PATH = "res://shared/"

# script paths
const CONTROLS_SCRIPT_PATH = NODE_PATH + "mechanics/controls.gd"
const DIRECTION_SCRIPT_PATH = NODE_PATH + "mechanics/direction.gd"
const ENGINE_UTILS_SCRIPT_PATH = SHARED_PATH + "engine_utils.gd"

# Scene paths
const LOADER_PATH = SCENE_PATH + "loader/loader.tscn"
const SELECTOR_SCENE_PATH = SCENE_PATH + "selector/level_selector.tscn"
const ERROR_SCENE_NAME = SCENE_PATH + "error/error.tscn"
const CREDITS_SCENE_NAME = SCENE_PATH + "credits/credits.tscn"

# Nodes
const LEVEL_BUTTON = UI_NODE_PATH + "levels/level_button.tscn"

# Sprites
const DILOGUE_FILE_TEMPLATE: String = "res://files/dialogues/$file.json"

# Sprite params
const TILE_SIZE = 16

# Audio
const AUDIO_MASTER_BUS = "Master"
const AUDIO_MUSIC_BUS = "Music"
const AUDIO_EFFECTS_BUS = "Effects"

# Liar minigame
enum FACING { UP, DOWN, LEFT, RIGHT }
