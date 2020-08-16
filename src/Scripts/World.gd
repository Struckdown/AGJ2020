extends Node2D
export(NodePath) var time_node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(time_node).started = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
