extends Node2D

func _ready():
	pass

func _enter_tree():
	Global.load_saved()
	var label = $Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/Label
	$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/SpinBox.value = Global.saved.lives_value
	if Global.saved.infinite_lives:
		$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/CheckButton.button_pressed = true
		$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/SpinBox.editable = false
		label.add_theme_color_override("font_color","#3d4048")
	else:
		$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/CheckButton.button_pressed = false
		$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/SpinBox.editable = true
		label.add_theme_color_override("font_color","#FFFFFF")
	
	var music = $Background/ColorRect/TextureRect/ColorRect2/Rect/MusicFlag
	if Global.saved.music_check:
		music.button_pressed = true
	else:
		music.button_pressed = false

func _on_back_pressed():
	Global.save_saved()
	get_tree().change_scene_to_file("res://StartScene.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://StartScene.tscn")

func _on_check_button_toggled(toggled_on):
	Global.saved.infinite_lives = toggled_on
	var label = $Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/Label
	if toggled_on:
		$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/SpinBox.editable = false
		label.add_theme_color_override("font_color","#3d4048")
	else: 
		$Background/ColorRect/TextureRect/ColorRect2/Rect/Lives/SpinBox.editable = true
		label.add_theme_color_override("font_color","#FFFFFF")

func _on_spin_box_value_changed(value):
	Global.saved.lives_value = value

func _on_music_flag_toggled(toggled_on):
	if toggled_on:
		if not (Global.music_player.is_playing()):
			Global.music_player.play()
			Global.music_player.seek(32.0)
			Global.tween = create_tween()
			Global.tween.tween_property(Global.music_player, "volume_db", 0, 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			Global.saved.music_check = true
	else:
		Global.music_player.stop()
		Global.saved.music_check = false
		print(Global.saved.music_check)

func _on_new_pressed():  # yes 3
	$Panel.visible = true
	$Panel/Clear.visible = false
	$Panel/NewSucess.visible = false
	$Panel/ClearSucess.visible = false
	$Panel/NewData.visible = true
	$Panel/Error.visible = false
	$Panel/Null.visible = false

func _on_clear_2_pressed():  # yes 2
	$Panel.visible = true
	$Panel/Clear.visible = true
	$Panel/NewSucess.visible = false
	$Panel/NewData.visible = false
	$Panel/ClearSucess.visible = false
	$Panel/Error.visible = false
	$Panel/Null.visible = false

func _on_yes_2_pressed():
	#var file_path = "res://data/dados.xml"
	#var dir = DirAccess.open("res://")
	var file_path = "/storage/emulated/0/Documents/BlocoCerto/dados.xml"
	var dir = DirAccess.open("/")
	if dir.file_exists(file_path):
		if dir.remove(file_path) == OK:
			print("Arquivo removido com sucesso.")
			$Panel.visible = true
			$Panel/Clear.visible = false
			$Panel/NewSucess.visible = false
			$Panel/NewData.visible = false
			$Panel/ClearSucess.visible = true
			$Panel/Error.visible = false
			$Panel/Null.visible = false
		else:
			print("Falha ao remover o arquivo.")
			$Panel.visible = true
			$Panel/Null.visible = true
			$Panel/Clear.visible = false
			$Panel/NewSucess.visible = false
			$Panel/NewData.visible = false
			$Panel/ClearSucess.visible = false
			$Panel/Error.visible = false
	else:
		print("Arquivo não encontrado.")
		$Panel.visible = true
		$Panel/Error.visible = true
		$Panel/Null.visible = false
		$Panel/Clear.visible = false
		$Panel/NewSucess.visible = false
		$Panel/NewData.visible = false
		$Panel/ClearSucess.visible = false
	
	for i in range(1, Global.saved.doc+1):
		var old_file_path = "/storage/emulated/0/Documents/BlocoCerto/dados(%s).xml" % str(i)
		dir.remove(old_file_path)
	
	
	clear()
	Global.save_saved()

func clear():
	Global.saved.doc = 0
	Global.saved.game = 0
	Global.saved.start_formatted_time = ''
	Global.saved.formatted_date = ''
	Global.saved.game_time = ''
	Global.saved.final_lives = ''
	Global.saved.hits = ''
	Global.saved.errors = ''
	Global.saved.block_errors = ''
	Global.saved.tool_errors = ''
	Global.saved.percentage = ''
	Global.saved.consecutive_block_errors = ''
	Global.saved.consecutive_tool_errors = ''
	Global.saved.repeated_block_error = ''
	Global.saved.repeated_tool_error = ''
	Global.saved.consecutive_hits = ''
	Global.saved.on_first_try = ''
	Global.saved.hit_average_time = ''
	Global.saved.random_clicks = ''
	Global.saved.on_first_try_Q1 = ''
	Global.saved.on_first_try_Q2 = ''
	Global.saved.on_first_try_Q3 = ''
	Global.saved.on_first_try_Q4 = ''
	Global.saved.wrong_block_Q1 = ''
	Global.saved.wrong_block_Q2 = ''
	Global.saved.wrong_block_Q3 = ''
	Global.saved.wrong_block_Q4 = ''
	Global.save_saved()

func _on_no_2_pressed():
	$Panel.visible = false
	$Panel/Clear.visible = false

func _on_yes_3_pressed():
	Global.saved.doc += 1
	Global.saved.game = 0
	Global.save_saved()
	$Panel.visible = true
	$Panel/NewData.visible = false
	$Panel/NewSucess.visible = true
	$Panel/Clear.visible = false
	$Panel/ClearSucess.visible = false
	$Panel/Error.visible = false
	$Panel/Null.visible = false

func _on_no_3_pressed():
	$Panel.visible = false
	$Panel/NewData.visible = false

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		var rect = $Panel.get_global_rect()
		if not rect.has_point(event.global_position):
			$Panel.visible = false
