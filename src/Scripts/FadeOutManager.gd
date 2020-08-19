extends Node

signal fadeFinished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fadeIn(outInsteadOfIn):
	if outInsteadOfIn:
		$AnimationPlayer.play("fade_to_black")
	else:
		$AnimationPlayer.play_backwards("fade_to_black")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("fadeFinished")
