extends Node2D


func _on_start_pressed():
	#Start the game
	print("start the game")
	#get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_quit_pressed():
	#Exit the game
	get_tree().quit()
