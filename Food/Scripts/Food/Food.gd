tool
extends Node2D
class_name Food

var sprite : Sprite
var player : Player

func _init():
	sprite = Sprite.new()
	add_child(sprite)

export var definition : Resource setget check_definition

func check_definition(new_definition : FoodDefinition):
	assert(new_definition is FoodDefinition || new_definition == null, "New FoodDefinition is not of type FoodDefinition") 
	if new_definition is FoodDefinition:
		set_definition(new_definition)

func set_definition(new_definition : FoodDefinition):
	definition = new_definition
	sprite.texture = definition.sprite

func get_picked_up():
	player.add_food(definition)
	player.disconnect("try_pickup",self,"get_picked_up")
	queue_free()

func _on_PickupZone_body_entered(body):
	if body is Player:
		player = body
		body.connect("try_pickup",self,"get_picked_up")

func _on_PickupZone_body_exited(body):
	if body is Player && body == player:
		body.disconnect("try_pickup",self,"get_picked_up")
