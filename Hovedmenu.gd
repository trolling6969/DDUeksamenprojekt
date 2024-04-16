extends Control
func _ready():
	Gs.connect("signedin", self, "signedin" )
	$popup.hide()
	$popup2.hide()

func _on_Play_button_down():
	if (Gs.signedin == false):
		print ("Cannot start game without being logged in")
		$popup.show()
	else:
		print ("Starting Game")
		get_tree().change_scene("res://placeholder.tscn")
	

func _on_LogIn_button_down():
	if (Gs.signedin == true):
		print ("Already logged in")
		$popup2.show()
	else:
		get_tree().change_scene("res://Node2D.tscn")


func _on_Exit_button_down():
	get_tree().quit()


func _on_popbutton_button_down():
	$popup.hide()


func _on_popbutton2_button_down():
	$popup2.hide()
