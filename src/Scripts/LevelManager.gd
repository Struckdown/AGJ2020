extends Node

var colorFraction = 0
var previousColorFrac = 0
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
	previousColorFrac = colorFraction
	colorFraction = min(1, float(objectsColored) / float(totalAmountOfUpdates*partsBetweenUpdates))
	# Intpolate color slowly
	$Tween.interpolate_property(tileMap.get_material(), "shader_param/ColorLevel", previousColorFrac, colorFraction, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	$Tween.start()
