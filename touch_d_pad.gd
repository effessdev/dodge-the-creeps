extends CanvasLayer

var direction = Vector2.ZERO


func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	var new_direction = Vector2.ZERO
	
	if $up.is_pressed():
		new_direction.y -= 1
	if $down.is_pressed():
		new_direction.y += 1
	if $right.is_pressed():
		new_direction.x += 1
	if $left.is_pressed():
		new_direction.x -= 1
	
	new_direction = new_direction.normalized()
	direction = new_direction
