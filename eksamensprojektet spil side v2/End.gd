extends Node2D


const SQLite = preload ("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db #database objekt 
var db_name = "res://DataStore/Data"


func _ready():
	$ScoreNumber.text = str(Global.score)
	$SalaryAfterTaxNumber.text = str(Global.score*0.6)
	$HeightNumber.text = str(Global.height)
	$PerfectNumber.text = str(Global.perfect)
	$ComboNumber.text = str(Global.max_combo)
	db = SQLite.new()
	db.path = db_name
	readFromDB()

func readFromDB():
	db.open_db()
	var tableName = "stats"
	db.query("select * from " + tableName + ";")

func update_data_increment(tableName: String, columnName: String, incrementValue: int, condition: String):
	var sql = "UPDATE %s SET %s = %s + %d WHERE %s;" % [tableName, columnName, columnName, incrementValue, condition]
	db.query(sql)
	readFromDB()


func increment_stat():
	var sql = "UPDATE stats SET %s = %s + %d WHERE player_id = %d;" 
	db.query(sql)
	readFromDB()

func _on_GoHome_pressed():
	update_data_increment("stats", "money", (Global.score*0.6), "id = 1")
	readFromDB()
	
	get_tree().change_scene("res://Node2D.tscn")


