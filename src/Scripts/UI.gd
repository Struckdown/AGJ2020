extends Control

var score = 0
export(NodePath) var time_node
onready var timer: Node = (get_node(time_node) as Node)
export(NodePath) var time_label_node
onready var time_label := get_node(time_label_node)
export(NodePath) var points_label_node
onready var points_label := get_node(points_label_node)
export(NodePath) var win_menu_node
onready var win_menu := get_node(win_menu_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


func update():
	points_label.text = "Tincturings: " + str(score)
	var time_string = ""
	if win_menu.game_won:
		time_string = time_string + "Won at: "
	time_label.text = time_string + str(timer.get_formatted_time())
