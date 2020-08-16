extends CanvasLayer
onready var _animation_player: AnimationPlayer = ($FadeinRect/AnimationPlayer as AnimationPlayer)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func transition_from_prev(seconds:=1):
	$FadeinRect.show_on_top=true
	#plays the fade-to-black animation backwards
	_animation_player.play("fade_from_black", -1, 1.0/seconds)
	yield(_animation_player, "animation_finished")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
