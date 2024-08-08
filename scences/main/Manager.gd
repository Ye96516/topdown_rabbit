extends Node2D

@onready var tile_map: TileMap = $"../TileMap"

var water=0
var grass=1
var ground=2
var building=3
var roof_two_lakes=4

	

func _on_in_front_of_door_body_entered(body: Node2D) -> void:
	
	tile_map.set_cell(building,Vector2i(23,30),4,Vector2i(0,2)) 


func _on_in_front_of_door_body_exited(body: Node2D) -> void:
	tile_map.set_cell(building,Vector2i(23,30),4,Vector2i(0,1)) 


func _on_is_roof_body_entered(body: Node2D) -> void:
	tile_map.set_layer_enabled(roof_two_lakes,false)
	#tile_map.set_layer_modulate(roof_two_lakes,Color(1,1,1,0))


func _on_is_roof_body_exited(body: Node2D) -> void:
	tile_map.set_layer_enabled(roof_two_lakes,true)
