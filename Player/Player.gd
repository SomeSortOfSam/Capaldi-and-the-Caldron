extends KinematicBody2D

var speed
var velocity = Vector2.ZERO;
export var gravity: Vector2 = Vector2.ZERO;
export var weight: Vector2

func _physics_process(delta):
	
	velocity += get_horizontal_input_vector()
	velocity += gravity;
	
	
	velocity = move_and_slide(velocity)
	
	
func get_horizontal_input_vector()->Vector2:
	var movementVector:Vector2
	if(Input.is_action_just_pressed("ui_left")):
		movementVector += Vector2.LEFT
	if(Input.is_action_just_pressed("ui_right")):
		movementVector += Vector2.RIGHT
	return movementVector.normalized()

func get_gravity()->Vector2:
	var local_gravity = Input.gravity*weight
	
	return local_gravity;
