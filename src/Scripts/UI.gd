extends Control

var score = 0
export(NodePath) var time_node
onready var timer: Node = (get_node(time_node) as Node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


func update():
	$CanvasLayer/Label.text = "Points:" + str(score)
	$CanvasLayer/Time.text = str(timer.get_formatted_time())
