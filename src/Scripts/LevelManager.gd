extends Node

var objectsColored = 0
export(int) var partsBetweenUpdates = 5
export(int) var totalAmountOfUpdates = 3

export(NodePath) var UI_Path
var UI
export(NodePath) var tileMap_Path
var tileMap



# Called when the node enters the scene tree for the first time.
func _ready():
	UI = get_node(UI_Path)
	tileMap = get_node(tileMap_Path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func objectColored():
	objectsColored += 1
	UI.score += 1
	UI.update()
	if objectsColored % partsBetweenUpdates == 0:
		updateTilemap()
	GlobalMusicPlayer.transitionToNextSong()
	if objectsColored >= partsBetweenUpdates*totalAmountOfUpdates:
		var _error = get_tree().change_scene("res://Scenes/VictoryLevel.tscn")

func updateTilemap():
	var colorFraction = min(1, float(objectsColored) / float(totalAmountOfUpdates*partsBetweenUpdates))
	tileMap.material.set_shader_param("ColorLevel", colorFraction)

