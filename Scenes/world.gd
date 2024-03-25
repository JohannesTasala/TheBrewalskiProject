extends Node2D

@onready var hintLabel = $Map/DoorMonestry1/interactHint

var player
var nearDoor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("This is the world!")
	player = get_node("/root/world/Player/Player")
	checkPlayerPosition()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("interact") and nearDoor == true:
		print("entered the monestry")
		Game.playerLastPosition = player.global_position
		StageManager.changeStage(StageManager.monestry1)


func _on_door_monestry_1_area_entered(area):
	if area.name == "Body":
		nearDoor = true
		hintLabel.show()
		
	else:
		pass


func _on_door_monestry_1_area_exited(area):
	if area.name == "Body":
		nearDoor = false
		hintLabel.hide()
	else:
		pass
		
func checkPlayerPosition():
	if Game.playerLastPosition != Vector2(0, 0):
		
		player.global_position = Game.playerLastPosition
	else:
		pass
