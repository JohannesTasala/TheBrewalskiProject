extends Control

@onready var expBar := $ExpBar
@onready var levelUi := $LevelUi
@export var player: Player

var maxExp
var currentExp
var tempExp
var currentLevel


func _ready():
	Game.expChanged.connect(updateExp)
	maxExp = Game.playerMaxExp * (1.2 ** Game.playerLevel)
	expBar.max_value = maxExp
	expBar.value = Game.playerExp
	levelUi.text = str(Game.playerLevel)



func _process(delta):
	#updateExp()
	pass
	
	
	
func updateExp():
	currentExp = Game.playerExp
	if currentExp >= expBar.max_value:
		while currentExp >= expBar.max_value:
			currentExp = currentExp - expBar.max_value
			levelUp()
	
	else:
		pass
	
	Game.playerExp = currentExp
	expBar.value = currentExp
	
	
func levelUp():
	print("level up")
	Game.playerLevel = Game.playerLevel + 1
	levelUi.text = str(Game.playerLevel)
	maxExp = Game.playerMaxExp * (1.2 ** Game.playerLevel)
	expBar.max_value = maxExp
