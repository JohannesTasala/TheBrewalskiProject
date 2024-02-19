extends TextureProgressBar

@export var ghostEnemy: GhostEnemy


func _ready():
	ghostEnemy.healthChanged.connect(update)
	update()



func update():
	value = ghostEnemy.currentHealth * 100 / ghostEnemy.maxHealth
	
