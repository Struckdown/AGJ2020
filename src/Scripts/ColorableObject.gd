extends Node2D

var colorFraction = 0
var levelManager

signal colored
var signalEmitted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_tree().root.get_child(0).get_children()
	for child in children:
		if child.is_in_group("levelManager"):
			levelManager = child
			connect("colored", levelManager, "objectColored")

	var mat = get_node("Sprite").get_material().duplicate(true)
	get_node("Sprite").set_material(mat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func increaseColor():
	colorFraction += 0.2
	colorFraction = min(colorFraction, 1)
	$Sprite.material.set_shader_param("ColorLevel", colorFraction)
	if colorFraction >= 1 and !signalEmitted:
		signalEmitted = true
		emit_signal("colored")
