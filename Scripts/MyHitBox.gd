class_name MyHitBox
extends Area2D

@export var damage = 10;
@export var crit_chance = 15
@export var crosshair_range := 50.0

@onready var animation_player := $"../playerAnimation"
@onready var crosshair = $Crosshair
@onready var audio2 = $"../AudioPlayers/AudioMelee"

var isAttacking = false
#How many seconds the melee attack lasts
var attackTime = 0.3

func _init():
	collision_layer = 4
	collision_mask = 0
	
func  _ready():
	get_node("HitBox").disabled = true
	calculateDamage()
	Game.input_scheme_changed.connect(_on_input_scheme_changed)
	
	

func _process(delta):
	update_hitbox_rotation(delta)
	
	
#function to calculate players damage
func calculateDamage():
	var tempLevel = Game.playerLevel
	var damageModifier = 1
	var critModifier = 1
	
	for i in tempLevel:
		#for each player level, add to damageModifier
		damageModifier = damageModifier + 2
		
	print(damageModifier)
	damage = damage + damageModifier
		
func update_hitbox_rotation(delta, force_update_position = false) -> void:
	if Game.INPUT_SCHEME == Game.INPUT_SCHEMES.KEYBOARD_AND_MOUSE:
		look_at(get_global_mouse_position())
		crosshair.hide()
		
	elif Game.INPUT_SCHEME == Game.INPUT_SCHEMES.GAMEPAD:
		var aim_direction := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
		if aim_direction != Vector2.ZERO:
			var angle = aim_direction.angle()
			self.global_rotation = angle
			crosshair.global_position = global_position + (Vector2(cos(angle), sin(angle)) * crosshair_range)
		crosshair.global_rotation = 0
		crosshair.show()
		
	if Input.is_action_just_pressed("melee") and isAttacking == false:
		isAttacking = true
		audio2.play()
		get_node("HitBox").disabled = false
		get_node("Sprite2D").visible = true
		animation_player.play("melee")
		await get_tree().create_timer(attackTime).timeout
		animation_player.play("RESET")
		get_node("HitBox").disabled = true
		get_node("Sprite2D").visible = false
		isAttacking = false
		
func _on_input_scheme_changed(scheme):
	if scheme == Game.INPUT_SCHEMES.GAMEPAD:
		print("scheme changed")
		
		update_hitbox_rotation(0, true)
	else:
		pass
