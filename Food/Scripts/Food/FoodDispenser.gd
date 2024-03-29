extends Node2D

export var food_defininition : Resource setget check_definition

func check_definition(new_definition : Ingredient):
	assert(new_definition is Ingredient || new_definition == null, "New Ingredient is not of type Ingredient") 
	if new_definition is Ingredient:
		set_definition(new_definition)

func set_definition(new_definition : Ingredient):
	food_defininition = new_definition

func spawn_food():
	var food = load(Food.SCENE_PATH).instance() as Food
	food.definition = food_defininition
	get_parent().add_child(food)
