extends Control
class_name FoodQueueGUIItem

onready var icon : TextureRect = $Control/TextureRect
onready var text : Label = $Control/Label

export var food_defininition : Resource setget check_definition

func check_definition(new_definition : Ingredient):
	assert(new_definition is Ingredient || new_definition == null, "New Ingredient is not of type Ingredient") 
	if new_definition is Ingredient:
		call_deferred("set_definition",new_definition)

func set_definition(new_definition : Ingredient):
	food_defininition = new_definition
	icon.texture = food_defininition.sprite
	text.text = food_defininition.name
