extends TextureRect

@export var active := true

@onready var hrt_texture_full = preload("res://assets/Retro Inventory/Original/Hearts_Red_1.png")
@onready var hrt_texture_empty = preload("res://assets/Retro Inventory/Original/Hearts_Red_5.png")

func update():
	if active:
		self.texture = hrt_texture_full
	else:
		self.texture = hrt_texture_empty

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update()
