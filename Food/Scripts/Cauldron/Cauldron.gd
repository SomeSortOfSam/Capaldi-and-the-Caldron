extends StaticBody2D
class_name Cauldron

export var recipes := []

onready var sprite : AnimatedSprite = $AnimatedSprite

var ingredinets := []

signal checked_recipe(is_valid)

func add_food(food : Food):
	ingredinets.append(food.definition)
	food.queue_free()
	sprite.animation = "Stage " + str(ingredinets.size())

func check_recipe():
	if ingredinets.size() >= 3:
		for recipe in recipes:
			if recipe is Recipe:
				if ingredinets[0] == recipe.food1 && ingredinets[1] == recipe.food2 && ingredinets[2] == recipe.food3:
					emit_signal("checked_recipe", true)
					ingredinets.clear()
					spawn_food(recipe)
					return
		ingredinets.clear()
		emit_signal("checked_recipe", false)
		sprite.animation = "Stage 0"

func _on_FoodZone_body_entered(body):
	if body is Food:
		add_food(body)

func spawn_food(recipe : Recipe):
	var food = load(Food.SCENE_PATH).instance() as Food
	food.definition = recipe.Result
	get_parent().add_child(food)
	food.position = position
