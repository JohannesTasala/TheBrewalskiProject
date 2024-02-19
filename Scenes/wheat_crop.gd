extends Node2D

@onready var animation_player := $Wheat

var WheatDrop = preload("res://Scenes/wheat_drop.tscn")

var maxHealth = 1
var currentHealth
var respawnTime

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	respawnTime = 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func take_damage(amount: int):
	if animation_player.frame == 0:
		currentHealth = currentHealth - amount
		if currentHealth <= 0:
			animation_player.frame = 1
			
			#Create a wheat drop on the destroyed crop
			var wheatDropTemp = WheatDrop.instantiate()
			wheatDropTemp.position = Vector2(0, -4)
			call_deferred("add_child", wheatDropTemp)
			
			respawn_crop()
	else:
		return

#Timer and code to "Respawn" the wheat
func respawn_crop():
	await get_tree().create_timer(respawnTime).timeout
	currentHealth = maxHealth
	animation_player.frame = 0
