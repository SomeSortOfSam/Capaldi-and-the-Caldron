extends StaticBody2D
class_name Cauldron

const COVER_FRAME = 12

export var recipes := []

onready var sprite : AnimatedSprite = $AnimatedSprite
onready var food_indicator_holder : Node2D = $FoodIndicators

var ingredinets := []
var queued_animation_sequence_end : bool = false

signal checked_recipe(is_valid)

func add_food(food : Food):
	queued_animation_sequence_end = false
	ingredinets.append(food.definition)
	food.queue_free()
	food_indicator_holder.get_child(ingredinets.size() - 1).texture = food.definition.sprite
	sprite.animation = "Stage " + str(ingredinets.size())

func check_recipe():
	for recipe in recipes:
		if recipe is Recipe:
			if has_recipe(recipe):
				emit_signal("checked_recipe", true)
				spawn_food(recipe)
				clear_ingredients()
				return
	emit_signal("checked_recipe", false)
	clear_ingredients()

func _on_FoodZone_body_entered(body):
	if body is Food:
		add_food(body)

func spawn_food(recipe : Recipe):
	var food = load(Food.SCENE_PATH).instance() as Food
	food.definition = recipe.Result
	get_parent().add_child(food)
	food.global_position = food_indicator_holder.global_position
	food.velocity.y = -food.GRAVITY * 100

func has_recipe(recipe:Recipe) -> bool:
	var is_match : bool = ingredinets[0] == recipe.food1
	is_match = is_match && ingredinets[1] == recipe.food2 
	is_match = is_match && ingredinets[2] == recipe.food3
	return is_match

func clear_ingredients():
	ingredinets.clear()
	queued_animation_sequence_end = true
	for x in 3:
		var food_sprite := food_indicator_holder.get_child(x) as Sprite
		food_sprite.texture = null

func _on_AnimatedSprite_frame_changed():
	if sprite.frame == COVER_FRAME:
		check_recipe()

func _on_AnimatedSprite_animation_finished():
	if queued_animation_sequence_end:
		sprite.animation = "Stage 0"
