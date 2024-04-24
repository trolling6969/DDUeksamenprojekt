extends Control
func _ready():
	Gs.connect("signedin", self, "signedin" )
	$popup.hide()
	$popup2.hide()
	$easypopup.hide()
	$mediumpopup.hide()
	$hardpopup.hide()
	$tutorial.hide()
	$endtutorial.hide()
	$easy.hide()
	$medium.hide()
	$hard.hide()
	

func _on_Play_button_down():
	if (Gs.signedin == false):
		print ("Cannot start game without being logged in")
		$popup.show()
	else:
		print ("Select dificulty")
		$tutorial.show()
		$endtutorial.show()
		$easy.show()
		$medium.show()
		$hard.show()


func _on_LogIn_button_down():
	if (Gs.signedin == true):
		print ("Already logged in")
		$popup2.show()
	else:
		get_tree().change_scene("res://Login.tscn")


func _on_Exit_button_down():
	get_tree().quit()


func _on_popbutton_button_down():
	$popup.hide()


func _on_popbutton2_button_down():
	$popup2.hide()
	

func _on_endtutorial_button_down():
	get_tree().change_scene("res://Node2D.tscn")
	print ("Starting game")
func _on_medium_button_down():
	$mediumpopup.show()

func _on_hard_button_down():
	$hardpopup.show()

func _on_easy_button_down():
	$easypopup.show()

func _on_easypopup_button_down():
	$easypopup.hide()

func _on_mediumpopup_button_down():
	$mediumpopup.hide()

func _on_hardpopup_button_down():
	$hardpopup.hide()
