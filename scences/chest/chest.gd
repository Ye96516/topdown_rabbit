extends StaticBody2D

@onready var animation_player =$Chest/Chest/AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.name=="Star":
		animation_player.play("open")
		$Chest/CollisionShape2D.queue_free()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	pass
