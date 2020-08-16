extends Node2D
export(String, "signboard", "streetlightR", "streetlightL") var propType

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = get_node("Sprite")
	sprite.set_animation(propType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
