extends Node

var player_health = 4

@onready var UI = $"../Ui"

func player_hit():
	player_health -= 1
	print(player_health)
	UI.update(player_health)
	
func _ready() -> void:
	UI.health_points = player_health
	UI.player_hearts = player_health

func _process(delta: float) -> void:
	pass
