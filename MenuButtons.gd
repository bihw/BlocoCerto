extends Node

func _on_start_pressed():
	get_tree().change_scene_to_file("res://GameScene.tscn")

func _on_statistics_pressed():
	get_tree().change_scene_to_file("res://StatisticsScene.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://SettingsScene.tscn")

func _on_info_pressed():
	get_tree().change_scene_to_file("res://InfoScene.tscn")

func _on_doubt_pressed():
	get_tree().change_scene_to_file("res://DoubtsScene.tscn")
