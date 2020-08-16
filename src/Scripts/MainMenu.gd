extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	$FadeoutRect.transition_to("res://Scenes/World.tscn", 2)
	


func _on_PlayButton_mouse_entered():
	$ButtonSFX.play()


func _on_ExitBtn_pressed():
	get_tree().quit()
