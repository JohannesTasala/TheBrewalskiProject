extends CharacterBody2D

var walkSpeed = 70.0
var sprintSpeed = 110.0
var SPEED


func _physics_process(delta):
	
	#Check if sprinting
	if Input.is_action_pressed("sprint"):
		SPEED = sprintSpeed
	else:
		SPEED = walkSpeed
	
	

	# Get the input direction and handle the movement
	var directionSideways = Input.get_axis("left", "right",)
	if directionSideways:
		velocity.x = directionSideways * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionUpDown = Input.get_axis("up", "down",)
	if directionUpDown:
		velocity.y = directionUpDown * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#Turn character and scythe based which way the player moves
	if directionSideways == 1:
		get_node("Character").flip_h = false
		get_node("Scythe").flip_v = true
		get_node("Scythe").offset = Vector2(0, 1)
	elif directionSideways == -1:
		get_node("Character").flip_h = true
		get_node("Scythe").flip_v = false
		get_node("Scythe").offset = Vector2(0, -1)

	move_and_slide()
	
	
