extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state=animation_tree.get("parameters/playback")
@onready var interactive_ui: CanvasLayer = $InteractiveUi

var speed:=110

func _ready():
	Global.star_node=self
	pass

func _physics_process(_delta: float) -> void:
	var direction:=Vector2(Input.get_action_strength("d")-Input.get_action_strength("a"),
							Input.get_action_strength("s")-Input.get_action_strength("w"))
	play_animation(direction)
#	change_state(direction)
	velocity=direction*speed
	move_and_slide()

func play_animation(direction):
	#if direction !=Vector2.ZERO:
	if direction!=Vector2(0,0):
		animation_tree.set("parameters/walk/blend_position",direction)
		animation_tree.set("parameters/idle/blend_position",direction)
		animation_tree["parameters/conditions/is_walk"]=true
		animation_tree["parameters/conditions/is_idle"]=false
	elif direction==Vector2(0,0):
		#animation_tree.set("parameters/idle/blend_position",direction)
		animation_tree["parameters/conditions/is_idle"]=true
		animation_tree["parameters/conditions/is_walk"]=false

#func change_state(direction):
	#if direction !=Vector2.ZERO:
		#state.travel("walk")
	#else:
		#state.travel("idle")
		
		
		
		
