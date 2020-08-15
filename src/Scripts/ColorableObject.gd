extends Node2D

var colorFraction = 0
var levelManager
export (NodePath) var levelManagerLink

signal colored


# Called when the node enters the scene tree for the first time.
func _ready():
	levelManager = get_node(levelManagerLink)

	var mat = get_node("Sprite").get_material().duplicate(true)
	get_node("Sprite").set_material(mat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func increaseColor():
	colorFraction += 0.2
	colorFraction = min(colorFraction, 1)
	$Sprite.material.set_shader_param("ColorLevel", colorFraction)
	if colorFraction >= 1:
		emit_signal("colored")	# TODO finish this
		levelManager.objectColored()
