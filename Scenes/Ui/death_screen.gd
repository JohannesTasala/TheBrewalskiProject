extends Control

@onready var buttons = $MarginContainer/VBoxContainer/ButtonContainer
@onready var respawnB = $MarginContainer/VBoxContainer/ButtonContainer/Respawn
@onready var quitB = $MarginContainer/VBoxContainer/ButtonContainer/Quit

var duration = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons.modulate = Color(1, 1, 1, 0)
	respawnB.disabled = true
	quitB.disabled = true
	await get_tree().create_timer(1.5).timeout
	showButtons()
	respawnB.grab_focus()


func showButtons():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	var tween3 = get_tree().create_tween()
	tween.tween_property(buttons, "modulate:a", 1, duration)
	tween2.tween_property(respawnB, "disabled", false, duration)
	tween3.tween_property(quitB, "disabled", false, duration)


func _on_respawn_pressed():
	print("respawn pressed")
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_quit_pressed():
	print("quit pressed")
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
