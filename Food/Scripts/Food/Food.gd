tool
extends KinematicBody2D
class_name Food

const SCENE_PATH := "res://Food/Scripts/Food/Food.tscn"

onready var sprite : Sprite = $Sprite3
onready var ground_ray : RayCast2D = $RayCast2D

export var GRAVITY : float
export(float,0,1) var FRICTION : float
export var is_held := false

var velocity : Vector2

export var definition : Resource setget check_definition

func _physics_process(delta):
	if !is_held && !Engine.editor_hint:
		velocity.y += GRAVITY
		if ground_ray.is_colliding():
			velocity.x *= pow(1-FRICTION,delta *10.0)
		
		velocity = move_and_slide(velocity)

func check_definition(new_definition : Ingredient):
	assert(new_definition is Ingredient || new_definition == null, "New Ingredient is not of type Ingredient") 
	if new_definition is Ingredient:
		call_deferred("set_definition",new_definition)

func set_definition(new_definition : Ingredient):
	definition = new_definition
	sprite.texture = definition.sprite
