extends Node
export(NodePath) var top_level_control_node
onready var top_level_control: Control = (get_node(top_level_control_node) as Control)

export(String, FILE) var main_menu_scene

export(NodePath) var win_menu_node
onready var win_menu := get_node(win_menu_node)


# Called when the node enters the scene tree for the first time.
func _ready():
	top_level_control.visible=false
	
	#Connect button functionality
	$PauseMenuLayer/CenterContainer/PanelContainer/VBoxContainer/Continue_Btn.connect("pressed", self, "_pause_toggle", [false])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if not win_menu.win_menu_open:
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
	$mouseover_soundeffect.play()


func _on_Main_Menu_Btn_pressed():
	_main_menu_switch()


func _on_Exit_Btn_pressed():
	_quit_application()


func _on__Btn_mouse_entered():
	$mouseover_soundeffect.play()


func _on_Btn_mouse_entered():
	$mouseover_soundeffect.play()
