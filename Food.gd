tool
extends Node2D
class_name Food

var sprite : Sprite

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
