extends Node2D

@export var my_scenes: Array[PackedScene]

func _on_timer_timeout() -> void:
	var enemy = randi_range(0, my_scenes.size() - 1)
	var Inst = my_scenes[enemy].instantiate()
	Inst.position= $Marker2D.position
	add_child(Inst)
	$Timer.start(1)
