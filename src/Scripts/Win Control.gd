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
var final_time_string = "N/A"
var final_time_seconds = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	top_level_control.visible = false
	#Connect button functionality
	var _err = continue_button.connect("pressed", self, "_win_menu_toggle", [false])
	_err = main_menu_button.connect("pressed", self, "_main_menu_switch")
	_err = application_close_button.connect("pressed", self, "_quit_application")
	
	#Connect button sound effects
	_err = continue_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	_err = main_menu_button.connect("mouse_entered", self, "_button_mouseover_sfx")
	_err = application_close_button.connect("mouse_entered", self, "_button_mouseover_sfx")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if win_menu_open and not game_won:
		_win_menu_toggle(true)

func _win_menu_toggle(on: bool) -> void:
	if on:
		if not game_won:
			timer.paused = true
			final_time_seconds = timer.get_seconds()
			final_time_string = timer.get_formatted_time()
			time_label.text = final_time_string
			GameManager.game_has_been_won_before = true
			if final_time_seconds > GameManager.high_score_seconds:
				GameManager.high_score_seconds = final_time_seconds
				GameManager.high_score_string = final_time_string
			game_won = true
	win_menu_open = on
	top_level_control.visible = on
	
func _main_menu_switch() -> void:
	var _err = get_tree().change_scene(main_menu_scene)
	get_tree().paused = false

func _quit_application() -> void:
	get_tree().quit()

func _button_mouseover_sfx() -> void:
	mouseover_soundeffect.play()
