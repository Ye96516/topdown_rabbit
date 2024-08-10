##这是一个全局脚本，存储玩家节点，也可进行库存操作。
extends Node

var inventory:Array=[]
var star_node:Node2D
var dir:Vector2
#var slot_scence:String="res://scences/inventory_slot/iventory_slot.tscn"
const slot_scence = preload("res://scences/inventory_slot/iventory_slot.tscn")

signal inventory_update
signal star_stop_direction(dir)

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

##调整摆放位置，传入玩家位置
#func adjust_drop_position(position):
#
	#var radius = 100
	#var nearby_items = get_tree().get_nodes_in_group("Items")
	#for item in nearby_items:
		##若玩家与物品的距离小于radius，随机random_offset，position加上random_offset并返回
		#if item.global_position.distance_to(position) < radius:
			#print(item.global_position.distance_to(position)) 
			#var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			#position += random_offset
			#break
	#return position

##丢弃物品，传入物品信息（字典），丢弃位置
func drop_item(item_data:Dictionary, drop_position):
	#加载物品信息中的“scence_path”
	var item_scene = load(item_data["scence_path"])
	#实例化物品场景
	var item_instance = item_scene.instantiate()
	#调用物品场景中的set_item_data函数，将物品信息传入，该函数会呈现物品信息
	item_instance.set_item_data(item_data)
	#
	#drop_position = adjust_drop_position(drop_position)
	#物品坐标被赋值为drop_position
	item_instance.global_position = drop_position
	#将物品场景添加到当前运行场景的根节点下
	get_tree().current_scene.add_child(item_instance)
	
