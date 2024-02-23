class_name MyHitBox
extends Area2D

@export var damage = 10;
@onready var animation_player := $"../playerAnimation"

var isAttacking = false
#How many seconds the melee attack lasts
var attackTime = 0.3

func _init():
	collision_layer = 4
	collision_mask = 0
	
func  _ready():
	get_node("HitBox").disabled = true
	

func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("melee") and isAttacking == false:
		isAttacking = true
		
		get_node("HitBox").disabled = false
		get_node("Sprite2D").visible = true
		animation_player.play("melee")
		await get_tree().create_timer(attackTime).timeout
		animation_player.play("RESET")
		get_node("HitBox").disabled = true
		get_node("Sprite2D").visible = false
		isAttacking = false
