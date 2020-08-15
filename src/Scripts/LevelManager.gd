extends Node

var objectsColored = 0
var winAmount = 3
export(NodePath) var UI_Path
var UI

# Called when the node enters the scene tree for the first time.
func _ready():
	UI = get_node(UI_Path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func objectColored():
	objectsColored += 1
	UI.score += 1
	UI.update()
	GlobalMusicPlayer.transitionToNextSong()
	if objectsColored >= winAmount:
		var _error = get_tree().change_scene("res://Scenes/VictoryLevel.tscn")
