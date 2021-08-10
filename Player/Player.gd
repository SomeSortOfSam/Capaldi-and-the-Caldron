extends KinematicBody2D
class_name Player

const ANIM_JUMP_PREFIX = "Jump"
const ANIM_IDEL_PREFIX = "Still"
const ANIM_CROUCH_PREFIX = "Crouch"
const ANIM_WALK_PREFIX = "Walk"

const ANIM_HOLDING_SUFFIX = "Hold"
const ANIM_NOT_HOLDING_SUFFIX = "Empty"

signal try_pickup()
signal got_food(food)
signal ungot_food()

export var SPEED : float
export var GRAVITY: float
export(float,0,1) var ROLLING_FRICION : float
export(float,0,1) var STATIC_FRICTION : float
export var JUMP_HEIGHT : float
export(float,.001,1) var END_JUMP_PERCENT : float
export var holding : bool

onready var sprite : AnimatedSprite = $Icon
onready var ground_cast : RayCast2D = $RayCast2D
onready var queue_jump_timer : Timer = $QueueJumpTimer
onready var grounded_delay : Timer = $GroundedDelayTimer
onready var food_holder : Node2D = $FoodHolder

var velocity := Vector2.ZERO;
var foods := []

func _process(_delta):
	handle_animation()
	check_pickup()

func _physics_process(delta):
	var axis = get_horizontal_axis()
	velocity.x += axis * SPEED
	velocity.x *= apply_friction(delta,axis)
	velocity.y += GRAVITY;
	velocity.y = check_jump(velocity.y)
	
	velocity = move_and_slide(velocity)

func get_horizontal_axis() -> float:
	var movementVector := 0.0
	if(Input.is_action_pressed("ui_left")):
		movementVector -= 1.0
	if(Input.is_action_pressed("ui_right")):
		movementVector += 1.0
	return movementVector

func apply_friction(delta,axis : float) -> float:
	if axis != 0:
		return pow(1-ROLLING_FRICION,delta * 10.0)
	return pow(1-STATIC_FRICTION,delta *10.0)

func check_jump(y : float) -> float:
	if ground_cast.is_colliding():
		grounded_delay.start()
	if Input.is_action_pressed("ui_up"):
		queue_jump_timer.start()
	if !queue_jump_timer.is_stopped() && !grounded_delay.is_stopped():
		return -GRAVITY - JUMP_HEIGHT
	if y < 0 && !Input.is_action_pressed("ui_up"):
		return  y * END_JUMP_PERCENT
	return y

func handle_animation():
	sprite.flip_h = velocity.x > 0
	sprite.animation = get_animation_name()

func get_animation_name() -> String:
	var name := ""
	name += get_animation_prefix() 
	name += "_" 
	name += get_animation_suffix()
	return name

func get_animation_suffix() -> String:
	return ANIM_HOLDING_SUFFIX if holding else ANIM_NOT_HOLDING_SUFFIX

func get_animation_prefix() -> String:
	if !ground_cast.is_colliding():
		return ANIM_JUMP_PREFIX
	if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		return ANIM_IDEL_PREFIX
	return ANIM_WALK_PREFIX

func check_pickup():
	if Input.is_action_just_pressed("ui_down"):
		emit_signal("try_pickup")
		if holding:
			reclaim_held_food()

func add_food(food : FoodDefinition):
	foods.push_back(food)

func hold_next_food():
	var food = load(Food.SCENE_PATH).instance() as Food
	food.definition = foods.pop_front()
	food_holder.add_child(food)
	food.is_held = true
	holding = true

func reclaim_held_food():
	holding = false
