extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	var _error = get_tree().change_scene("res://Scenes/World.tscn")


func _on_PlayButton_mouse_entered():
	$ButtonSFX.play()


func _on_ExitBtn_pressed():
	get_tree().quit()
