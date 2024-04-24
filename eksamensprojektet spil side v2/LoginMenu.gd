extends Control

var username = ""
var password
var money = 101
var player_id

var registreret = false

const SQLite = preload ("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db 
var db_name = "res://DataStore/data" 
#var player_id = id

func _ready():
	$loginwrong.hide()
	$login.hide()
	db = SQLite.new()
	db.path = db_name
	readFromDB()


#func readFromDB():
#	db.open_db()
#	var tableName = "player_info"
#	db.query("select * from " + tableName + ";")
#	for i in range(0, db.query_result.size()):
#		id = "player_id" + str(db.query_result[i]["playerid"])
#	var statstable = "stats"
#	db.query("select * from " + statstable + ";")
func readFromDB():
	db.open_db()
	var tableName = "player_info"
	db.query("SELECT playerid FROM " + tableName + ";")
	if db.query_result.size() > 0:# Vi tager kun det første player_id, da der kan være flere rækker, men vi antager, at der kun er en bruger.
		player_id = int(db.query_result[0]["playerid"])


func checkLogin(name: String, password: String) -> bool:
	db.open_db()
	var tableName = "player_info"
	var sql = "SELECT COUNT(*) FROM %s WHERE name = '%s' AND password = '%s';" % [tableName, name, password]
	var result = db.query(sql)
	#for i in db.query_result:
	#	print(i) 
	if result and db.query_result[0].values()[0] > 0:
		return true  # Brugernavn og adgangskode matcher en række i databasen
	else:
		return false  # Brugernavn og adgangskode matcher ikke


func _on_Button_button_down():
#	var username = $Username.text
#	var password = $Password.text.sha256_text()
#	if !registreret:
#		username = $Username.text
#		password = $Password.text.sha256_text()
#		registreret = true
#		$Username.text = ""
#		$Password.text = ""
#
#		print ("Account has been created")
#		$Button2.hide()
#		$Button.hide()
#		$login.show()
#
#
#		db.open_db()
#		var tableName = "player_info"
#		var dict : Dictionary = {}
#		dict["name"] = username  # Brug variablen 'username' i stedet for $Username.text
#		dict["password"] = password  # Brug variablen 'password' i stedet for $Password.text
#		db.insert_row(tableName, dict)
#		readFromDB()
#
#
#
#		db.open_db()
#		var statstable = "stats"
#		var statsdict : Dictionary = {}  # Brug variablen 'username' i stedet for $Username.text 
##		statsdict["id"] = player_id
#		statsdict["job"] = 0
#		statsdict["edu"] = 0
#		statsdict["player_id"] = 36
#		statsdict["food_item"] = 0
#		statsdict["water_item"] = 0
#		statsdict["energidrik_item"] = 0
#		statsdict["money"] = money  # Brug variablen 'password' i stedet for $Password.text
#		db.insert_row(statstable, statsdict)
#		readFromDB()'
#	readFromDB()
#	var username = $Username.text
#	var password = $Password.text.sha256_text()
#	if !registreret:
#		username = $Username.text
#		password = $Password.text.sha256_text()
#		registreret = true
#		$Username.text = ""
#		$Password.text = ""
#		print ("Account has been created")
#		$Button2.hide()
#		$Button.hide()
#		$login.show()
#
#		# Opret ny bruger i player_info tabel og få player_id
#		db.open_db()
#		var tableName = "player_info"
#		var dict : Dictionary = {}
#		dict["name"] = username
#		dict["password"] = password
#		player_id = db.insert_row(tableName, dict)
#
#		# Opret ny række i stats tabel med det hentede player_id
#		db.open_db()
#		var statstable = "stats"
#		var statsdict : Dictionary = {}
#		statsdict["id"] = player_id
#		statsdict["job"] = 0
#		statsdict["edu"] = 0
#		statsdict["player_id"] = 0
#		statsdict["food_item"] = 0
#		statsdict["water_item"] = 0
#		statsdict["energidrik_item"] = 0
#		statsdict["money"] = money
#
#		db.insert_row(statstable, statsdict)

		# Opdater data fra databasen

	var username = $Username.text
	var password = $Password.text.sha256_text()
	if !registreret:
		username = $Username.text
		password = $Password.text.sha256_text()
		registreret = true
		$Username.text = ""
		$Password.text = ""
		print ("Account has been created")
		$Button2.hide()
		$Button.hide()
		$login.show()

		# Opret ny bruger i player_info tabel og få player_id
		db.open_db()
		var tableName = "player_info"
		var dict : Dictionary = {}
		dict["name"] = username
		dict["password"] = password
		db.insert_row(tableName, dict)
		var new_id = int(db.insert_row(tableName, dict))  # Fetch the player_id after inserting the row


		# Opret ny række i stats tabel med det hentede player_id
#		var statstable = "stats"
#		var statsdict : Dictionary = {}
#		statsdict["id"] = new_player_id  # Use the fetched player_id
#		statsdict["job"] = 0
#		statsdict["edu"] = 0
#		statsdict["player_id"] = new_player_id  # Use the fetched player_id
#		statsdict["food_item"] = 0
#		statsdict["water_item"] = 0
#		statsdict["energidrik_item"] = 0
#		statsdict["money"] = money
#		db.insert_row(statstable, statsdict)
#
#		# Opdater data fra databasen
#		readFromDB()
		
#		var statstable = "stats"
#		var statsdict : Dictionary = {}
#		statsdict["job"] = 0
#		statsdict["edu"] = 0
#		statsdict["player_id"] = new_player_id  # Use the fetched player_id
#		statsdict["food_item"] = 0
#		statsdict["water_item"] = 0
#		statsdict["energidrik_item"] = 0
#		statsdict["money"] = money
#		var stats_row_id = db.insert_row(statstable, statsdict)  # Fetch the ID of the inserted row
#
#		# Update the 'id' column in the stats table with the last inserted row ID
#		var sql_update = "UPDATE %s SET id = %d WHERE ROWID = %d;" % [statstable, stats_row_id, stats_row_id]
#		db.execute(sql_update)
#
#		# Opdater data fra databasen
#		readFromDB()


		# Opret ny række i stats tabel med det hentede player_id
#		var statstable = "stats"
#		var statsdict : Dictionary = {}
#		statsdict["id"] = new_id
#		statsdict["job"] = 0
#		statsdict["edu"] = 0
#		statsdict["player_id"] = 0  # Use the fetched player_id
#		statsdict["food_item"] = 0
#		statsdict["water_item"] = 0
#		statsdict["energidrik_item"] = 0
#		statsdict["money"] = money
#		var stats_row_id = db.insert_row(statstable, statsdict)  # Fetch the ID of the inserted row
#
#		# Opdater data fra databasen
#		readFromDB()
#
#		# Opdater referencen til playerid i stats tabellen
#		var sql_update = "UPDATE %s SET id = ? WHERE ROWID = ?;" % statstable#"UPDATE {0} SET player_id = {1} WHERE ROWID = {2};".format(statstable, new_player_id )#stats_row_id)#"UPDATE %s SET player_id = %d WHERE ROWID = %d;" % [statstable, new_player_id, stats_row_id]
#
#		db.execute(sql_update, [new_id, stats_row_id])
#		var new_id = int(db.insert_row(tableName, dict))
		var statstable = "stats"
		var statsdict : Dictionary = {}
		statsdict["id"] = new_id
		statsdict["job"] = 0
		statsdict["edu"] = 0
		statsdict["player_id"] = 0 # Brug det hentede player_id
		statsdict["food_item"] = 0
		statsdict["water_item"] = 0
		statsdict["energidrik_item"] = 0
		statsdict["money"] = money
		db.insert_row(statstable, statsdict)
		var stats_row_id = db.insert_row(statstable, statsdict)
		
#		var sql_update = "UPDATE %s SET id = %d WHERE ROWID = %d;" % {statstable: new_id, stats_row_id}
#		var sql_update = "UPDATE %s SET id = %d WHERE ROWID = %d;" % [statstable, new_id, stats_row_id]
#		var sql_update = "UPDATE %s SET id = %d WHERE ROWID = %d;" % {statstable: new_id, stats_row_id: stats_row_id}


#		db.execute(sql_update)
		
		readFromDB()
#		var stats_row_id = db.insert_row(statstable, statsdict)  # Hent ID'et for den indsatte række

#  var statstable = "stats"
#        var statsdict : Dictionary = {}
#        statsdict["id"] = new_id  # Use the fetched player_id
#        statsdict["job"] = 0
#        statsdict["edu"] = 0
#        statsdict["player_id"] = 0 # Use the fetched player_id
#        statsdict["food_item"] = 0
#        statsdict["water_item"] = 0
#        statsdict["energidrik_item"] = 0
#        statsdict["money"] = money
#        var stats_row_id = db.insert_row(statstable, statsdict) 
#
#        var sql_update = "UPDATE %s SET id = %d WHERE ROWID = %d;" % [statstable, new_id, stats_row_id]
#        db.execute(sql_update)
## Opdater data fra databasen
#		readFromDB()

#func _on_Button3_pressed():
#	var tableName = "player_info"
#	var dict : Dictionary = {}
#	var new_id = int(db.insert_row(tableName, dict))
#	var statstable = "stats"
#	var statsdict : Dictionary = {}
#	statsdict["id"] = new_id
#	statsdict["job"] = 0
#	statsdict["edu"] = 0
#	statsdict["player_id"] = 0 # Brug det hentede player_id
#	statsdict["food_item"] = 0
#	statsdict["water_item"] = 0
#	statsdict["energidrik_item"] = 0
#	statsdict["money"] = money
#	db.insert_row(statstable, statsdict)
##		var stats_row_id = db.insert_row(statstable, statsdict)  # Hent ID'et for den indsatte række
#
#
## Opdater data fra databasen
#	readFromDB()

# Opdater referencen til playerid i stats tabellen
#		var sql_update = "UPDATE %s SET player_id = ? WHERE ROWID = ?;" % statstable
#		db.execute(sql_update, [new_id, stats_row_id])
#		var sql_update = "UPDATE %s SET id = ? WHERE ROWID = ?;" % statstable
#		db.query(sql_update, [new_id, stats_row_id])

#	update_data_increment("stats", "id", 1, "")
#	readFromDB()
#
#func update_data_increment(tableName: String, columnName: String, incrementValue: int, condition: String):
#	var sql = "UPDATE %s SET %s = %s + %d WHERE %s;" % [tableName, columnName, columnName, incrementValue, condition]
#	db.query(sql)



#func _on_Button_button_down():
#	var username = $Username.text
#	var password = $Password.text.sha256_text()
#	if !registreret:
#		username = $Username.text
#		password = $Password.text.sha256_text()
#		registreret = true
#		$Username.text = ""
#		$Password.text = ""
#		print ("Account has been created")
#		$Button2.hide()
#		$Button.hide()
#		$login.show()
#
#        # Opret ny bruger i player_info tabel og få player_id
#		db.open_db()
#		var tableName = "player_info"
#		var dict : Dictionary = {}
#		dict["name"] = username
#		dict["password"] = password
#		player_id = db.insert_row(tableName, dict)
#
#        # Opret ny række i stats tabel med det hentede player_id
#		db.open_db()
#		var statstable = "stats"
#		var statsdict : Dictionary = {}
#		statsdict["job"] = 0
#		statsdict["edu"] = 0
#		statsdict["player_id"] = player_id
#		statsdict["food_item"] = 0
#		statsdict["water_item"] = 0
#		statsdict["energidrik_item"] = 0
#		statsdict["money"] = money
#		db.insert_row(statstable, statsdict)
#
#        # Opdater data fra databasen
#		readFromDB()


func _on_Button2_button_down():
	$Button.text = "Log In"
	$Button2.hide()
	$login.show()
	registreret = true
	if $Username.text == username:
			if $Password.text.sha256_text() == password:
				print ("Login Successful")
				Gs.signedin = true
				get_tree().change_scene("res://Hovedmenu.tscn")
				readFromDB()
			else:
				print ("Login Unsucessful")
				readFromDB()
	else:
		print ("Login Unsucessful")
		readFromDB()


func _on_loginwrong_button_down():
	$loginwrong.hide()


func _on_login_pressed():
	var username = $Username.text
	var password = $Password.text.sha256_text()
	if checkLogin(username, password):
		print("Login Successful")
		Gs.signedin = true
		Gs.emit_signal("signedin")
		get_tree().change_scene("res://Hovedmenu.tscn")
	else:
		print("Login Unsuccessful")
		$loginwrong.show()


