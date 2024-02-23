extends Control

@export var player: Player
var confirm
var saveSuccesfull

# Called when the node enters the scene tree for the first time.
func _ready():
	player.pauseGameSignal.connect(_on_pause_button_pressed)
	confirm = $MarginContainer/VBoxContainer/Quit/ConfirmationDialog
	saveSuccesfull = $"MarginContainer/VBoxContainer/Save Game/AcceptDialog"


func _on_pause_button_pressed():
	get_tree().paused = true
	show()

	


func _on_resume_pressed():
	hide()
	get_tree().paused = false



func _on_quit_pressed():
	confirm.show()


func _on_confirmation_dialog_confirmed():
	get_tree().quit()


func _on_save_game_pressed():
	Utils.saveGame()
	saveSuccesfull.show()


func _on_load_game_pressed():
	Utils.loadGame()
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
