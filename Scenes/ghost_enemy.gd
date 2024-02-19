extends CharacterBody2D
class_name GhostEnemy

@onready var animation_player := $AnimationPlayer
@onready var player := get_node("../../Player/Player")

signal healthChanged

var maxHealth = 40
var currentHealth = maxHealth
var SPEED = 40
#var player
var chase = false

var ableToAttack = false
var justAttacked = false
var attackDamage = 15
var attackTime = 1.5

func _ready():
	set_motion_mode(CharacterBody2D.MOTION_MODE_FLOATING)
	

func take_damage(amount: int):
	animation_player.play("hurt")
	currentHealth = currentHealth - amount
	healthChanged.emit()
	
	#check if health is 0 or less and if true kill the enemy
	if currentHealth <= 0:
		queue_free()


func _physics_process(delta):
	if chase == true:
		
		var targetPosition = (player.global_position - self.position).normalized()
		velocity = Vector2(targetPosition * SPEED)
		
	else:
		velocity = Vector2(0, 0)
		
	if ableToAttack == true and justAttacked == false:
		AttackPlayer()
	
		
		
	move_and_slide()
		
		

func AttackPlayer():
	if player.has_method("take_damage"):
		player.take_damage(attackDamage)
	
	justAttacked = true
	await get_tree().create_timer(attackTime).timeout
	justAttacked = false
	


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_deal_damage_area_entered(area):
	if area.name == "Body":
		ableToAttack = true


func _on_deal_damage_area_exited(area):
	if area.name == "Body":
		ableToAttack = false
