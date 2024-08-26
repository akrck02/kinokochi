extends TileMapLayer
class_name TileMapLayerExtended

@export var obstacles_layer : TileMapLayer = null

## Check if tile data needs to be updated
func _use_tile_data_runtime_update(_coords: Vector2i) -> bool:
	return true

## Update tile data if necesary
func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	
	if obstacles_layer == null:
		return
	
	if coords in obstacles_layer.get_used_cells():
		set_tile_as_obstacle(tile_data)

## Set the given tile as obstacle
func set_tile_as_obstacle(tile_data: TileData):
	tile_data.set_navigation_polygon(0,null)
