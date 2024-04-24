extends Node2D


var current_block

var block = load("res://Block.tscn")
var instance 
var sway_amount = 100
var sway_time = 2
var score = 0
var combo = 0 
var max_combo = 0
const SPAWN_DISTANCE = Vector2(0,-120)
var health = 3
var height = 0
var perfect = 0 


func _ready():
	current_block = get_node("Block")
	spawn_block()
func _physics_process(delta):
	$Camera2D.position = lerp($Camera2D.position, current_block.position, 0.05)

func spawn_block():
	instance = block.instance()
	add_child(instance)
	instance.initialize(current_block.position + SPAWN_DISTANCE, sway_amount, sway_time, current_block)
	sway_amount += 1
	if sway_time > 1.4:
		sway_time -= 0.5
	else:
		sway_time = lerp(sway_time, 0.3, 0.05 )

func increment_score(num):
	if num == 20:
		height += 1
		score += num + (5 * combo)
		combo += 1
		perfect += 1
		if combo > max_combo:
			max_combo = combo
		
	elif num == 15 :
		height += 1
		score += num
		combo = 0
	elif num == 10:
		height += 1
		score += num
		combo = 0
	elif num == 0:
		combo = 0 
		health -= 1
		if health == 2:
			$Camera2D/HBoxContainer/Sprite3.visible = false
		elif health == 1:
			$Camera2D/HBoxContainer/Sprite2.visible = false 
		elif health == 0:
			$Camera2D/HBoxContainer/Sprite.visible = false
			Global.height = height
			Global.score = score
			Global.perfect = perfect
			Global.max_combo = max_combo
			if get_tree().change_scene("res://End.tscn") != OK:
				print ("Error in changing scene to End")
	
	$Camera2D/ScoreLabel.text = "Score:  " + str(score) + " dollars" 
	
	if combo != 0:
		$Camera2D/ComboLabel.text = "Combo: " + str(combo)
	else:
		$Camera2D/ComboLabel.text = ""
	
	







