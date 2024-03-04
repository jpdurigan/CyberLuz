@tool
extends TileMap

@export var tile_origin := Vector2i(-100, -100)
@export var tile_end := Vector2i(100, 100)

func _ready() -> void:
	for tile_x in range(tile_origin.x, tile_end.x):
		for tile_y in range(tile_origin.y, tile_end.y):
			set_cell(0, Vector2i(tile_x, tile_y), 0, Vector2i(0, 0))

