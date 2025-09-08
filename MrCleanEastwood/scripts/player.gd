extends CharacterBody2D

@export var move_speed = 200.0

@export var knockback := 1.5

@export var can_jump = true

@export var jump_hight := 200.0
@export var jump_peak_time := 0.4
@export var jump_fall_time := 0.5

@onready var jump_velocity : float = ((2.0 * jump_hight) / jump_peak_time) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_hight) / pow(jump_peak_time,2)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_hight) / pow(jump_fall_time,2)) * -1.0

@onready var Col_default = $Col_default
@onready var Sprite = $Sprite2D

var is_hurt = false

#Return jump_gravity or fall_gravity depending on whether the player is going up or down
func _get_gravity() -> float:
	return jump_gravity if velocity.y < 0 else fall_gravity

func got_hit():
	is_hurt = true
	Sprite.play("hurt")
	velocity.x = knockback * -1000

func jump():
	velocity.y = jump_velocity
	Sprite.play("jump")

#Disable default collision shape to the shorter Col_crouch collision shape and change sprite aspect
func crouch(dir: float):
	Col_default.disabled = true
	Sprite.scale.y *= 0.8
	Sprite.position.y = 10
	velocity.x = dir * (move_speed * 0.3)
	#print(Col_default.disabled)

func ground_pound():
	velocity.y += _get_gravity() * 2.0 
 
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += _get_gravity() * delta
	Sprite.scale.y = 2.146
	Sprite.position.y = 0.0
	
	if is_on_floor() && velocity.x == 0.0 && !is_hurt:
		Sprite.play("walk", 1.0)
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction > 0 && !is_hurt:
		velocity.x = direction * 0.5 * move_speed
		if is_on_floor() && !is_hurt:
			Sprite.play("walk",1.4)
	elif direction < 0:
		velocity.x = direction * move_speed
		if is_on_floor() && !is_hurt:
			Sprite.play("walk",0.8)
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		
	#Handle the jump action
	if Input.is_action_just_pressed("ui_accept") && is_on_floor() && can_jump && !is_hurt:
		jump()

	if Input.is_action_pressed("ui_down") && is_on_floor():
		crouch(direction)
	elif Input.is_action_just_pressed("ui_down") && !is_on_floor():
		ground_pound()
	else:
		Col_default.disabled = false
		
	#print(velocity.x)
	
	move_and_slide()


func _on_sprite_2d_animation_finished() -> void:
	if Sprite.animation == "hurt" || Sprite.animation == "jump":
		is_hurt = false
		Sprite.play("walk")
