extends Node2D

func _ready():
	Global.load_saved()
	print(Global.saved.game)
	var game = str(Global.saved.game)
	if game == '0': game = ' '
	$Background/ColorRect/ColorRect/title.text = 'Jogo %s\nData do jogo: %s\nHorário de início: %s' % [game, Global.saved.formatted_date, Global.saved.start_formatted_time]
	$Background/ColorRect/ColorRect/Label.text = 'Duração do jogo: %s\nEstado final: %s
	Total de acertos: %s\nTotal de erros: %s\nErros (blocos): %s\nErros (ferramentas): %s\nPorcentagem total de erros: %s\nErros consecutivos (blocos): %s\nErros consecutivos (ferramentas): %s\nVezes que insistiu no bloco errado: %s' % [Global.saved.game_time, Global.saved.final_lives, Global.saved.hits, Global.saved.errors, Global.saved.block_errors, Global.saved.tool_errors, Global.saved.percentage, Global.saved.consecutive_block_errors, Global.saved.consecutive_tool_errors, Global.saved.repeated_block_error]
	$Background/ColorRect/ColorRect/Label2.text = 'Vezes que insistiu na ferramenta errada: %s
Acertos consecutivos: %s
Acertos de primeira: %s
Média de tempo até acerto: %s
Número de vezes em que houve cliques excessivos: %s
Acertos de primeira no quadrante superior esquerdo: %s
Acertos de primeira no quadrante superior direito: %s
Acertos de primeira no quadrante inferior esquerdo: %s
Acertos de primeira no quadrante inferior direito: %s
Erros no quadrante superior esquerdo: %s
Erros no quadrante superior direito: %s
Erros no quadrante inferior esquerdo: %s
Erros no quadrante inferior direito: %s
' % [Global.saved.repeated_tool_error, Global.saved.consecutive_hits, Global.saved.on_first_try, Global.saved.hit_average_time, Global.saved.random_clicks, Global.saved.on_first_try_Q1, Global.saved.on_first_try_Q2, Global.saved.on_first_try_Q3, Global.saved.on_first_try_Q4, Global.saved.wrong_block_Q1, Global.saved.wrong_block_Q2, Global.saved.wrong_block_Q3, Global.saved.wrong_block_Q4]


func _process(delta):
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://StartScene.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://StartScene.tscn")

func _on_more_pressed():
	$Background/ColorRect/ColorRect/Success.visible = true

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		var rect = $Background/ColorRect/ColorRect/Success.get_global_rect()
		if not rect.has_point(event.global_position):
			$Background/ColorRect/ColorRect/Success.visible = false
