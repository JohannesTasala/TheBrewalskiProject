extends Control

@export var player: Player

@onready var resumeB = $MarginContainer/VBoxContainer/Resume
@onready var sfx_slider = %volume_slider
@onready var input_type_button = %InputTypeButton

var user_prefs: UserPreferences

var confirm
var saveSuccesfull

# Called when the node enters the scene tree for the first time.
func _ready():
	user_prefs = UserPreferences.load_or_create()
	if sfx_slider:
		sfx_slider.value = user_prefs.sfx_audio_level
	if input_type_button:
		input_type_button.selected = user_prefs.input_type
	player.pauseGameSignal.connect(_on_pause_button_pressed)
	confirm = $MarginContainer/VBoxContainer/Quit/ConfirmationDialog
	saveSuccesfull = $"MarginContainer/VBoxContainer/Save Game/AcceptDialog"
	


func _on_pause_button_pressed():
	get_tree().paused = true
	show()
	resumeB.grab_focus()
	


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


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_input_type_button_item_selected(index):
	if index != -1:
		Game.INPUT_SCHEME = index
		Game.input_scheme_changed.emit(index)
		if user_prefs:
			user_prefs.input_type = index
			user_prefs.save()


func _on_volume_slider_value_changed(value):
	if user_prefs:
		user_prefs.sfx_audio_level = value
		user_prefs.save()
