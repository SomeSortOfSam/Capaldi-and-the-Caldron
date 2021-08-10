extends Node2D

export var food_defininition : Resource setget check_definition

func check_definition(new_definition : FoodDefinition):
	assert(new_definition is FoodDefinition || new_definition == null, "New FoodDefinition is not of type FoodDefinition") 
	if new_definition is FoodDefinition:
		set_definition(new_definition)

func set_definition(new_definition : FoodDefinition):
	food_defininition = new_definition

func spawn_food():
	var food = load(Food.SCENE_PATH).instance() as Food
	food.definition = food_defininition
	get_parent().add_child(food)
