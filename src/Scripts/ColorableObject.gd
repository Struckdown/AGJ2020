extends Node2D

var colorFraction = 0
var levelManager
var acceptableColor
signal colored
var signalEmitted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_tree().root.get_child(1).get_children()
	for child in children:
		if child.is_in_group("levelManager"):
			levelManager = child
			var _error = connect("colored", levelManager, "objectColored")

	var mat = get_node("Sprite").get_material().duplicate(true)
	get_node("Sprite").set_material(mat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func increaseColor(color):
	if (color == acceptableColor) or true:	# TODO Remove true, set acceptable color
		colorFraction += 0.2
		colorFraction = min(colorFraction, 1)
		$Sprite.material.set_shader_param("ColorLevel", colorFraction)
		playHitSound(true)
		if colorFraction >= 1 and !signalEmitted:
			signalEmitted = true
			emit_signal("colored")
	else:
		playHitSound(false)


func playHitSound(isCorrect):
	var i = randi() % 2 + 1
	var hitSound
	if isCorrect:
		hitSound = load("res://Music/SFX/hit_valid_target_" + str(i) + ".wav")
	else:
		hitSound = load("res://Music/SFX/hit_invalid_target_" + str(i) + ".wav")
	$AudioStreamPlayer2D.stream = hitSound
	$AudioStreamPlayer2D.play()
