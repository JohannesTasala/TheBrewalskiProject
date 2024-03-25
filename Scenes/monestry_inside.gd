extends Node2D

var nearDoor


func _ready():
	nearDoor = false


func _process(delta):
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("interact") and nearDoor == true:
		print("exited the monestry")
		StageManager.changeStage(StageManager.world)


func _on_door_area_entered(area):
	if area.name == "Body":
		nearDoor = true
		
	else:
		pass


func _on_door_area_exited(area):
	if area.name == "Body":
		nearDoor = false
		
	else:
		pass
