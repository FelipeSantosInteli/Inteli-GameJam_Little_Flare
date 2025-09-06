extends Sprite2D

@onready var shot_sound = $ShotSound
@onready var bullet_spawn = $BulletSpawn

const BULLET = preload("res://scenes/bullet.tscn")

#unc _process(delta: float) -> void:
	#look_at(get_global_mouse_position())

func shoot():
	var new_bullet = BULLET.instantiate()
	add_child(new_bullet)
	shot_sound.play()
