extends Node2D

export(String, "RED", "GREEN", "BLUE") var color

# Called when the node enters the scene tree for the first time.
func _ready():
	match color:
		"RED":
			$Sprite.texture = load("res://Art/powerFlowerR.png")
			$AudioStreamPlayer2D.stream = load("res://Music/SFX/collect_red.wav")
		"GREEN":
			$Sprite.texture = load("res://Art/powerFlowerG.png")
			$AudioStreamPlayer2D.stream = load("res://Music/SFX/collect_green.wav")
		"BLUE":
			$Sprite.texture = load("res://Art/powerFlowerB.png")
			$AudioStreamPlayer2D.stream = load("res://Music/SFX/collect_blue.wav")
		_:
			print("No color found! Defaulting to red!")
			$Sprite.modulate = Color(1, 0, 0)
			$AudioStreamPlayer2D.stream = load("res://Music/SFX/collect_red.wav")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.updateColor(color)
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("flowerAnimate")

func _on_AudioStreamPlayer2D_finished():
	pass
