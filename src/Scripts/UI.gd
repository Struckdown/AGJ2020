extends Control

var score = 0
export(NodePath) var time_node
onready var timer: Node = (get_node(time_node) as Node)
export(NodePath) var time_label_node
onready var time_label := get_node(time_label_node)
export(NodePath) var points_label_node
onready var points_label := get_node(points_label_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


func update():
	points_label.text = "Points:" + str(score)
	time_label.text = str(timer.get_formatted_time())
