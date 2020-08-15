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


func _on_ColorProjectile_area_shape_entered(_area_id, area, _area_shape, _self_shape):
	if area.is_in_group("colorable"):
		area.get_parent().increaseColor(color)
		queue_free()
