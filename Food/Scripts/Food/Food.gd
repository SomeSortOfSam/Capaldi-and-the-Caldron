tool
extends KinematicBody2D
class_name Food

const SCENE_PATH := "res://Food/Scripts/Food/Food.tscn"

onready var sprite : Sprite = $Sprite3

export var GRAVITY : float
export var is_held := false

var player
var velocity : Vector2

export var definition : Resource setget check_definition

func _physics_process(delta):
	if !is_held:
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity)

func check_definition(new_definition : FoodDefinition):
	assert(new_definition is FoodDefinition || new_definition == null, "New FoodDefinition is not of type FoodDefinition") 
	if new_definition is FoodDefinition:
		call_deferred("set_definition",new_definition)

func set_definition(new_definition : FoodDefinition):
	definition = new_definition
	sprite.texture = definition.sprite

func get_picked_up():
	player.add_food(definition)
	player.disconnect("try_pickup",self,"get_picked_up")
	queue_free()

func _on_PickupZone_body_entered(body : Object):
	if body.has_signal("try_pickup"):
		player = body
		var _connection = body.connect("try_pickup",self,"get_picked_up")

func _on_PickupZone_body_exited(body : Object):
	if body == player && body.is_connected("try_pickup", self, "get_picked_up"):
		body.disconnect("try_pickup",self,"get_picked_up")
