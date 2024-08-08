##这是一个全局脚本，存储玩家节点，也可进行库存操作。
extends Node

var inventory:Array=[]
var star_node:Node2D

signal iventory_update

func _ready() -> void:
	inventory.resize(30)


func add_item(item):
	for i in range(inventory.size()):
		if inventory[i]!=null and inventory[i]["item_name"]==item["item_name"]:
			inventory[i]["quantity"]+=1
			iventory_update.emit()
			return true
		elif  inventory[i]==null:
			inventory[i]=item
			iventory_update.emit()
			return true
		return false
	
	
