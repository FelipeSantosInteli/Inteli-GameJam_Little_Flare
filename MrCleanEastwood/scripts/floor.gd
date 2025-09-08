extends ParallaxBackground

@onready var background : Vector2

func _process(delta: float) -> void:
	background.x -= 2
	set_scroll_offset(background)
