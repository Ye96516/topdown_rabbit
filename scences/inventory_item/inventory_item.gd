@tool
extends Node2D

@export var item_texture:Texture
@export var item_type=""
@export var item_effect=""
@export var item_name=""
@export_multiline var item_description:String

var scence_path="res://scences/inventory_item/inventory_item.tscn"
var is_star_in_range:bool

@onready var icon: Sprite2D = $Icon

func _ready() -> void:
	if not Engine.is_editor_hint():
		icon.texture=item_texture


func _process(delta: float) -> void:
	if  Engine.is_editor_hint():
		icon.texture=item_texture
	if Input.is_action_just_pressed("pick_up") and is_star_in_range:
		pickup_item()
		print(Global.inventory)

##将捡拾到的物品的信息记录在字典中
##如果玩家存在则将字典存入全局脚本里的数组中，并清除被捡拾的物品
func pickup_item():
	var item:={
		"item_name":item_name,
		"item_type":item_type,
		"item_effect":item_effect,
		"item_description":item_description,
		"item_texture":item_texture,
		"quantity":1,
	}
	
	if Global.star_node:
		Global.add_item(item)
		self.queue_free()

##在物品附近时显示互动ui的可见性
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("star"):
		Global.star_node.interactive_ui.visible=true
		is_star_in_range=true
		
##不在物品附近时不显示互动ui的可见性
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("star"):
		Global.star_node.interactive_ui.visible=false
		is_star_in_range=false
