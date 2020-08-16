extends Node


const COUNTUP_MODE = 1
const COUNTDOWN_MODE = 2
const MAX_TIME = 7200 # 2 hours. We might change this at some point


#false if in countup mode (stopwatch); true if in timer mode (countdown)
var started = false
var paused = false
var mode = COUNTUP_MODE
var _time = float(0)

# Called when the node enters the scene tree for the first time.
#func _ready():
#	var prev_systime = os.

func get_seconds():
	return _time
	
func get_formatted_time():
	var seconds_unmodded = int(_time)
	var minutes_unmodded = seconds_unmodded/60
	var hours = minutes_unmodded/60
	var seconds = seconds_unmodded % 60
	var minutes = minutes_unmodded % 60
	var formatted_time = "%02d:%02d:%02d" % [hours, minutes, seconds] 
	return formatted_time
	
func reset(seconds_count:float=0.0):
	_time = seconds_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Tick the stopwatch when it is running and not paused.
	if started and not paused:
		if mode == COUNTUP_MODE:
			# Prevent the time from rolling over by limiting it to the defined max time.
			_time = clamp(_time + delta, 0, MAX_TIME)
		elif mode == COUNTDOWN_MODE:
			_time = clamp(_time - delta, 0, MAX_TIME)
