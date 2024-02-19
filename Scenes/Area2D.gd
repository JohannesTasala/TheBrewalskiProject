extends Area2D



var isAttacking = false
#How many seconds the melee attack lasts
var attackTime = 0.3

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("melee") and isAttacking == false:
		isAttacking = true
		print("attack")
		get_node("Sprite2D").visible = true
		await get_tree().create_timer(attackTime).timeout
		get_node("Sprite2D").visible = false
		isAttacking = false

