extends TextureProgressBar

@export var player: Player


# Called when the node enters the scene tree for the first time.
func _ready():
	player.playerHealthChanged.connect(updatePlayerHealth)
	updatePlayerHealth()



func updatePlayerHealth():
	value = Game.playerCurrentHP * 100 / Game.playerMaxHP
	
