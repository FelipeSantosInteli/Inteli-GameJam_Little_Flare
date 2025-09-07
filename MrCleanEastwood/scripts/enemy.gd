extends Node2D

@onready var Sprite = $AnimatedSprite2D
@onready var onRange = false
@onready var GameManager = $"../GameManager"

var PlayerNode : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_atk_zone_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		PlayerNode = body
		onRange = true
		Sprite.play("melee")
		print(str(body, " entrou no alcance do inimigo"))
	
func _on_atk_zone_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		onRange = false

func _on_animated_sprite_2d_animation_changed() -> void:
	if Sprite:
		if Sprite.animation == "melee":
			print("Ataque inimigo")

func _on_animated_sprite_2d_animation_finished() -> void:
	if Sprite:
		if Sprite.animation == "melee":
			if onRange:
				Sprite.play("melee")
				print("tomou")
				PlayerNode.got_hit()
				GameManager.player_hit()
			else:
				Sprite.play("idle")
				print("errou")
