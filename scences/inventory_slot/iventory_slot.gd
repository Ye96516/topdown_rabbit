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

func set_item(new_item):
	item=new_item
	item_name.text=str(new_item["item_name"])
	effect.text=str(new_item["item_effect"])
	type.text=str(new_item["item_type"])
	description.text=str(new_item["item_description"])
	icon.texture=new_item["item_texture"]
	
	
	
	
	
