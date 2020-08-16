extends Camera2D


export(NodePath) var Player_Path
var player
var goalPoint
var velocity = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(Player_Path)
	global_position = player.global_position
	goalPoint = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dist = (player.global_position - global_position).length_squared()
	if abs(dist) > 2000:
		updateGoal(player.global_position - global_position)
	var cur = global_position
	var d = (goalPoint - cur) * 0.01
	global_position += d


func updateGoal(vec):
	goalPoint = player.global_position + (1 * vec)
