extends CanvasLayer

const world = ("res://Scenes/world.tscn")
const monestry1 = ("res://Scenes/monestry_inside.tscn")

@onready var anim = $AnimationPlayer


func changeStage(stagePath):
	get_tree().paused = true
	anim.play("TransIn")
	await anim.animation_finished
	get_tree().change_scene_to_file(stagePath)
	
	#var stage = stagePath.instantiate()
	#stage.get_node("Player/Player").position = Vector2(100, 100)
	#get_node("Player").position = Vector2(100, 100)
	
	anim.play("TransOut")
	get_tree().paused = false
	await anim.animation_finished
