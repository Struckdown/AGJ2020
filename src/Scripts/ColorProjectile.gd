extends Area2D

var speed = 750
var color

func _ready():
	color = Color(randf(), randf(), randf())

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_ColorProjectile_body_entered(body):
	if body.has_method("color"):
		body.color(color)
		queue_free()
	else:
		print("No color on this body!")


func _on_ColorProjectile_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("colorable"):
		area.get_parent().increaseColor()
		queue_free()
		print("COLORED")
	else:
		print("No color!")
