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
var dir:Vector2

func _ready() -> void:
	Global.connect("star_stop_direction",Callable(self,"star_dir"))
	print(func  (di): return di)
	pass
	
##鼠标进入且物品不为空时，详情菜单弹出
func _on_button_mouse_entered() -> void:
	if item!=null:
		details_panel.visible=true
		usage_panel.visible=false

##鼠标离开时，详情菜单退出
func _on_button_mouse_exited() -> void:
	details_panel.visible=false

##鼠标按下且物品不为空时，展示或隐藏功能菜单
func _on_button_pressed() -> void:
	if item!=null:
		usage_panel.visible=!usage_panel.visible

##设置图标和数量为空
func set_empty():
	icon.texture=null
	quantity.text=""

##将物品场景中物品的详细信息展示出来，传入物品信息（字典）
func set_item(new_item:Dictionary):
	##将传入的物品信息赋值给item
	item=new_item
	##将存储在字典中的物品信息展示出来
	item_name.text=str(new_item["item_name"])
	quantity.text=str(new_item["item_quantity"])
	effect.text=str(new_item["item_effect"])
	type.text=str(new_item["item_type"])
	description.text=str(new_item["item_description"])
	icon.texture=new_item["item_texture"]

##当按下丢弃按钮且物品存在时，丢弃物品到世界
func _on_drop_pressed() -> void:
	if item != null:
		#定义drop_position为玩家的位置
		var drop_position = Global.star_node.global_position
		#定义drop_offset为 Vector2(0, 50）
		var drop_offset = Vector2(0, 50)

		
		match Global.dir:
			Vector2(0,0):
				drop_offset = Vector2(0, 50)
			Vector2(0,1):
				drop_offset = Vector2(0, 50)
			Vector2(0,-1):
				drop_offset=Vector2(0,-50)
			Vector2(1,0):
				drop_offset=Vector2(50,0)
			Vector2(-1,0):
				drop_offset=Vector2(-50,0)
			Vector2(-1,-1):
				drop_offset=Vector2(0,-50)
			Vector2(1,1):
				drop_offset=Vector2(0,50)
			Vector2(-1,1):
				drop_offset=Vector2(0,-50)
			Vector2(1,-1):
				drop_offset=Vector2(0,50)
		#drop_offset = drop_offset.rotated(Global.star_node.rotation)
		#调用全局脚本中的drop_item方法,将物品扔出
		Global.drop_item(item, drop_position + drop_offset)
		#调用remove_item方法，使仓库物品减一
		Global.remove_item(item["item_name"])
		#隐藏功能菜单
		usage_panel.visible = false
	
func star_dir(di):
	print(di)
