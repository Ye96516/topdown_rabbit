##这是一个全局脚本，存储玩家节点，也可进行库存操作。
extends Node

var inventory:Array=[]
var star_node:Node2D
#var slot_scence:String="res://scences/inventory_slot/iventory_slot.tscn"
const slot_scence = preload("res://scences/inventory_slot/iventory_slot.tscn")
signal inventory_update

##初始化仓库大小为三十
func _ready() -> void:
	inventory.resize(30)

##加入物品
func add_item(item):
	for i in range(inventory.size()):
		#如果i位不为空，且被拾取物的名称与其名称相同，则物品数量加一
		if inventory[i]!=null and inventory[i]["item_name"]==item["item_name"]:
			inventory[i]["item_quantity"]+=1
			inventory_update.emit()
			return true
		#若有空位，将物品加入空位
		elif  inventory[i]==null:
			inventory[i]=item
			inventory_update.emit()
			return true

##移除一个物品，传入物品的名称
func remove_item(item_name):
	for i in range(inventory.size()):
		#若i位不为空，且其名称与传入名称相同则物品数量减一
		if inventory[i]!=null and inventory[i]["item_name"]==item_name :
			inventory[i]["item_quantity"] -= 1
			#数量小于等于零则将i位设为空
			if inventory[i]["item_quantity"] <= 0:
				inventory[i] = null
				inventory_update.emit()
				return true

##调整摆放位置，暂时搁置
#func adjust_drop_position(position):
	#var radius = 100
	#var nearby_items = get_tree().get_nodes_in_group("Items")
	#for item in nearby_items:
		#if item.global_position.distance_to(position) < radius:
			#var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			#position += random_offset
			#break
	#return position


func drop_item(item_data:Dictionary, drop_position):
	var item_scene = load(item_data["scence_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position = adjust_drop_position(drop_position)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)
	
