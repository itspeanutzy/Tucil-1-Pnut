extends Sprite2D

@onready var Animplayer: AnimationPlayer = $AnimationPlayer
@onready var RayCast: RayCast2D = $RayCast2D

const speed: int = 150

func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0).rotated(rotation) * speed * delta
	if RayCast.is_colliding() and !RayCast.get_collider().get("IS_PLAYER"):
		Animplayer.play("remove")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "remove":
		@warning_ignore("standalone_expression")
		queue_free()

func _on_distance_timeout_timeout () -> void:
	Animplayer.play ("remove ")
