extends Node
export(NodePath) var top_level_control_node
onready var top_level_control: Control = (get_node(top_level_control_node) as Control)
export(NodePath) var continue_button_node
onready var continue_button: Button = (get_node(continue_button_node) as Button)
export(NodePath) var main_menu_button_node
onready var main_menu_button: Button = (get_node(main_menu_button_node) as Button)
export(NodePath) var application_close_button_node
onready var application_close_button: Button = (get_node(application_close_button_node) as Button)
export(NodePath) var mouseover_soundeffect_node
onready var mouseover_soundeffect: AudioStreamPlayer = (get_node(mouseover_soundeffect_node) as AudioStreamPlayer)
export(String, FILE) var main_menu_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	top_level_control.visible=false
	
	#Connect button functionality
	continue_button.connect("pressed", self, "_pause_toggle", [false])
	main_menu_button.connect("pressed", self, "_main_menu_switch")
	application_close_button.connect("pressed", self, "_quit_application")
	
	#Connect button sound effects
	continue_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	main_menu_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	application_close_button.connect("mouse_entered", self, "_button_mouseover_sfx")	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_pause_toggle(not get_tree().paused)

func _pause_toggle(on: bool) -> void:
	top_level_control.visible = on
	get_tree().paused = on

func _main_menu_switch() -> void:
	get_tree().change_scene(main_menu_scene)
	get_tree().paused = false

func _quit_application() -> void:
	get_tree().quit()

func _button_mouseover_sfx() -> void:
	mouseover_soundeffect.play()
