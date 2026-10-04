extends Node2D

const bullet_scene = preload("res://scripts/fireball.tscn")

const IS_PLAYER = true

@export var RotationOffset: Node2D
@export var magic: Marker2D
@export var Cooldown: Timer

var time_between_shot: float = 0.5
var can_shoot: bool = true

func _ready() -> void:
	Cooldown.wait_time = time_between_shot

func _physics_process(delta: float) -> void:
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, (get_global_mouse_position() - global_position).angle(), 6.5*delta)
	if Input.is_action_just_pressed("Magic") and can_shoot:
		if can_shoot:
			Cooldown.start()
			_shoot()

func _shoot():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = magic.global_position
	new_bullet.global_rotation = magic.global_rotation
	get_tree().root.add_child(new_bullet)

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
