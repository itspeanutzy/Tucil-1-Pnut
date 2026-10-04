extends CharacterBody2D

@export var SPEED := 200
@export var acceleration := 5
@export var staff_hold_distance := 13

@onready var staff: Node2D = $Staff
@onready var staff_pivot: Marker2D = $StaffPivot
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D


var animation_direction: String = "down"
var animation_state : String = ""

func update_sprite_direction(input:Vector2) -> void:
	match input:
		Vector2.DOWN:
			animation_direction = "down"
		Vector2.UP:
			animation_direction = "up"
		Vector2.LEFT:
			animation_direction = "left"
		Vector2.RIGHT:
			animation_direction = "right"

func update_sprite() -> void:
	if velocity.length() > 0:
		animation_state = "move_"
	else:
		animation_state = "idle_"

func _process(_delta:float) -> void:
	var mouse_direction := staff_pivot.global_position.direction_to(get_global_mouse_position())
	staff.global_position = staff_pivot.global_position + mouse_direction * staff_hold_distance
	staff.scale.y = 1 if mouse_direction.x > 0 else -1
	staff.show_behind_parent = mouse_direction.y < 0 
	staff.look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	update_sprite_direction(direction)
	update_sprite()
	
	animated_sprite_2d.play(animation_state+animation_direction)
	
	velocity.x = move_toward(velocity.x, direction.x*SPEED, acceleration)
	velocity.y = move_toward(velocity.y, direction.y*SPEED, acceleration)
	
	move_and_collide(velocity*delta)


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.
