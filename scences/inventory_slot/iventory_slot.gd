extends Control

@onready var button: Button = $Button
@onready var item_name: Label = $DetailsPanel/Name
@onready var type: Label = $DetailsPanel/Type
@onready var effect: Label = $DetailsPanel/Effect
@onready var description: Label = $DetailsPanel/Description
@onready var usage_panel: ColorRect = $UsagePanel
@onready var details_panel: ColorRect = $DetailsPanel
@onready var icon: TextureRect = $InnerBoard/Icon
@onready var quantity: Label = $InnerBoard/Quantity
@onready var inventory_item: Node2D = $InventoryItem

var item=null

func _on_button_mouse_entered() -> void:
	if item!=null:
		details_panel.visible=true
		usage_panel.visible=false

func _on_button_mouse_exited() -> void:
	details_panel.visible=false


func _on_button_pressed() -> void:
	if item!=null:
		usage_panel.visible=!usage_panel.visible

func set_empty():
	icon.texture=null
	quantity.text=""

func set_item(new_item:Dictionary):
	item=new_item
	item_name.text=str(new_item["item_name"])
	quantity.text=str(new_item["item_quantity"])
	effect.text=str(new_item["item_effect"])
	type.text=str(new_item["item_type"])
	description.text=str(new_item["item_description"])
	icon.texture=new_item["item_texture"]

func _on_drop_pressed() -> void:
	if item != null:
		var drop_position = Global.star_node.global_position
		var drop_offset = Vector2(0, 50)
		drop_offset = drop_offset.rotated(Global.star_node.rotation)
		Global.drop_item(item, drop_position + drop_offset)
		Global.remove_item(item["item_name"])
		usage_panel.visible = false
	
