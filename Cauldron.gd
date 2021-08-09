extends Node2D
class_name Cauldron

var ingredinets := [3]
var ingredinets_index := 0

signal checked_recipe()

func add_food(food : Food):
	ingredinets.append(food)
	if ingredinets.size() >= 3:
		check_recipe()

func check_recipe():
	ingredinets.clear()
	emit_signal("checked_recipe")

func _on_FoodZone_body_entered(body):
	if body is Food:
		add_food(body)
