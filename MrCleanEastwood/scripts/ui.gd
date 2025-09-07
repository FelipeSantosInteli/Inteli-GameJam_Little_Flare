extends CanvasLayer

@export var player_hearts : int
@onready var health_points : int

@onready var hearts = preload("res://scenes/heart.tscn")
@onready var heart_container = $Container/Health/HBoxContainer
@onready var active_hrts : Array

func update(health_points: int):
	print(str("HP: ", health_points))
	print(str("PH: ", player_hearts))
	if health_points > player_hearts:
		health_points = player_hearts
	if health_points >= 0:
		if health_points < player_hearts:
			var difference = int(player_hearts - health_points)
			active_hrts[difference * -1].active = false
			print(difference * -1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for heart in range(0,player_hearts):
		heart_container.add_child(hearts.instantiate())
	active_hrts = heart_container.get_children()
	print(active_hrts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
