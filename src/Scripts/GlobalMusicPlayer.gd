extends AudioStreamPlayer

var MUSIC_LEVEL = 0
var SILENT_LEVEL = -80


var songLevel = 1
var desiredLevel = 1
var shouldTransition = false
var isTransitioning = false
var finishedTransition = false

var songPath
var newSong

var endingSongPlaying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	songPath = "res://Music/theme_1.wav"
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func transitionToNextSong():
	desiredLevel += 1


# Called when a track finishes. Decide if to loop or play the next song
func _on_GlobalMusicPlayer_finished():
	if songLevel != desiredLevel:
		shouldTransition = true

	if isTransitioning:
		isTransitioning = false
		finishedTransition = true
	if shouldTransition:
		songLevel += 1
		if songLevel != 3:
			songPath = "res://Music/theme_" + str(songLevel) + "_tran.wav"
			newSong = load(songPath)
			stream = newSong
			play(0)
		else:	# skip playing tran theme for 3 cause there is none
			finishedTransition = true
		isTransitioning = true
	else:	# play same song again
		play(0)

	if finishedTransition:	# play normal theme now
		songPath = "res://Music/theme_" + str(songLevel) + ".wav"
		newSong = load(songPath)
		stream = newSong
		play(0)
		finishedTransition = false
		isTransitioning = false

	print("Now playing: " + songPath)

	shouldTransition = false

func transitionToEndingSong():
	$Tween.interpolate_property(self, "volume_db", MUSIC_LEVEL, SILENT_LEVEL, 10, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	$Tween2.interpolate_property($SecondaryAudio, "volume_db", SILENT_LEVEL, MUSIC_LEVEL, 2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	songLevel = -1
	desiredLevel = -1
	$Tween.start()
	$Tween2.start()
	$SecondaryAudio.play()


func _on_Tween_tween_completed(_object, _key):
	if !endingSongPlaying:
		endingSongPlaying = true
