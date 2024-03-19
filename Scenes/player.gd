extends CharacterBody2D
class_name Player

signal playerHealthChanged
signal pauseGameSignal

@onready var audio = $AudioPlayers/AudioDrink


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
		get_node("PlayerSprite").flip_h = false
		get_node("PlayerSprite").offset = Vector2(0, 0)
	elif directionSideways == -1:
		get_node("PlayerSprite").flip_h = true
		get_node("PlayerSprite").offset = Vector2(-10, 0)

	
	if Game.playerCurrentHP <= 0:
		playerDeath()
		
	if Input.is_action_just_pressed("heal"):
		healPlayer(75)
		
	if Input.is_action_just_pressed("pause"):
		pauseGameSignal.emit()	
	
func take_damage(amount: int):
	#currentHealth = currentHealth - amount
	Game.playerCurrentHP -= amount
	playerHealthChanged.emit()
	

func healPlayer(amount: int):
	#should also check that is hp already full, if so dont heal
	if Game.beerAmount > 0 and Game.playerCurrentHP < Game.playerMaxHP:
		Game.beerAmount -= 1
		Game.playerCurrentHP += amount
		if Game.playerCurrentHP > Game.playerMaxHP:
			Game.playerCurrentHP = Game.playerMaxHP
		playerHealthChanged.emit()
		audio.play()
		

func playerDeath():
	print("player has died")
	#if the player dies, reset HP to maxHP and set Wheat amount to 0
	Game.playerCurrentHP = Game.playerMaxHP
	Game.wheatAmountInventory = 0

	queue_free()
	get_tree().change_scene_to_file("res://Scenes/Ui/death_screen.tscn")
	
	

