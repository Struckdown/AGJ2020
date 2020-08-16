extends Area2D

var speed = 1250
var currentSpeed = 750
var speedDecay = 15
export(String, "RED", "GREEN", "BLUE") var color

func _ready():
	pass

func _physics_process(delta):
	position += transform.x * currentSpeed * delta
	if currentSpeed>0:
		currentSpeed -= speedDecay
	if currentSpeed<=0:
		currentSpeed = 0
		$Sprite.hide()
		$Particles2D.emitting = false
		$Timer.start()

func updateColor(newColor):
	color = newColor
	match newColor:
		"RED":
			$Sprite.texture = load("res://Art/flowerShot.png")
			$Particles2D.texture = load("res://Art/petalTrail.png")
		"GREEN":
			$Sprite.texture = load("res://Art/flowerShotG.png")
			$Particles2D.texture = load("res://Art/petalTrailG.png")
		"BLUE":
			$Sprite.texture = load("res://Art/flowerShotB.png")
			$Particles2D.texture = load("res://Art/petalTrailB.png")

func applyCharge(chargePercentage):
	currentSpeed = chargePercentage*speed

func _on_ColorProjectile_body_entered(body):
	if body.has_method("color"):
		body.color(color)
		queue_free()


func _on_ColorProjectile_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area.is_in_group("colorable"):
		area.get_parent().increaseColor(color)
		spawnExplosionAnim()
		queue_free()

func spawnExplosionAnim():
	var explosionPath = load("res://Scenes/ColorExplosion.tscn")
	var explosion = explosionPath.instance()
	get_parent().add_child(explosion)
	explosion.transform = transform
	explosion.rotation_degrees += 90


func _on_Timer_timeout():
	queue_free()
