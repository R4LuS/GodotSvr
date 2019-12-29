extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var data_map_name = "data_map_1.data"
var min_x = 0
var min_y = 0
var max_x = 0
var max_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	calculate_bounds()
	#save()

func save():
	var file := File.new()
	var csize = $TileMap.cell_size
	file.open("res://data/Maps/" + data_map_name, File.WRITE)
	file.store_line(str($TileMap.get_tileset().resource_path))
	file.store_line(str(max_x - min_x) + " " + str(max_y - min_y))
	file.store_line(str(csize.x) + " " + str(csize.y))
	var used_cells = $TileMap.get_used_cells()
	for pos in used_cells:
		file.store_line(str($TileMap.get_cellv(pos)) + " " + str(pos.x) + " " + str(pos.y))
	file.close()
	print("Saved map into 'res://data/Maps/" + data_map_name + "'")
	
func calculate_bounds():
    var used_cells = $TileMap.get_used_cells()
    for pos in used_cells:
        if pos.x < min_x:
            min_x = int(pos.x)
        elif pos.x > max_x:
            max_x = int(pos.x)
        if pos.y < min_y:
            min_y = int(pos.y)
        elif pos.y > max_y:
            max_y = int(pos.y)