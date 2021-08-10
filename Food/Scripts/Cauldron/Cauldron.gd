extends StaticBody2D
class_name Cauldron

export var recipes := []

var ingredinets := []
var ingredinets_index := 0

signal checked_recipe(is_valid)

func add_food(food : Food):
	ingredinets.append(food.definition)
	food.queue_free()
	if ingredinets.size() >= 3:
		check_recipe()

func check_recipe():
	for recipe in recipes:
		if recipe is Recipe:
			if ingredinets[0] == recipe.food1 && ingredinets[1] == recipe.food2 && ingredinets[2] == recipe.food3:
				emit_signal("checked_recipe", true)
				ingredinets.clear()
				return
	ingredinets.clear()
	emit_signal("checked_recipe", false)

func _on_FoodZone_body_entered(body):
	if body is Food:
		add_food(body)
