extends Control

var username = ""
var password

var registreret = false

func _ready():
	$loginwrong.hide()


func _on_Button_button_down():
	if !registreret:
		username = $Username.text
		password = $Password.text.sha256_text()
		registreret = true
		$Username.text = ""
		$Password.text = ""
		$Button.text = "Log In"
		print ("Account has been created")
		$Button2.hide()
	else:
		if $Username.text == username:
			if $Password.text.sha256_text() == password:
				print ("Login Successful")
				Gs.signedin = true
				Gs.emit_signal("signedin")
				get_tree().change_scene("res://Hovedmenu.tscn")
			else:
				print ("Login Unsucessful")
				$loginwrong.show()
		else:
			print ("Login Unsucessful")
			$loginwrong.show()


func _on_Button2_button_down():
	$Button.text = "Log In"
	$Button2.hide()
	if $Username.text == username:
			if $Password.text.sha256_text() == password:
				print ("Login Successful")
				Gs.signedin = true
				get_tree().change_scene("res://Hovedmenu.tscn")
			else:
				print ("Login Unsucessful")
	else:
		print ("Login Unsucessful")
		


func _on_loginwrong_button_down():
	$loginwrong.hide()
