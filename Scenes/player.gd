extends CharacterBody2D
class_name Player

signal playerHealthChanged

var walkSpeed = 100.0
var sprintSpeed = 150.0
var SPEED




func _ready():
	set_motion_mode(CharacterBody2D.MOTION_MODE_FLOATING)

func _physics_process(delta):
	
	#Check if sprinting
	if Input.is_action_pressed("sprint"):
		SPEED = sprintSpeed
	else:
		SPEED = walkSpeed

	# Get the input direction and handle the movement
	var directionSideways = Input.get_axis("left", "right",)
	var directionUpDown = Input.get_axis("up", "down",)
	
	velocity = Vector2(directionSideways, directionUpDown).normalized() * SPEED
		
	move_and_slide()
	
	#Turn character and scythe based which way the player moves
	if directionSideways == 1:
		get_node("Character").flip_h = false
		get_node("Scythe").flip_v = true
		get_node("Scythe").offset = Vector2(0, 1)
	elif directionSideways == -1:
		get_node("Character").flip_h = true
		get_node("Scythe").flip_v = false
		get_node("Scythe").offset = Vector2(0, -1)

	
	if Game.playerCurrentHP <= 0:
		playerDeath()
		
	
	
func take_damage(amount: int):
	#currentHealth = currentHealth - amount
	Game.playerCurrentHP -= amount
	playerHealthChanged.emit()

func playerDeath():
	print("player has died")
	#if the player dies, reset HP to maxHP and set Wheat amount to 0
	Game.playerCurrentHP = Game.playerMaxHP
	Game.wheatAmountInventory = 0
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
