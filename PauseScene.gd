extends Node

signal quit_game

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_back_pressed():
	var main_script = get_node("/root/Game")
	if main_script.get_tree().paused:
		main_script._toggle_pause()

func _on_resume_pressed():
	var main_script = get_node("/root/Game")
	if main_script.get_tree().paused:
		main_script._toggle_pause()

func _on_restart_pressed():
	emit_signal("quit_game")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://GameScene.tscn")

func _on_home_pressed():
	emit_signal("quit_game")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://StartScene.tscn")


