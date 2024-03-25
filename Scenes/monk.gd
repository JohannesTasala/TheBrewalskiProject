extends CharacterBody2D
class_name Monk

@onready var hintLabel = $interactHint
@onready var audio = $AudioStreamPlayer2D

const SPEED = 20.0
var nearPlayer

func _ready():
	nearPlayer = false

func _physics_process(delta):
	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("interact") and nearPlayer == true:
		print("interacted with monk")
		audio.play()
		Quest.updateQuest.emit()
		hintLabel.hide
	else:
		pass


func _on_interact_area_area_entered(area):
	if area.name == "Body":
		nearPlayer = true
		hintLabel.show()
	else:
		#stop moving around func here
		pass


func _on_interact_area_area_exited(area):
	if area.name == "Body":
		nearPlayer = false
		hintLabel.hide()
	else:
		#wander around randomly func here
		pass
