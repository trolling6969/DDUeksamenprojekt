extends KinematicBody2D


var instance 
var attached = 0
var base_position = Vector2()
var sway_amount = 0
var gravity_scale = 0
var sway_time = 2.0


export var building = true
var going_right = true

export var built = false
var collision
var gravity = false
const GRAVITY = Vector2(0, 40 )
var velocity = Vector2()
var sprite_rect
var cutoff = 0
var col_shape
var new_shape

const PERFECT_DISTANCE = 2.0
const GOOD_DISTANCE = 6.0



func _unhandled_input(event):
	if building and event.is_action_pressed("drop", false):
		$Tween.remove(self, "position:x")
		building = false


func _physics_process(delta):
	if !building and !built:
		velocity += GRAVITY
		velocity = move_and_slide(velocity, Vector2.UP)
		if is_on_floor():
#			print(is_on_floor())
			collision = get_slide_collision(0)
#			print(collision)
			if collision.collider == get_parent().current_block:
				built = true
				get_parent().current_block = self
				var distance = abs(collision.collider.position.x - position.x)
				cutoff = collision.collider.position.x - position.x
				if distance < PERFECT_DISTANCE:
					position.x = collision.collider.position.x
					get_parent().increment_score(20)
				else:
					 if distance < GOOD_DISTANCE:
							get_parent().increment_score(15)
						else: 
							get_parent().increment_score(10)
				$Sprite.region_enabled = true
				sprite_rect = $Sprite.region_rect
				col_shape = $BlockBox.shape.get_extents()
				new_shape = RectangleShape2D.new()
				
				if cutoff > 0 :
					$Sprite.region_rect = Rect2(cutoff, sprite_rect.position.y, sprite_rect.size.x - cutoff, sprite_rect.size.y)
					new_shape.set_extents(Vector2( col_shape.x - (cutoff/2), col_shape.y))
					$BlockBox.shape = new_shape
				else:
					$Sprite.region_rect = Rect2(0, sprite_rect.position.y, sprite_rect.size.x + cutoff, sprite_rect.size.y)
					new_shape.set_extents(Vector2(col_shape.x + (cutoff/2), col_shape.y))
					$BlockBox.shape = new_shape
				
				print($Sprite.region_rect)
				
				position.x += cutoff / 2
				print(cutoff)
				get_parent().spawn_block()
#				print("Hej")
			else:
				get_parent().spawn_block()
				get_parent().increment_score(0)
#				print("Hejsa")
				queue_free()



func initialize(pos, sway, sway_time, current_block):
	$Sprite.region_rect = current_block.get_node("Sprite").region_rect
	$BlockBox.shape = current_block.get_node("BlockBox").shape
	base_position = pos
	position = pos
	position.x -= sway
	sway_amount = sway
	self.sway_time = sway_time
#	print(sway_time)
	$Tween.interpolate_property(self, "position:x", position.x, base_position.x + sway_amount, sway_time)
	$Tween.start() 



func _on_Tween_tween_completed(_object, _key):
	if going_right: 
		$Tween.interpolate_property(self, "position:x",  position.x, base_position.x - sway_amount, sway_time)
		$Tween.start()
		going_right = false
	else: 
		$Tween.interpolate_property(self, "position:x",  position.x,base_position.x + sway_amount, sway_time)
		$Tween.start()
		going_right = true

