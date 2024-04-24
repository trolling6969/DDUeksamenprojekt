extends Control


var value = 0 
var food = 60

#setget set_value 

var value_as_string setget ,get_value
var food_as_string setget ,get_food



const SQLite = preload ("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db #database objekt 
var db_name = "res://DataStore/Data"
var waterItemText = ""
var foodItemText = ""
var energidrikItemText = ""
var money = ""

func _ready():
	set_value(value)
	set_food(food)
	$Inventory.hide()
	$"go outside screen".hide()
	$Shop.hide()
	$foodfood.hide()
	
	db = SQLite.new()
	db.path = db_name
	readFromDB()


func set_value(val):
	value = val
	print(val)
	$Sleep.text = "Sleep: " + str(val)


func get_value():
	return "the value is" + str(value)
	pass


func _on_SleepButton_pressed():
	value += 1
	set_value(value)
	food -= 20 
	set_food(food)
	print(value)


func set_food(food):
	if food <= 0:
		food = 0
	food = food
	$food.text = "food: " + str(food)
	print(food)

#food = food

func get_food():
	return "the food is" + str(food)
	pass


func _on_FoodButton_pressed():
	if food == 100 or food >= 100:
		food = 100
	else:
		food += 20
	set_food(food)


func _on_InventoryButton_pressed():
	if $Inventory.visible == true:
		$Inventory.hide()
	else:
		$Inventory.show()


func _on_foodfood_pressed():
	if $foodfood.visible == true:
		$foodfood.hide()
	else:
		$foodfood.show()




func readFromDB():
	db.open_db()
	var tableName = "stats"
	db.query("select * from " + tableName + ";")
	
	
	for i in range(0, db.query_result.size()):

		waterItemText = "Water item: " + str(db.query_result[i]["water_item"])
		$Inventory/Wateritem.text = waterItemText

		foodItemText = "Food item: " + str(db.query_result[i]["food_item"])
		$Inventory/Fooditem.text = foodItemText

		energidrikItemText = "Energidrik item: " + str(db.query_result[i]["energidrik_item"]) 
		$Inventory/Energidrikitem.text = energidrikItemText

		waterItemText = "Water: " + str(db.query_result[i]["water_item"])
		$Shop/water.text = waterItemText

		foodItemText = "Food: " + str(db.query_result[i]["food_item"])
		$Shop/food.text = foodItemText

		energidrikItemText = "Energidrik: " + str(db.query_result[i]["energidrik_item"]) 
		$Shop/energidrik.text = energidrikItemText

		money = "Money: " + str(db.query_result[i]["money"]) 
		$Shop/Money.text = money

func _on_Gooutside_pressed():
	if $"go outside screen".visible == true:
		$"go outside screen".hide()
	else:
		$"go outside screen".show()


func _on_Shop_pressed():
	$Shop.show() == true


func _on_Gohome_pressed():
	$Shop.hide() == true


func _on_Bywater_pressed():
	update_data_increment("stats", "water_item", 1, "id = 1")
	update_data_increment("stats", "money", -20, "id = 1")
	readFromDB()



func _on_Byfood_pressed():
	update_data_increment("stats", "food_item", 1, "id = 1")
	update_data_increment("stats", "money", -10, "id = 1")
	readFromDB()


func _on_Byenergidrik_pressed():
	update_data_increment("stats", "energidrik_item", 1, "id = 1")
	update_data_increment("stats", "money", -15, "id = 1")
	readFromDB()


func increment_stat():
	var sql = "UPDATE stats SET %s = %s + %d WHERE player_id = %d;" 
	db.query(sql)



func update_data_increment(tableName: String, columnName: String, incrementValue: int, condition: String):
	var sql = "UPDATE %s SET %s = %s + %d WHERE %s;" % [tableName, columnName, columnName, incrementValue, condition]
	db.query(sql)


func _on_Arbejde_pressed():
	get_tree().change_scene("res://TowerMiniGame.tscn")










