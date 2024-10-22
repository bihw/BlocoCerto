extends Node2D

func _ready():
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://StartScene.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://StartScene.tscn")

func _on_button_pressed():
	$Background/ColorRect2/Contacts.visible = true

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		var contacts_rect = $Background/ColorRect2/Contacts.get_global_rect()
		if not contacts_rect.has_point(event.global_position):
			$Background/ColorRect2/Contacts.visible = false
