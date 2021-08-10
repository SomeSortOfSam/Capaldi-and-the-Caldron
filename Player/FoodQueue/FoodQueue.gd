extends Node2D
class_name FoodQueue

const GUI_ITEM_PATH = "res://Player/FoodQueue/FoodQueueGUIItem.tscn"

onready var gui_container : VBoxContainer = $CanvasLayer/VBoxContainer

var check_for_pickup := []
var foods := []

func can_pickup() -> bool:
	return check_for_pickup.size() > 0

func pickup():
	add_food(check_for_pickup.pop_front())

func foods_in_queue() -> bool:
	return foods.size() > 0

func get_next_food(pop := true) -> Ingredient:
	if pop:
		remove_gui_item()
		return foods.pop_front()
	return foods[foods.size() -1]

func add_food(food : Food):
	food.queue_free()
	foods.push_back(food.definition)
	add_gui_item(food.definition)

func _on_PickupZone_area_entered(area):
	var food := area.get_parent() as Food
	if food is Food:
		check_for_pickup.append(food)

func _on_PickupZone_area_exited(area):
	var food := area.get_parent() as Food
	if food is Food:
		var index := check_for_pickup.find(food)
		if index != -1:
			check_for_pickup.remove(index)

func add_gui_item(food : Ingredient):
	var packed_item = preload(GUI_ITEM_PATH)
	var item := packed_item.instance() as FoodQueueGUIItem
	item.food_defininition = food
	gui_container.add_child(item)

func remove_gui_item():
	gui_container.get_child(0).queue_free()
	gui_container.rect_size = gui_container.rect_min_size
