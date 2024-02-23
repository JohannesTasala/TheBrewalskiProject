extends Node2D

var playerOnDepositArea
@onready var amountLabel = $WheatAmountLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	playerOnDepositArea = false
	amountLabel.text = str(Game.wheatAmountBrewery)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_deposit_area_area_entered(area):
	if area.name == "Body":
		playerOnDepositArea = true
		
		
	else:
		pass

func _on_deposit_area_area_exited(area):
	if area.name == "Body":
		playerOnDepositArea = false
		
	
	else:
		pass


func _unhandled_input(event):
	if event.is_action_pressed("interact") and playerOnDepositArea == true:
		_depositWheatToBrewery()
		print("deposited wheat")
		
		
func _depositWheatToBrewery():
	Game.wheatAmountBrewery += Game.wheatAmountInventory
	Game.wheatAmountInventory = 0
	amountLabel.text = str(Game.wheatAmountBrewery)
