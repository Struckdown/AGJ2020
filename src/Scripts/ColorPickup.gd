extends Node2D

export(String, "RED", "GREEN", "BLUE") var color

# Called when the node enters the scene tree for the first time.
func _ready():
	match color:
		"RED":
			$Sprite.modulate = Color(1, 0, 0)
		"GREEN":
			$Sprite.modulate = Color(0, 1, 0)
		"BLUE":
			$Sprite.modulate = Color(0, 0, 1)
		_:
			print("No color found! Defaulting to red!")
			$Sprite.modulate = Color(1, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.updateColor(color)
