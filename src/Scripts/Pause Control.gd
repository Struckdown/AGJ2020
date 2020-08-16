extends Control
export(NodePath) var continue_button_node
onready var continue_button: Button = (get_node(continue_button_node) as Button)
export(NodePath) var main_menu_button_node
onready var main_menu_button: Button = (get_node(main_menu_button_node) as Button)
export(NodePath) var application_close_button_node
onready var application_close_button: Button = (get_node(application_close_button_node) as Button)
export(NodePath) var menu_sound_node
export(String, FILE) var main_menu_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible=false
	continue_button.connect("pressed", self, "_pause_toggle", [false])
	main_menu_button.connect("pressed", self, "_main_menu_switch")
	application_close_button.connect("pressed", self, "_quit_application")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause_toggle(not get_tree().paused)

func _pause_toggle(on: bool) -> void:
	self.visible = on
	get_tree().paused = on

func _main_menu_switch() -> void:
	get_tree().change_scene(main_menu_scene)

func _quit_application() -> void:
	get_tree().quit()
