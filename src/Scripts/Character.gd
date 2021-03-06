extends KinematicBody2D

var speed = 155  # speed in pixels/sec
var velocity = Vector2.ZERO

var currentCharge = 0
var chargeRate = 2
var minCharge = 35
var maxCharge = 100
var bowLength = 25
var playedFullyChargedAnim = false
export (PackedScene) var projectile

export(String, "NONE", "RED", "GREEN", "BLUE") var weaponColors
var colorEquipped = "RED"
var colorNone = Color(0, 0, 0)
var colorRed = Color(255, 0, 0)
var colorGreen = Color(0, 255, 0)
var colorBlue = Color(0, 0, 255)
#var colorYellow = Color(255, 255, 0)

var newAnim
var curAnim
enum {LEFT, UP, DOWN, RIGHT}

func _ready():
	updateBow(false)
	currentCharge = 0
	updateColor("RED")

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		newAnim = "sideAnim"
		$Raine.flip_h = false
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		newAnim = "sideAnim"
		$Raine.flip_h = true
	if Input.is_action_pressed('down'):
		velocity.y += 1
		newAnim = "downAnim"
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		newAnim = "upAnim"
	# Make sure diagonal movement isn't faster
	if velocity == Vector2(0,0):
		$WalkingSFX.playing = false
		match newAnim:
			"upAnim":
				newAnim = "upIdleAnim"
			"downAnim":
				newAnim = "downIdleAnim"
			"sideAnim":
				newAnim = "sideIdleAnim"
	else:
		if $WalkingSFX.playing == false:
			$WalkingSFX.play()
	velocity = velocity.normalized() * speed

	if Input.is_action_pressed("shoot"):
		updateBow(true)
		charge()
	if Input.is_action_just_pressed("shoot"):
		$BowAnimPlayer.play("BowCharge")
	if Input.is_action_just_released("shoot"):
		updateBow(false)
		shoot()
		
	if newAnim != curAnim:
		$RaineAnimPlayer.play(newAnim)
		curAnim = newAnim

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func charge():
	currentCharge = clamp(currentCharge+chargeRate, minCharge, maxCharge)
	if currentCharge == maxCharge and !playedFullyChargedAnim:
		playedFullyChargedAnim = true
		$BowAnimPlayer.play("bowCharged")

	if !$BowSFX.playing and currentCharge < maxCharge:
		$BowSFX.stream = load("res://Music/SFX/bow_drawstring.wav")
		$BowSFX.play()

func shoot():
	$BowAnimPlayer.play("BowFire")
	var i = randi() % 2 + 1
	var bowFireSound = load("res://Music/SFX/bow_fire_" + str(i) + ".wav")
	$BowSFX.stream = bowFireSound
	$BowSFX.play()
	playedFullyChargedAnim = false
	
	var b = projectile.instance()
	get_parent().add_child(b)
	b.transform = $"Rain Bow".transform
	b.global_position = $"Rain Bow".global_position + $"Rain Bow".offset.rotated(get_angle_to(get_global_mouse_position()))
	b.rotation  = get_angle_to(get_global_mouse_position())
	b.applyCharge(float(currentCharge)/float(maxCharge))
	b.updateColor(colorEquipped)
	
	currentCharge = 0;
	

# take in enum direction
func updateBow(isVisible):
	$"Rain Bow".frame = 3
	$"Rain Bow".rotation = get_angle_to(get_global_mouse_position())
	#$"Rain Bow".offset = Vector2(bowOffset, 0)
	$"Rain Bow".offset = Vector2(bowLength, 0)
	$"Rain Bow".visible = isVisible


func updateColor(newColor):
	colorEquipped = newColor
	weaponColors = newColor

func playSparkles():
	$ScreenParticles.emitting = true


func updateWalkingSFX(newSFX):
	match newSFX:
		0:
			$WalkingSFX.stream = load("res://Music/SFX/walk_grass.wav")
		1:
			$WalkingSFX.stream = load("res://Music/SFX/walk_crunchy.wav")
		2:
			$WalkingSFX.stream = load("res://Music/SFX/walk_sidewalk.wav")
