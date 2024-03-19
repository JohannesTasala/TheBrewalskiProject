extends CharacterBody2D
class_name EmberEnemy


@onready var player := get_node("../../Player/Player")

signal healthChanged

var Projectile = preload("res://Scenes/red_projectile.tscn")

var maxHealth = 20
var currentHealth = maxHealth
var SPEED = 30

var chase = false

var ableToAttack = false
var justAttacked = false
var attackTime = 1
var attackRange = 80
var stopDistance = 50


func _ready():
	set_motion_mode(CharacterBody2D.MOTION_MODE_FLOATING)


func _physics_process(delta):
	var targetDistance = self.position.distance_to(player.global_position)

		
	if chase == true and targetDistance >= stopDistance:
		var targetPosition = (player.global_position - self.position).normalized()
		velocity = Vector2(targetPosition * SPEED)
		
	else:
		velocity = Vector2(0, 0)
		
	move_and_slide()
	
	if targetDistance <= attackRange:
		ableToAttack = true
	else:
		ableToAttack = false
	
	if ableToAttack == true and justAttacked == false:
		shootProjectile()
	
	
func shootProjectile():
	var shootAngle = self.position.angle_to_point(player.global_position)
	
	var projectileTemp = Projectile.instantiate()
	get_tree().root.add_child(projectileTemp)
	projectileTemp.start(get_position(), shootAngle)
	
	justAttacked = true
	await get_tree().create_timer(attackTime).timeout
	justAttacked = false
	
	
func take_damage(amount: int):
	currentHealth = currentHealth - amount
	healthChanged.emit()
	
	#check if health is 0 or less and if true kill the enemy
	if currentHealth <= 0:
		Death()
		

func Death():
	Game.AddExp(30)
	queue_free()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
