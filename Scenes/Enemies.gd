extends Node2D

@onready var player = $"../Player/Player"
@onready var TimerGhost = $GhostTimer
@onready var TimerEmber = $EmberTimer

var ghost = preload("res://Scenes/ghost_enemy.tscn")
var ember = preload("res://Scenes/ember_enemy.tscn")

var playerTempPosition = Vector2(0, 0)



func _ready():
	TimerGhost.wait_time = 15
	TimerEmber.wait_time = 15


	
func spawnGhost():
	playerTempPosition = player.global_position
	

	var ghostTemp = ghost.instantiate()
	var rng = RandomNumberGenerator.new()
	var xPos = playerTempPosition.x + rng.randi_range(70, 120) * randomPicker()
	var yPos = playerTempPosition.y + rng.randi_range(70, 120) * randomPicker()

	ghostTemp.position = Vector2(xPos, yPos)
	add_child(ghostTemp)
	
	
func spawnEmber():
	playerTempPosition = player.global_position
	var emberTemp = ember.instantiate()
	var rng = RandomNumberGenerator.new()
	var xPos = playerTempPosition.x + rng.randi_range(70, 120) * randomPicker()
	var yPos = playerTempPosition.y + rng.randi_range(70, 120) * randomPicker()

	emberTemp.position = Vector2(xPos, yPos)
	add_child(emberTemp)

func randomPicker():
	var nums = [1,-1]
	return nums[randi() % nums.size()]

func _on_ghost_timer_timeout():
	spawnGhost()


func _on_ember_timer_timeout():
	spawnEmber()


func _on_hot_zone_area_entered(area):
	if area.name == "Body":
		print("hot zone entered")
		spawnRateUp()
	
	else :
		pass


func _on_hot_zone_area_exited(area):
	if area.name == "Body":
		print("hot zone exited")
		spawnRateDown()
	else :
		pass
		
func _on_safe_zone_area_entered(area):
	if area.name == "Body":
		stopEnemySpawn()
	else :
		pass


func _on_safe_zone_area_exited(area):
	if area.name == "Body":
		startEnemySpawn()
	else :
		pass

		
func spawnRateUp():
	TimerGhost.wait_time = 4
	TimerEmber.wait_time = 5
	
	
func spawnRateDown():
	TimerGhost.wait_time = 15
	TimerEmber.wait_time = 15
	
func stopEnemySpawn():
	TimerGhost.stop()
	TimerEmber.stop()
	
func startEnemySpawn():
	TimerGhost.start()
	TimerEmber.start()


