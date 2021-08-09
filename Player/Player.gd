extends KinematicBody2D


const ANIM_JUMP_PREFIX = "Jump"
const ANIM_IDEL_PREFIX = "Still"
const ANIM_CROUCH_PREFIX = "Crouch"
const ANIM_WALK_PREFIX = "Walk"

const ANIM_HOLDING_SUFFIX = "Hold"
const ANIM_NOT_HOLDING_SUFFIX = "Empty"

export var SPEED : float
export var GRAVITY: Vector2;
export var FRICTION : float
export var holding : bool

onready var sprite : AnimatedSprite = $Icon

var velocity := Vector2.ZERO;

func _process(_delta):
	sprite.flip_h = velocity.x > 0
	sprite.animation = get_animation_name()

func _physics_process(_delta):
	velocity += get_horizontal_input_vector() * SPEED
	velocity += GRAVITY;
	
	velocity = move_and_slide(velocity)
	velocity.x *= FRICTION

func get_horizontal_input_vector()->Vector2:
	var movementVector := Vector2.ZERO
	if(Input.is_action_pressed("ui_left")):
		movementVector += Vector2.LEFT
	if(Input.is_action_pressed("ui_right")):
		movementVector += Vector2.RIGHT
	return movementVector.normalized()

func get_animation_name() -> String:
	var name := ""
	name += get_animation_prefix() 
	name += "_" 
	name += get_animation_suffix()
	return name

func get_animation_suffix() -> String:
	return ANIM_HOLDING_SUFFIX if holding else ANIM_NOT_HOLDING_SUFFIX

func get_animation_prefix() -> String:
	if velocity.y > 0:
		return ANIM_JUMP_PREFIX
	if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		return ANIM_IDEL_PREFIX
	return ANIM_WALK_PREFIX
