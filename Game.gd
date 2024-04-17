extends Control

func _ready():
	$menu.hide()
	$saved.hide()


func _input(menu):
	if Input.is_action_just_pressed("menu") and $menu.visible == false:
		$menu.show()
		get_tree().paused = true

	

func _on_Continue_button_down():
	$menu.hide()
	$saved.hide()
	get_tree().paused = false

func _on_Save_button_down():
	print ("saving game")
	$saved.show()
	

func _on_exit_button_down():
	get_tree().quit()
