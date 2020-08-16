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

export(NodePath) var time_node
onready var timer: Node = (get_node(time_node) as Node)
export(NodePath) var time_label_node
onready var time_label := get_node(time_label_node)


# Declare member variables here. Examples:
var win_menu_open = false
var game_won = false
var final_time = "N/A"


# Called when the node enters the scene tree for the first time.
func _ready():
	top_level_control.visible = false
	#Connect button functionality
	continue_button.connect("pressed", self, "_win_menu_toggle", [false])
	main_menu_button.connect("pressed", self, "_main_menu_switch")
	application_close_button.connect("pressed", self, "_quit_application")
	
	#Connect button sound effects
	continue_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	main_menu_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	application_close_button.connect("mouse_entered", self, "_button_mouseover_sfx")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if win_menu_open and not game_won:
		_win_menu_toggle(true)

func _win_menu_toggle(on: bool) -> void:
	if on:
		if not game_won:
			final_time = timer.get_formatted_time()
			time_label.text = final_time
		game_won = true
	win_menu_open = on
	top_level_control.visible = on
	
func _main_menu_switch() -> void:
	get_tree().change_scene(main_menu_scene)
	get_tree().paused = false

func _quit_application() -> void:
	get_tree().quit()

func _button_mouseover_sfx() -> void:
	mouseover_soundeffect.play()
