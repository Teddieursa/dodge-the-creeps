extends CanvasLayer

# notifies 'main' node that the button has been pressed
signal start_game


func show_message(text):
	print("fuckyou")
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	print("nobutactually")
	show_message("Game Over")
	# wait until the message timer has counted down.
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_start_button_pressed():
	print ("button pressed")
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print ("HUD here")


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float):
	pass
