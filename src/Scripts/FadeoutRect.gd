extends ColorRect

export(String, FILE, "*.tscn") var next_scene_path
onready var _animation_player: AnimationPlayer = ($AnimationPlayer as AnimationPlayer)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.show_on_top=true
	pass # Replace with function body.

func transition_to(_next_scene_path:=next_scene_path, seconds:=1):
	_animation_player.play("fade_to_black", -1, 1.0/seconds)
	yield(_animation_player, "animation_finished")
	var _error = get_tree().change_scene(_next_scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
