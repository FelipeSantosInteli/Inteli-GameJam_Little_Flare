extends Area2D

@onready var Delay = $Delay

@export var DelayTime := 0.0

var hit : bool

func collision():
	print("Collision func")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Delay.wait_time = DelayTime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	Delay.start()
	hit = true
	
	print(str(body, " just entered ", self))
	print(str("Hit: ", hit))
	
func _on_body_exited(body: Node2D) -> void:
	Delay.stop()
	hit = false
	
	print(str(body, " just exited ", self))
	print(str("Hit: ", hit))
	
func _on_delay_timeout() -> void:
	if DelayTime > 0.0:
		print("Hit Timeout")
		collision()
		
