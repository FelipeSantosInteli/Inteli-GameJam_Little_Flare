extends Node2D

@export var speed: float = 50.0
@export var despawn_distance: float = 2000.0
var camera: Camera2D

func _ready():
	# Find the camera in the scene
	camera = get_viewport().get_camera_2d()
	
	# Randomize cloud appearance
	var sprite = $Sprite2D
	sprite.scale = Vector2(randf_range(1.0, 2.5), randf_range(1.0, 2.5))
	sprite.modulate.a = randf_range(0.3, 0.7)
	
	# Randomly choose cloud texture
	if randf() > 0.5:
		sprite.texture = preload("res://assets/Cloud 1.png")
	else:
		sprite.texture = preload("res://assets/Cloud 2.png")

func _process(delta):
	# Move cloud to the left
	position.x -= speed * delta
	
	# Check if cloud is far enough from camera to despawn
	if camera and position.x < camera.global_position.x - despawn_distance:
		queue_free()
