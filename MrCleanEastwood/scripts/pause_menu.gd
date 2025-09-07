extends Control

func resume():
	get_tree().paused = false
	visible = false
func pause():
	get_tree().paused = true
	visible = true

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_continuar_pressed():
	resume()

#func _on_quit_pressed():
	#get_tree().quit()

func _process(delta):
	testEsc()
