extends Node2D

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	print("This is the world!")
	player = get_node("$Player/player")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
