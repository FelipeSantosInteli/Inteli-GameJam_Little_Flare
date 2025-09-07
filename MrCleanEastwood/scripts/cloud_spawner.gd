extends Node2D

@export var cloud_scene: PackedScene = preload("res://scenes/cloud.tscn")
@export var spawn_interval: float =  9.0
@export var spawn_distance: float = 1500.0
@export var min_y: float = -50.0
@export var max_y: float = 250.0
@export var min_speed: float = 20.0
@export var max_speed: float = 80.0

var camera: Camera2D
var spawn_timer: Timer

func _ready():
	camera = get_viewport().get_camera_2d()
	
	# Create and setup timer
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_spawn_cloud)
	spawn_timer.autostart = true
	add_child(spawn_timer)

func _spawn_cloud():
	if not camera:
		camera = get_viewport().get_camera_2d()
		return
	
	var cloud = cloud_scene.instantiate()
	
	# Position cloud to the right of the camera view
	cloud.position.x = camera.global_position.x + spawn_distance
	cloud.position.y = randf_range(min_y, max_y)
	
	# Set random speed
	cloud.speed = randf_range(min_speed, max_speed)
	
	# Add to scene
	get_parent().add_child(cloud)
