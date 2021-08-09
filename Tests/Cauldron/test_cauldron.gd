extends "res://addons/gut/test.gd"

var cauldron : Cauldron
var food1 := Food.new()
var food2 := Food.new()
var food3 := Food.new()
var food1def := FoodDefinition.new()
var food2def := FoodDefinition.new()
var food3def := FoodDefinition.new()
var recipe : Recipe

func before_all():
	food1.definition = food1def
	food2.definition = food2def
	food3.definition = food3def
	recipe = Recipe.new()
	recipe.food1 = food1def
	recipe.food2 = food2def
	recipe.food3 = food3def

func before_each():
	cauldron = add_child_autofree(Cauldron.new())
	watch_signals(cauldron)

func test_3_per():
	cauldron.add_food(food1)
	assert_signal_not_emitted(cauldron,"checked_recipe")
	cauldron.add_food(food2)
	assert_signal_not_emitted(cauldron,"checked_recipe")
	cauldron.add_food(food3)
	assert_signal_emitted(cauldron,"checked_recipe")

func test_recipe_validation():
	cauldron.recipes.append(recipe)
	cauldron.add_food(food1)
	cauldron.add_food(food2)
	cauldron.add_food(food3)
	assert_signal_emitted_with_parameters(cauldron,"checked_recipe",[true])

func after_all():
	food1.free()
	food2.free()
	food3.free()
