extends Control

@onready var grid_container: GridContainer = $ScrollContainer/GridContainer

func _ready() -> void:
	Global.iventory_update.connect(on_inventroy_update())
	on_inventroy_update()

func on_inventroy_update():
	clear_invenroy()
	for item in range(Global.inventory.size()):
		var slot=Global.slot_scence.instantiate()
		grid_container.add_child(slot)
		if item!=null:
			slot.set_item(item)
		else:
			slot.set_empty()
	pass

func clear_invenroy():
	while grid_container.get_child_count()>0:
		var child=grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
