extends "res://addons/gut/test.gd"

var cauldron : Cauldron

func before_each():
	cauldron = add_child_autofree(Cauldron.new())

func test_3_per():
	var food := autofree(Food.new()) as Food
	watch_signals(cauldron)
	cauldron.add_food(food)
	assert_signal_not_emitted(cauldron,"checked_recipe")
	cauldron.add_food(food)
	cauldron.add_food(food)
	assert_signal_emitted(cauldron,"checked_recipe")
