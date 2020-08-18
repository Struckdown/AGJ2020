extends Control

var startedGame = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMusicPlayer.reset()
	if GameManager.game_has_been_won_before:
		$BG.set_material(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_PlayButton_pressed():
	if startedGame:
		return
	startedGame = true
	$ThunderSFX.play()
	$MusicDelayTimer.start()
	$FadeoutRect.transition_to("res://Scenes/World.tscn", 2)
	


func _on_PlayButton_mouse_entered():
	$ButtonSFX.play()

func _on_ExitBtn_pressed():
	get_tree().quit()


func _on_MusicDelayTimer_timeout():
	GlobalMusicPlayer.start()
