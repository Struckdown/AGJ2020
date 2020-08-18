extends Node
export(NodePath) var top_level_control_node
onready var top_level_control: Control = (get_node(top_level_control_node) as Control)
export(NodePath) var continue_button_node
onready var continue_button: TextureButton = (get_node(continue_button_node) as TextureButton)
export(NodePath) var main_menu_button_node
onready var main_menu_button: TextureButton = (get_node(main_menu_button_node) as TextureButton)
export(NodePath) var application_close_button_node
onready var application_close_button: TextureButton = (get_node(application_close_button_node) as TextureButton)
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
	var _err = continue_button.connect("pressed", self, "_pause_toggle", [false])
	_err = main_menu_button.connect("pressed", self, "_main_menu_switch")
	_err = application_close_button.connect("pressed", self, "_quit_application")
	
	#Connect button sound effects
	_err = continue_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	_err = main_menu_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	_err = application_close_button.connect("mouse_entered", self, "_button_mouseover_sfx")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		_pause_toggle(not get_tree().paused)

func _pause_toggle(on: bool) -> void:
	top_level_control.visible = on
	get_tree().paused = on

func _main_menu_switch() -> void:
	var _err = get_tree().change_scene(main_menu_scene)
	get_tree().paused = false

func _quit_application() -> void:
	get_tree().quit()

func _button_mouseover_sfx() -> void:
	mouseover_soundeffect.play()
