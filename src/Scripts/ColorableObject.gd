extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (NodePath) var levelManagerLink

signal colored
var hasBeenColoredBefore = false
var levelManager

# Called when the node enters the scene tree for the first time.
func _ready():
	levelManager = get_node(levelManagerLink)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Pass in a Color object
func color(newColor):
	$Sprite.modulate = newColor
	if !hasBeenColoredBefore:
		emit_signal("colored")	# TODO finish this
		levelManager.objectColored()
