extends KinematicBody2D

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO
export (PackedScene) var projectile
var newAnim
var curAnim
enum {LEFT, UP, DOWN, RIGHT}

func _ready():
	updateBow("left")

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		newAnim = "sideAnim"
		$Raine.flip_h = false
		updateBow(RIGHT)
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		newAnim = "sideAnim"
		$Raine.flip_h = true
		updateBow(LEFT)
	if Input.is_action_pressed('down'):
		velocity.y += 1
		newAnim = "downAnim"
		updateBow(DOWN)
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		newAnim = "upAnim"
		updateBow(UP)
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	if newAnim != curAnim:
		$RaineAnimPlayer.play(newAnim)
		curAnim = newAnim

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func shoot():
	$BowAnimPlayer.play("BowFire")
	$BowSFX.play()
	var b = projectile.instance()
	get_parent().add_child(b)
	b.transform = transform
	b.rotation  = get_angle_to(get_global_mouse_position())
	

# take in enum direction
func updateBow(dir):
	match dir:
		RIGHT:
			$"Rain Bow".offset = Vector2(25, 0)
			$"Rain Bow".frame = 3
		LEFT:
			$"Rain Bow".offset = Vector2(-25, 0)
			$"Rain Bow".frame = 1
		DOWN:
			$"Rain Bow".offset = Vector2(0, 25)
			$"Rain Bow".frame = 0
		UP:
			$"Rain Bow".offset = Vector2(0, -25)
			$"Rain Bow".frame = 2
