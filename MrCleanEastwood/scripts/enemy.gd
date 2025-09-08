extends Node2D

@onready var Sprite = $AnimatedSprite2D
@onready var onRange = false

@export var enemy_health := 3

var selected = false
var is_hit := false

func hit():
	enemy_health -=1
	is_hit = true
	Sprite.play("dmg")
	print(enemy_health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprite.play("walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= 3
	if enemy_health == 0:
		Sprite.play("death")

func _on_atk_zone_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		onRange = true
		Sprite.play("atk")
		print(str(body, " entrou no alcance do inimigo"))
	
func _on_atk_zone_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		onRange = false

func _on_animated_sprite_2d_animation_changed() -> void:
	print(str(Sprite, " --> Enemy changed"))
	if Sprite:
		if Sprite.animation == "atk":
			print("Ataque inimigo")

func _on_animated_sprite_2d_animation_finished() -> void:
	if Sprite:
		if Sprite.animation == "atk" && !is_hit:
			if onRange:
				Sprite.play("atk")
				print("tomou")
				get_parent().get_node("GameManager").player_hit()
			else:
				Sprite.play("walk")
				print("errou")
		
		if Sprite.animation == "dmg":
			is_hit = false
			Sprite.play("walk")
		
		if Sprite.animation == "death":
			queue_free()

func _on_hit_zone_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("Click")
		hit()
