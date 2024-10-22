extends Node2D

func _ready():
	var pdf_path = "res://data/info.pdf"
	var new_path = "/storage/emulated/0/Documents/BlocoCerto/files/info.pdf"
	var dir_res = DirAccess.open("res://")
	
	var dir = DirAccess.open("/")
	var target_dir = "/storage/emulated/0/Documents/BlocoCerto/files"
	dir.make_dir_recursive(target_dir)
	
	dir_res.copy(pdf_path, new_path)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://StartScene.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://StartScene.tscn")

func _on_button_pressed():
	var pdf_path = "/storage/emulated/0/Documents/BlocoCerto/files/info.pdf"
	var dir = DirAccess.open("/")
	if dir.file_exists(pdf_path):
		OS.shell_open(pdf_path)
	else: 
		$Node2D/ColorRect/Error.visible = true

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		var rect = $Node2D/ColorRect/Error.get_global_rect()
		if not rect.has_point(event.global_position):
			$Node2D/ColorRect/Error.visible = false
