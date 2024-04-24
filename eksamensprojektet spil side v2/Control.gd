extends Control

const SQLite = preload ("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db #database objekt 
var db_name = "res://DataStore/data" #path to db



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new()
	db.path = db_name
	commitDataToDB()
	readFromDB()
	pass # Replace with function body.



func commitDataToDB():
	db.open_db()
	var tableName = "player_info"
	var dict : Dictionary = Dictionary()
	dict["name"] = "this is a test user"
	dict["password"] = 1234

	db.insert_row(tableName,dict)

func readFromDB():
	db.open_db()
	var tableName = "player_info"
	db.query("select * from " + tableName + ";")
	for i in range(0, db.query_result.size()):
	#for i in range (0, db.query_result.size()):
		print("Query results ", db.query_result[i]["name"], db.query_result[i]["password"])

func getItemsByUserID(playerid):
	db.open_db()
	db.query("select * from player_info left join stats on player_info.playerid = stats.player_id where player_info.playerid  = " + playerid + ";")
	for i in range(0, db.query_result.size()):
	#for i in range (0, db.query_result.size()):
		print("Query results ", db.query_result[i]["name"], db.query_result[i]["password"])
