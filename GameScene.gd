extends Node

const TOTAL = 42

@onready var original_position_anim = null
@onready var orig_position_tool_tip = $Tools/tip2.position

var lives = 0
var errors = 0.0
var block_errors = 0.0
var tool_errors = 0.0
var hits = 0.0
var correct  # bloco certo
var correct_tool  # ferramenta certa
var tool = null  # ferramenta atualmente escolhida
var correct_block_col
var correct_block_row
var correct_block_name
var new_array = []  # 42 blocos "sorteados"
var block_names = []  # nomes dos 42 blocos 
var picked_blocks = []  # número dos blocos já sorteados 
var last_one = false  # é último bloco?
var removed = []  # número dos blocos já retirados do tabuleiro
var consecutive_hits = 0
var correct_flag = false
var consecutive_tool_errors = 0
var consecutive_tool_error_flag = false
var consecutive_block_errors = 0
var consecutive_block_error_flag = false
var left_click = 0.0  # nro de cliques no lado esq do tab
var right_click = 0.0  # nro de cliques no lado dir do tab
var right = false  # o último clique foi no lado dir?
var top_click = 0.0  # nro de cliques parte superior do tab
var bottom_click = 0.0  # nro de cliques parte inferior do tab
var bottom = false  # o último clique foi na parte de baixo?
var finished = false
var upper_left_quadrant = 0
var upper_right_quadrant = 0
var lower_left_quadrant = 0
var lower_right_quadrant = 0
var on_first_try_Q1 = 0
var on_first_try_Q2 = 0
var on_first_try_Q3 = 0
var on_first_try_Q4 = 0
var wrong_block_Q4 = 0
var wrong_block_Q3 = 0
var wrong_block_Q2 = 0
var wrong_block_Q1 = 0
var first_try = true 
var on_first_try = 0  # nro de acerto de primeira
var on_first_try_left = 0  # nro de acertos de primeira do lado esq
var on_first_try_right = 0  # nro de acertos de primeira do lado dir
var on_first_try_bottom = 0
var on_first_try_top = 0
var wrong_block_right = 0
var wrong_block_left = 0
var wrong_block_bottom = 0
var wrong_block_top = 0
var random_clicks = 0  # nro de vezes que o user clicou de qualquer jeito na tela
var previous_n = null
var repeated_block_error = 0 
var previous_tool = null
var repeated_tool_error = 0 
var repeated_BE_count_same = 0
var repeat_flag = false
var took_a_long_time_start = 0
var taking_a_long_time_block = 0
var taking_a_long_time_tool = 0
var first_flag = true
var count_taking_a_long_time = 0
var wrong_with_answer_block = 0  # errou mesmo com a resposta dada
var wrong_with_answer_tool = 0
var long_time_with_answer_block = 0  # demorou mesmo com a resposta dada
var long_time_with_answer_tool = 0
var tips = 0  # total de dicas usadas (sem contar primeira jogada sem ferramenta)
var init_tool_tips = 0  # usou dica inicial "sem ferramenta" (primeira jogada)
var tool_tips_total = 0  # vezes que usou dicas de ferramenta (sem contar a primeira jogada sem ferramenta)
var tool_tips_1 = 0
var tool_tips_2 = 0
var block_tips_total = 0  # vezes que usou dicas de blocos
var block_tips_1 = 0
var block_tips_2 = 0
var block_tips_3 = 0
var block_tips_4 = 0
var tip_given = false
var r  # rand dicas
var rect_position  # posição do tabuleiro
var rect_size  # tamanho do tabuleiro
var current_date
var formatted_date
var start_real_time
var start_formatted_time
var time_play
var time_tool_tips_long_time = []  # ---- tempo de jogo que as dicas foram usadas
var time_tool_tips_error = [] 
var time_block_tips_long_time = [] 
var time_block_tips_error = [] 
var percentage = 0.0
var game_time
var hit_average_time
var consecutive_BE = 0
var final_lives = null
var victory_ = false

# 1=picareta, 2=machado, 3=pá
var all_blocks = [
	["Badlands_Grass.png",3], ["Dirt.png",3], ["Dirt_Path.png",3], ["Farmland.png",3], ["Farmland_Wet.png",3],
	["Grass.png",3], ["Grass_Block.png",3], ["Grass_Dirt_Block.png",3], ["Mycelium.png",3], ["Podzol.png",3],
	["Red_Sand.png",3], ["Sand.png",3], ["Snowy_Grass.png",3], ["Snowy_Grass_Block.png",3], ["Snowy_Beach_Grass_Block.png",3], 
	["Snow_Block.png",3], 
	["Acacia_Log.png",2], ["Acacia_Planks.png",2], ["Bamboo.png",2], ["Bamboo_Left.png",2], ["Bamboo_Right.png",2], 
	["Birch_Log.png",2], ["Birch_Log_Left.png",2], ["Birch_Log_Right.png",2], ["Birch_Planks.png",2], ["Cherry_Log.png",2], 
	["Cherry_Planks.png",2], ["Crimson_Planks.png",2], ["Dark_Oak_Log.png",2], ["Dark_Oak_Planks.png",2], 
	["Jungle_Log.png",2], ["Jungle_Planks.png",2], ["Mangrove_Log.png",2], ["Mangrove_Planks.png",2], ["Oak_Log.png",2], 
	["Oak_Log_Left.png",2], ["Oak_Log_Right.png",2], ["Oak_Planks.png",2], ["Some_Log_Left.png",2], ["Some_Log_Right.png",2], 
	["Spruce_Log.png",2], ["Spruce_Log_Left.png",2], ["Spruce_Log_Right.png",2], ["Spruce_Planks.png",2], 
	["Stripped_Acacia_Log.png",2], ["Stripped_Cherry_Log.png",2], ["Stripped_Crimson_Log.png",2], 
	["Stripped_Dark_Oak_Log.png",2], ["Stripped_Jungle_Log.png",2], ["Stripped_Mangrove_Log.png",2], 
	["Stripped_Oak_Log.png",2], ["Stripped_Spruce_Log.png",2], ["Stripped_Warped_Stem.png",2], ["Warped_Planks.png",2], 
	["Block_of_Amethyst.png",1], ["Block_of_Diamond.png",1], ["Block_of_Gold.png",1], ["Block_of_Lapis_Lazuli.png",1], 
	["Block_of_Netherite.png",1], ["Block_of_Raw_Copper.png",1], ["Block_of_Raw_Gold.png",1], ["Block_of_Redstone.png",1], 
	["Bricks.png",1], ["Coal_Ore.png",1], ["Cobblestone.png",1], ["Copper_Block.png",1], ["Copper_Ore.png",1], 
	["Cracked_Deepslate_Brick.png",1], ["Cracked_Stone_Brick.png",1], ["Cut_Copper.png",1], ["Deepslate.png",1], 
	["Deepslate_Bricks.png",1], ["Diamond_Ore.png",1], ["Double_Stone_Slab.png",1], ["Emerald_Ore.png",1], 
	["End_Stone_Bricks.png",1], ["Exposed_Cut_Copper.png",1], ["Gold_Ore.png",1], ["Iron_Ore.png",1], 
	["Lapis_Lazuli_Ore.png",1], ["Mossy_Cobblestone.png",1], ["Mossy_Stone_Brick.png",1], ["Polished_Andesite.png",1], 
	["Polished_Blackstone_Brick.png",1], ["Polished_Deepslate.png",1], ["Polished_Diorite.png",1], 
	["Quartz_Bricks_JE2.png",1], ["Redstone_Ore.png",1], ["Smooth_Stone.png",1], ["Stone.png",1], ["Stone_Brick.png",1], 
	["Weathered_Cut_Copper.png",1]
]

# timer até o primeiro clique
var start_time_1 = 0.0
var timer_1_started = false
var timer_click_1 = Timer.new()
var warning_timer_1 = Timer.new()  # timer pro aviso primeiro clique
# timer até acerto - média
var elapsed_time_hit = 0.0
var timer_hit_running = false
var timer_hit = Timer.new()
var time_hit_sum = 0
# timer mts cliques em pouco tempo
var timer_clicks = Timer.new()
var click_count = 0  # cliques em pouco tempo
var click_threshold = 3  # número de cliques para considerar como "muitos"
var time_interval = 0.5  # intervalo de tempo em segundos
# timer aviso durante o jogo
var warning_timer_2 = Timer.new()
var wait_time = 7.5

@onready var timer_label = $Timer
var total_time = 0.0

func _ready():
	Global.load_saved()
	if Global.saved.game == null or Global.saved.game == 0:
		Global.saved.game = 1
	else: 
		Global.saved.game += 1
	Global.save_saved()
	
	current_date = Time.get_date_dict_from_system()
	formatted_date = "%02d/%02d/%04d" % [current_date.day, current_date.month, current_date.year]
	start_real_time = Time.get_time_dict_from_system()
	start_formatted_time = "%02dh:%02dmin:%02ds" % [start_real_time.hour, start_real_time.minute, start_real_time.second]
	
	$Tools/tip1.visible = false
	$Tools/tip2.visible = false
	lives = Global.saved.lives_value
	lives_screen_update()
	original_position_anim = $Board/Back/TextureRect.position
	$Board/InitAnimation/AnimationPlayer.play("animation")
	rect_position = $Board/Back.position
	rect_size = $Board/Back.size
	
	# timers até o primeiro clique
	add_child(timer_click_1)
	add_child(warning_timer_1)  # aviso inicio
	timer_click_1.one_shot = true
	warning_timer_1.one_shot = false
	warning_timer_1.wait_time = wait_time
	timer_click_1.start()
	warning_timer_1.connect("timeout", Callable(self, "_on_warning_timeout_1"))
	warning_timer_1.start()
	start_time_1 = Time.get_ticks_msec()
	# timer até acerto
	add_child(timer_hit)
	timer_hit.connect("timeout", Callable(self, "_on_timer_timeout"))
	start_timer_hit()
	# timer cliques
	timer_clicks.wait_time = time_interval
	timer_clicks.one_shot = true
	timer_clicks.connect("timeout", Callable(self, "_on_click_timer_timeout"))
	add_child(timer_clicks)
	# timer aviso durante o jogo
	add_child(warning_timer_2)
	warning_timer_2.one_shot = false
	warning_timer_2.wait_time = wait_time 
	warning_timer_2.connect("timeout", Callable(self, "_on_warning_timeout_2"))
	warning_timer_2.start()

func _process(delta):
	if not get_tree().paused and not finished:
		total_time += delta
	update_timer_label()

func update_timer_label():
	var minutes = int(total_time / 60)
	var seconds = int(total_time) % 60
	var milliseconds = int((total_time - int(total_time)) * 100)
	timer_label.text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func start_timer_hit():
	timer_hit.wait_time = 0.1  # Intervalo de tempo para checagem (0.1s)
	timer_hit.start()
	timer_hit_running = true
func stop_timer_hit():
	timer_hit.stop()
	timer_hit_running = false

func _on_timer_timeout():
	if timer_hit_running:
		elapsed_time_hit += timer_hit.wait_time

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		click_count += 1
		timer_clicks.start()
		if click_count >= click_threshold:
			random_clicks += 1
			$ErrorMessage/ColorRect/TextureRect2.visible = true
			show_error_message(1.3)
			print("Muitos cliques em um curto intervalo de tempo!")
			click_count = 0  # Resetar contagem de cliques
		
		var mouse_position = event.position
		if is_inside_rect(mouse_position):
			if mouse_position.x < (rect_position.x + rect_size.x / 2) - 62.857143:
				left_click += 1
				right = false
				print("Clique: lado esquerdo do tabuleiro")
			else:
				right_click += 1
				right = true
				print("Clique: lado direito do tabuleiro")
			if mouse_position.y < (rect_position.y + rect_size.y / 2):
				top_click += 1
				bottom = false
				print("Clique: parte superior do tabuleiro")
			else:
				bottom_click += 1
				bottom = true
				print("Clique: parte inferior do tabuleiro")
			
			var center_x = (rect_position.x + rect_size.x / 2) - 62.857143
			var center_y = rect_position.y + rect_size.y / 2
			if mouse_position.x < center_x:
				if mouse_position.y < center_y:
					upper_left_quadrant += 1
					print("Clique: quadrante superior esquerdo")
				else:
					lower_left_quadrant += 1
					print("Clique: quadrante inferior esquerdo")
			else:
				if mouse_position.y < center_y:
					upper_right_quadrant += 1
					print("Clique: quadrante superior direito")
				else:
					lower_right_quadrant += 1
					print("Clique: quadrante inferior direito")
			
	# timer até o primeiro clique
	if event is InputEventMouseButton and event.pressed and not timer_1_started:
		warning_timer_1.stop()
		timer_click_1.stop()
		var end_time = Time.get_ticks_msec()
		var elapsed_time = (end_time - start_time_1) / 1000.0  # converte para segundos
		print("Tempo até o primeiro clique: ", elapsed_time, " segundos")
		timer_1_started = true
	warning_timer_2.start()  # timer cliques durante o jogo

func _on_click_timer_timeout():
	click_count = 0  # Resetar contagem de cliques quando o tempo expira (cliques dms)

func _on_warning_timeout_1():  # aviso timer demorando para começar
	print("Você está demorando demais para começar!")
	took_a_long_time_start += 1

func _on_warning_timeout_2():  # aviso timer clique demorando durante o jogo
	print("Você está demorando demais para clicar!")
	count_taking_a_long_time += 1
	if not (first_flag):
		if (tool == correct_tool):
			taking_a_long_time_block += 1
			tips += 1
			block_tips_total += 1
			if (taking_a_long_time_block == 2):
				block_tip_1()  # dica suporte 1 maior
				var time_tip = calculate_elapsed_time()
				time_block_tips_long_time.append(time_tip)
			if (taking_a_long_time_block == 3):
				block_tip_2()  # dica suporte 2
				var time_tip = calculate_elapsed_time()
				time_block_tips_long_time.append(time_tip)
			if (taking_a_long_time_block == 4):
				block_tip_3()  # dica suporte 3
				var time_tip = calculate_elapsed_time()
				time_block_tips_long_time.append(time_tip)
			if (taking_a_long_time_block == 5):
				block_tip_4()  # dica suporte 4
				var time_tip = calculate_elapsed_time()
				time_block_tips_long_time.append(time_tip)
			if (taking_a_long_time_block > 5):
				block_tip_4()  # dica suporte 4
				long_time_with_answer_block += 1 # demorou com a resposta dada
				var time_tip = calculate_elapsed_time()
				time_block_tips_long_time.append(time_tip)
	if (tool != correct_tool):
		if tool == null:
			$ToolsMessage.visible = true
			$ToolsMessage/AnimationPlayer.play("ToolsMessage")
		else:
			tips += 1
			tool_tips_total += 1
			taking_a_long_time_tool += 1
			if (taking_a_long_time_tool == 2):
				tool_tip_1()  # dica tool maior
				var time_tip = calculate_elapsed_time()
				time_tool_tips_long_time.append(time_tip)
			if (taking_a_long_time_tool == 3):
				tool_tip_2()  # dica tool
				var time_tip = calculate_elapsed_time()
				time_tool_tips_long_time.append(time_tip)
			if (taking_a_long_time_tool > 3):
				tool_tip_2()  # dica tool
				long_time_with_answer_tool += 1  # demorou com a resposta dada
				var time_tip = calculate_elapsed_time()
				time_tool_tips_long_time.append(time_tip)
	first_flag = false

func calculate_elapsed_time():
	var time_play = total_time
	var minutes = int(time_play / 60)
	var seconds = int(time_play) % 60
	var milliseconds = int((time_play - int(time_play)) * 1000)
	return "%dmin %ds %03dms" % [minutes, seconds, milliseconds]

func is_inside_rect(point):
	return point.x >= rect_position.x and point.x <= rect_position.x + rect_size.x and \
		   point.y >= rect_position.y and point.y <= rect_position.y + rect_size.y

func block_tip_1():  # dica bloco maior
	block_tips_1 += 1
	var tip_rect = $Board/tipRects/big2/TextureRect
	var board_x = $Board/Back.position.x
	var board_y = $Board/Back.position.y
	var board_width = $Board/Back.size.x
	var board_height = $Board/Back.size.y
	var cols = 7
	var rows = 6
	var width_cell = board_width / cols
	var height_cell = board_height / rows
	var tip_width = tip_rect.size.x
	var tip_height = tip_rect.size.y
	row_col_correct_block()
	var x_tip = board_x + (correct_block_col - 1) * width_cell
	var y_tip = board_y + (correct_block_row - 1) * height_cell
	if correct_block_row <= 2:
		y_tip = y_tip - height_cell
		if correct_block_col <= 4:
			x_tip = x_tip - 4 * width_cell
	if correct_block_col <= 4:
		x_tip = x_tip - 4 * width_cell
	x_tip = clamp(x_tip, board_x, board_x + board_width - tip_width)
	y_tip = clamp(y_tip, board_y, board_y + board_height - tip_height)
	print("Posição do quadrado: (", x_tip, ", ", y_tip, ")")
	$Board/tipRects/big2.visible = true
	$Board/tipRects/big2.position = Vector2(x_tip+9, y_tip+11)
	$Board/tipRects/big2/AnimationPlayer.play("tip_big2")

func block_tip_2():
	block_tips_2 += 1
	var tip_rect = $Board/tipRects/big/TextureRect
	var board_x = $Board/Back.position.x
	var board_y = $Board/Back.position.y
	var board_width = $Board/Back.size.x
	var board_height = $Board/Back.size.y
	var cols = 7
	var rows = 6
	var width_cell = board_width / cols
	var height_cell = board_height / rows
	var tip_width = tip_rect.size.x
	var tip_height = tip_rect.size.y
	row_col_correct_block()
	var x_tip = board_x + (correct_block_col - 1) * width_cell
	var y_tip = board_y + (correct_block_row - 1) * height_cell
	if not tip_given:
		randomize()
		r = randi() % 2
	if correct_block_row <= 3:
		if correct_block_row == 3:
			y_tip = y_tip - height_cell
		y_tip = y_tip - height_cell
		if correct_block_col <= 4:
			x_tip = x_tip - r * width_cell
	if correct_block_col <= 4:
		x_tip = x_tip - r * width_cell
	x_tip = clamp(x_tip, board_x, board_x + board_width - tip_width)
	y_tip = clamp(y_tip, board_y, board_y + board_height - tip_height)
	if correct_block_col > 3:
		x_tip += 8
	elif correct_block_col <= 3:
		x_tip += 3
	if correct_block_row >= 4:
		y_tip += 5
	print("Posição do quadrado: (", x_tip, ", ", y_tip, ")")
	$Board/tipRects/big.visible = true
	$Board/tipRects/big.position = Vector2(x_tip, y_tip)
	$Board/tipRects/big/AnimationPlayer.play("tip_big")
	tip_given = true

func block_tip_3():
	block_tips_3 += 1
	var tip_rect = $Board/tipRects/small2/TextureRect
	var board_x = $Board/Back.position.x
	var board_y = $Board/Back.position.y
	var board_width = $Board/Back.size.x
	var board_height = $Board/Back.size.y
	var cols = 7
	var rows = 6
	var width_cell = board_width / cols
	var height_cell = board_height / rows
	var tip_width = tip_rect.size.x
	var tip_height = tip_rect.size.y
	row_col_correct_block()
	var x_tip = board_x + (correct_block_col - 1) * width_cell
	var y_tip = board_y + (correct_block_row - 1) * height_cell
	if not tip_given:
		randomize()
		r = randi() % 2
	y_tip = y_tip - height_cell
	x_tip = x_tip - r * width_cell
	x_tip = clamp(x_tip, board_x, board_x + board_width - tip_width)
	y_tip = clamp(y_tip, board_y, board_y + board_height - tip_height)
	if correct_block_col == 7:
		x_tip += 12
	if correct_block_row == 6:
		y_tip += 6
	print("Posição do quadrado: (", x_tip, ", ", y_tip, ")")
	$Board/tipRects/small2.visible = true
	$Board/tipRects/small2.position = Vector2(x_tip, y_tip+5)
	$Board/tipRects/small2/AnimationPlayer.play("tip_small2")
	tip_given = true

func block_tip_4():
	block_tips_4 += 1
	var tip_rect = $Board/tipRects/small/TextureRect
	var board_x = $Board/Back.position.x
	var board_y = $Board/Back.position.y
	var board_width = $Board/Back.size.x
	var board_height = $Board/Back.size.y
	var cols = 7
	var rows = 6
	var width_cell = board_width / cols
	var height_cell = board_height / rows
	var tip_width = tip_rect.size.x
	var tip_height = tip_rect.size.y
	row_col_correct_block()
	var x_tip = board_x + (correct_block_col - 1) * width_cell
	var y_tip = board_y + (correct_block_row - 1) * height_cell
	x_tip = clamp(x_tip, board_x, board_x + board_width - tip_width)
	y_tip = clamp(y_tip, board_y, board_y + board_height - tip_height)
	if correct_block_col < 3:
		x_tip += 8
	elif correct_block_col == 3:
		x_tip += 6
	elif correct_block_col == 6:
		x_tip += 3
	elif correct_block_col >= 4:
		x_tip += 5
	print("Posição do quadrado: (", x_tip, ", ", y_tip, ")")
	$Board/tipRects/small.visible = true
	$Board/tipRects/small.position = Vector2(x_tip, y_tip-3)
	$Board/tipRects/small/AnimationPlayer.play("tip_small")
	tip_given = true

func row_col_correct_block():
	var k = 0
	for i in range(6):
		for j in range(7):
			if (block_names[k] == correct_block_name):
				correct_block_col = j + 1
				correct_block_row = i + 1
			k += 1

func tool_tip_1():  # dica tool maior
	$Tools/tip1.visible = true
	$Tools/tip1_anim.play("tip1_anim")  
	tool_tips_1 += 1

func tool_tip_2():
	if correct_tool == 1:
		$Tools/tip2.visible = true 
		$Tools/tip2_anim.play("tip2_anim")
	elif correct_tool == 2:
		$Tools/tip2.position.x = orig_position_tool_tip.x + $Tools/tip2.size.x
		$Tools/tip2.visible = true 
		$Tools/tip2_anim.play("tip2_anim")
	elif correct_tool == 3:
		$Tools/tip2.position.x = orig_position_tool_tip.x + $Tools/tip2.size.x*2
		$Tools/tip2.visible = true 
		$Tools/tip2_anim.play("tip2_anim")
	tool_tips_2 += 1

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ToolsMessage":
		$ToolsMessage.visible = false
	if anim_name == "animation":
		randomize()
		all_blocks.shuffle()
		new_array = all_blocks.slice(0, TOTAL)
		for block in new_array:
			block_names.append(block[0])
		init_board()
		correct = change_main_block()
		correct_tool = new_array[correct][1]
	if anim_name == "anim_click":
		$Board/Back/TextureRect.position = original_position_anim
	if anim_name == "tip_big2":
		$Board/tipRects/big2.visible = false
	if anim_name == "tip_big":
		$Board/tipRects/big.visible = false
	if anim_name == "tip_small2":
		$Board/tipRects/small2.visible = false
	if anim_name == "tip_small":
		$Board/tipRects/small.visible = false
	if anim_name == "tip1_anim":
		$Tools/tip1.visible = false
	if anim_name == "tip2_anim":
		$Tools/tip2.visible = false
		$Tools/tip2.position = orig_position_tool_tip


func init_board():
	var k = 0
	for i in range(6):
		for j in range(7):
			var new_texture = load("res://images/Blocks/" + block_names[k])
			var button_path = "Board/Back/VBoxContainer/HBoxContainer"+str(i+1)+"/TextureButton"+str(j+1)
			var button = get_node(button_path)
			if button:
				button.texture_normal = new_texture
			else:
				print("Button not found at path: " + button_path)
			k += 1

# sorteia um número inteiro entre 0 e 41
func number_for_main_block():
	randomize()
	var n = randi() % TOTAL
	while n in picked_blocks:
		n = randi() % TOTAL
	return  n

func change_main_block():
	var n = number_for_main_block()
	picked_blocks.append(n)
	var new_texture = load("res://images/Blocks/" + block_names[n])
	correct_block_name = block_names[n]
	$Image/Back/TextureButton.texture_normal = new_texture
	if picked_blocks.size() == TOTAL:
		last_one = true
	tip_given = false
	return n

func check_tool():
	if (correct_tool == tool) or (correct_tool == 0):
		return true
	else:
		return false

func check_button(n):
	repeated_BE_count_same = 0
	taking_a_long_time_block = 0
	taking_a_long_time_tool = 0
	if tool == null:
		show_tool_message()
		print("Escolha uma ferramenta")
		init_tool_tips += 1
		return false
	else:
		if check_tool():
			consecutive_tool_error_flag = false
			consecutive_tool_errors = 0
			if correct+1 == n:
				correct_block(n)
				if correct_flag:
					consecutive_hits += 1
				correct_flag = true
				return true
			else:
				if not removed.has(n):
					correct_flag = false
					wrong_block(n)
					return false
		else:
			if not removed.has(n):
				correct_flag = false
				wrong_tool()
				return false
	return false

func correct_block(n):
	consecutive_block_error_flag = false
	consecutive_BE = 0
	print("De primeira?: ", first_try)
	if(first_try): 
		on_first_try += 1
		if(right): on_first_try_right += 1
		else: on_first_try_left += 1
		if(bottom): on_first_try_bottom += 1
		else: on_first_try_top += 1
		if(bottom and right):
			on_first_try_Q4 += 1
		elif(bottom and not right):
			on_first_try_Q3 += 1
		elif(not bottom and right):
			on_first_try_Q2 += 1
		elif(not bottom and not right):
			on_first_try_Q1 += 1
	hits += 1
	stop_timer_hit()
	print("Tempo até acerto: ", elapsed_time_hit)
	time_hit_sum += elapsed_time_hit
	removed.append(n)
	if last_one:
		remove_block()
		victory()
	else:
		remove_block()
		new_main_block()
		start_timer_hit()
	print("acerto")
	first_try = true

func wrong_block(n):
	if consecutive_block_error_flag:
		consecutive_block_errors += 1
	consecutive_block_error_flag = true
	if(right): wrong_block_right += 1
	else: wrong_block_left += 1
	if(bottom): wrong_block_bottom += 1
	else: wrong_block_top += 1
	if(bottom and right):
		wrong_block_Q4 += 1
	elif(bottom and not right):
		wrong_block_Q3 += 1
	elif(not bottom and right):
		wrong_block_Q2 += 1
	elif(not bottom and not right):
		wrong_block_Q1 += 1
	if n == previous_n:
		repeated_block_error += 1
		repeated_BE_count_same += 1
		repeat_flag = true
	else: repeat_flag = false
	previous_n = n
	first_try = false
	lives -= 1
	errors += 1
	block_errors += 1
	lives_screen_update()
	if lives == 0:
		game_over()
	else:
		print("erro bloco")
		if repeated_BE_count_same == 1:
			show_error_message(0.7)
			tips += 1
			block_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)
		else: consecutive_BE += 1
		if consecutive_BE == 3 and not repeat_flag:
			block_tip_1()  # dica 1 maior
			tips += 1
			block_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)
		elif consecutive_BE == 4 and not repeat_flag:
			block_tip_1()  # dica 1 maior
			tips += 1
			block_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)
		elif consecutive_BE == 5 and not repeat_flag:
			block_tip_2()  # dica 2
			tips += 1
			block_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)
		elif consecutive_BE == 6 and not repeat_flag:
			block_tip_3()  # dica 3
			tips += 1
			block_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)
		elif consecutive_BE == 7 and not repeat_flag:
			block_tip_4()  # dica 4
			tips += 1
			block_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)
		elif consecutive_BE > 7 and not repeat_flag:
			block_tip_4()  # dica 4
			tips += 1
			block_tips_total += 1
			wrong_with_answer_block += 1
			var time_tip = calculate_elapsed_time()
			time_block_tips_error.append(time_tip)

func wrong_tool():
	if consecutive_tool_error_flag:
		consecutive_tool_errors += 1
	consecutive_tool_error_flag = true
	if tool == previous_tool:
		repeated_tool_error += 1
	previous_tool = tool
	first_try = false
	lives -= 1
	errors += 1
	tool_errors += 1
	lives_screen_update()
	if lives == 0:
		game_over()
	else:
		print("erro ferramenta")
		if consecutive_tool_errors == 1:
			tool_tip_1() 
			tips += 1
			tool_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_tool_tips_error.append(time_tip)
		elif consecutive_tool_errors == 2:
			tool_tip_1() 
			tips += 1
			tool_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_tool_tips_error.append(time_tip)
		elif consecutive_tool_errors == 3:
			tool_tip_2()
			tips += 1
			tool_tips_total += 1
			var time_tip = calculate_elapsed_time()
			time_tool_tips_error.append(time_tip)
		elif consecutive_tool_errors > 3:
			tool_tip_2()
			tips += 1
			tool_tips_total += 1
			wrong_with_answer_tool += 1
			var time_tip = calculate_elapsed_time()
			time_tool_tips_error.append(time_tip)

func remove_block():
	var k = 0
	for i in range(6):
		for j in range(7):
			if k==correct:
				block_names[correct]
				var button_path = "Board/Back/VBoxContainer/HBoxContainer"+str(i+1)+"/TextureButton"+str(j+1)
				var button = get_node(button_path)
				button.texture_normal = null
			k += 1

func new_main_block():
	correct = change_main_block()
	correct_tool = new_array[correct][1]

func lives_screen_update():
	if (Global.saved.infinite_lives):
		$Background/ColorRect/TextureRect/ColorRect2/TextureRect.visible = true
		$Background/ColorRect/TextureRect/ColorRect2/Label.visible = false
		lives = -1
	else:
		var lives_edit = get_node("Background/ColorRect/TextureRect/ColorRect2/Label")
		lives_edit.text = str(lives)

func game_over():
	finished = true
	_on_quit_game()
	$GameOver.visible = true
	print("Game over")

func victory():
	finished = true
	victory_ = true
	_on_quit_game()
	$Victory.visible = true
	$Victory/AnimatedSprite2D.play("victory")
	print("Vitória")

func show_error_message(time):
	$ErrorMessage.visible = true
	await get_tree().create_timer(time).timeout
	$ErrorMessage.visible = false
	$ErrorMessage/ColorRect/TextureRect2.visible = false

func show_tool_message():
	$ToolsMessage.visible = true
	$ToolsMessage/AnimationPlayer.play("ToolsMessage")

func hit_average_time_f():
	var average
	if (hits != 0):
		average = time_hit_sum/hits
		var minutes = int(average / 60)
		var seconds = int(average) % 60
		var milliseconds = int((average - int(average)) * 100)
		average = "%dmin %ds %03dms" % [minutes, seconds, milliseconds]
	else: average = 'Nenhum acerto'
	return average

func _on_quit_game():
	hit_average_time = hit_average_time_f()
	
	var hours = int(total_time / 3600)
	var minutes = int(total_time / 60) % 60
	var seconds = int(total_time) % 60
	var milliseconds = int((total_time - int(total_time)) * 100)
	game_time = "%dh %dmin %ds %03dms" % [hours, minutes, seconds, milliseconds]
	
	percentage = errors / (left_click+right_click) * 100.0
	if typeof(percentage) == TYPE_NIL or percentage != percentage:
		percentage = "Nula"
	else:
		percentage = "%.2f%%" % [percentage]
		
	if (lives == -1 and victory_):
		final_lives = 'Vitória - Vidas infinitas'
	elif (lives == -1 and not victory_):
		final_lives = 'Desistência - Vidas infinitas'
	elif lives == 0:
		final_lives = 'Game-over - Zero vidas'
	elif lives > 0 and victory_:
		final_lives = 'Vitória - Sobraram %d vidas' % [lives] 
	elif (lives > 0 and not victory_):
		final_lives = 'Desistência'
		
	print_screen()
	write_global()
	create_XML()

func write_global():
	Global.saved.formatted_date = str(formatted_date)
	Global.saved.start_formatted_time = str(start_formatted_time)
	Global.saved.game_time = str(game_time)
	Global.saved.final_lives = str(final_lives)
	Global.saved.hits = str(hits)
	Global.saved.errors = str(errors)
	Global.saved.block_errors = str(block_errors)
	Global.saved.tool_errors = str(tool_errors)
	Global.saved.percentage = str(percentage)
	Global.saved.consecutive_block_errors = str(consecutive_block_errors)
	Global.saved.consecutive_tool_errors = str(consecutive_tool_errors)
	Global.saved.repeated_block_error = str(repeated_block_error)
	Global.saved.repeated_tool_error = str(repeated_tool_error)
	Global.saved.consecutive_hits = str(consecutive_hits)
	Global.saved.on_first_try = str(on_first_try)
	Global.saved.hit_average_time = str(hit_average_time)
	Global.saved.random_clicks = str(random_clicks)
	Global.saved.on_first_try_Q1 = str(on_first_try_Q1)
	Global.saved.on_first_try_Q2 = str(on_first_try_Q2)
	Global.saved.on_first_try_Q3 = str(on_first_try_Q3)
	Global.saved.on_first_try_Q4 = str(on_first_try_Q4)
	Global.saved.wrong_block_Q1 = str(wrong_block_Q1)
	Global.saved.wrong_block_Q2 = str(wrong_block_Q2)
	Global.saved.wrong_block_Q3 = str(wrong_block_Q3)
	Global.saved.wrong_block_Q4 = str(wrong_block_Q4)
	Global.save_saved()

func print_screen():
	print("Horário de início do jogo: %s" % start_formatted_time)
	print("Data: %s" % formatted_date)
	print("Duração do jogo: ", game_time)
	print("O jogo foi finalizado: ", finished)
	print("Acertos: ", hits)
	print("Erros: ", errors)
	print("Erros de bloco: ", block_errors)
	print("Erros de ferramenta: ", tool_errors)
	print("Porcentagem total de erro: ", percentage)
	print("Acertos consecutivos: ", consecutive_hits)
	print("Acertos de primeira: ", on_first_try)
	print("Média de tempo até acerto: ", hit_average_time)
	print("Número de vezes de \"cliques demais em um curto intervalo de tempo\": ", random_clicks)
	
	print("Acertos de primeira na direita do tabuleiro: ", on_first_try_right)
	print("Acertos de primeira na esquerda do tabuleiro: ", on_first_try_left)
	print("Acertos de primeira parte inferior do tabuleiro: ", on_first_try_bottom)
	print("Acertos de primeira parte superior do tabuleiro: ", on_first_try_top)
	print("Acertos de primeira no quadrante superior esquerdo do tabuleiro: ", on_first_try_Q1)
	print("Acertos de primeira no quadrante superior direito do tabuleiro: ", on_first_try_Q2)
	print("Acertos de primeira no quadrante inferior esquerdo do tabuleiro: ", on_first_try_Q3)
	print("Acertos de primeira no quadrante inferior direito do tabuleiro: ", on_first_try_Q4)
	
	print("Erros na direita: ", wrong_block_right)
	print("Erros na esquerda: ", wrong_block_left)
	print("Erros na parte inferior: ", wrong_block_bottom)
	print("Erros na parte superior: ", wrong_block_top)
	print("Erros no quadrante superior esquerdo: ", wrong_block_Q1)
	print("Erros no quadrante superior direito: ", wrong_block_Q2)
	print("Erros no quadrante inferior esquerdo: ", wrong_block_Q3)
	print("Erros no quadrante inferior direito: ", wrong_block_Q4)
	
	print("Total de cliques do lado esquerdo do tabuleiro: ", left_click)
	print("Total de cliques do lado direito do tabuleiro: ", right_click)
	print("Total de cliques parte inferior do tabuleiro: ", bottom_click)
	print("Total de cliques parte superior do tabuleiro: ", top_click)
	print("Total de cliques no quadrante superior esquerdo do tabuleiro: ", upper_left_quadrant)
	print("Total de cliques no quadrante superior direito do tabuleiro: ", upper_right_quadrant)
	print("Total de cliques no quadrante inferior esquerdo do tabuleiro: ", lower_left_quadrant)
	print("Total de cliques no quadrante inferior direito do tabuleiro: ", lower_right_quadrant)
	
	print("Erros consecutivos (ferramenta): ", consecutive_tool_errors)
	print("Erros consecutivos (blocos): ", consecutive_block_errors)
	print("Insistiu na ferramenta errada: ", repeated_tool_error)
	print("Insistiu no bloco errado: ", repeated_block_error)
	
	print("Demorou para começar (vezes de 5s): ", took_a_long_time_start)
	print("Demorou para clicar durante o jogo (5s): ", count_taking_a_long_time)
	print("Errou depois de ver última dica (ferramenta): ", wrong_with_answer_tool)
	print("Errou depois de ver última dica (bloco): ", wrong_with_answer_block)
	print("Demorou depois de ver última dica (ferramenta): ", long_time_with_answer_tool)
	print("Demorou depois de ver última dica (bloco): ", long_time_with_answer_block)
	
	print("Total de cliques sem ferramenta (primeira jogada): ", init_tool_tips)
	print("Total de dicas usadas (não conta com \"sem ferramenta\"): ", tips)
	print("Dicas para ferramenta usadas (não conta com \"sem ferramenta\"): ", tool_tips_total)
	print("Primeira dica (ferramenta): ", tool_tips_1)
	print("Segunda e última dica (ferramenta): ", tool_tips_2)
	print("Dicas para blocos usadas: ", block_tips_total)
	print("Primeira dica (bloco): ", block_tips_1)
	print("Segunda dica (bloco): ", block_tips_2)
	print("Terceira dica (bloco): ", block_tips_3)
	print("Quarta e última dica (bloco): ", block_tips_4)
	
	print("Tempo de jogo que as dicas de erro foram usadas (ferramenta): ", time_tool_tips_error)
	print("Tempo de jogo que as dicas de erro foram usadas (bloco): ", time_block_tips_error)
	print("Tempo de jogo que as dicas de demora foram usadas (ferramenta): ", time_tool_tips_long_time)
	print("Tempo de jogo que as dicas de demora foram usadas (bloco): ", time_block_tips_long_time)
	
	print("Número de vidas: ", final_lives)
	

func create_XML():
	#var file_path
	#var file_path2
	#if Global.saved.doc == 0:
		##file_path = "res://data/dados.xml"
		#file_path = "/storage/emulated/0/Documents/BlocoCerto/dados.xml"
		#file_path2 = "/storage/emulated/0/Android/data/com.BlocoCerto.app/dados.xml"
	#else: 
		##file_path = "res://data/dados(%s).xml" % str(Global.saved.doc)
		#file_path = "/storage/emulated/0/Documents/BlocoCerto/dados(%s).xml" % str(Global.saved.doc)
		#file_path2 = "/storage/emulated/0/Android/data/com.BlocoCerto.app/dados(%s).xml" % str(Global.saved.doc)
	
	var dir = DirAccess.open("/")
	var target_dir = "/storage/emulated/0/Documents/BlocoCerto"
	if dir.make_dir_recursive(target_dir) == OK:
		print("Pasta criada em: " + target_dir)
	else:
		print("Houve um erro ao criar a pasta ou ela já existe: " + target_dir)
	
	var file_path
	var content = ""
	if Global.saved.doc == 0:
		file_path = "/storage/emulated/0/Documents/BlocoCerto/dados.xml"
	else: 
		file_path = "/storage/emulated/0/Documents/BlocoCerto/dados(%s).xml" % str(Global.saved.doc)
	
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	if file:
		content = file.get_as_text()
		file.close()
		print("Arquivo encontrado")
		write_XML(content, file_path)
	else:
		file = FileAccess.open(file_path, FileAccess.WRITE)
		if file:
			content = '<?xml version="1.0" encoding="UTF-8"?>\n<dados></dados>'
			file.store_string(content)
			file.close()
			print("Arquivo XML criado com sucesso")
			write_XML(content, file_path)
		else:
			print("Erro ao criar o arquivo XML")
	

func write_XML(content, file_path):
	var new_data = [
		'  <jogo_%s>' % Global.saved.game,
		'    <sessao>',
		'      <data description="Data do jogo">%s</data>' % str(formatted_date),
		'      <hora_de_inicio description="Horário de início do jogo">%s</hora_de_inicio>' % str(start_formatted_time),
		'      <duracao_do_jogo description="Duração do jogo">%s</duracao_do_jogo>' % str(game_time),
		'      <jogo_finalizado description="Estado final">%s</jogo_finalizado>' % str(final_lives),
		'    </sessao>',
		'    <performance>',
		'      <acertos description="Total de acertos">%s</acertos>' % str(hits),
		'      <erros description="Total de erros">%s</erros>' % str(errors),
		'      <erros_de_bloco description="Erros (blocos)">%s</erros_de_bloco>' % str(block_errors),
		'      <erros_de_ferramenta description="Erros (ferramentas)">%s</erros_de_ferramenta>' % str(tool_errors),
		'      <porcentagem_de_erro description="Porcentagem total de erros">%s</porcentagem_de_erro>' % str(percentage),
		'      <erros_consecutivos_bloco description="Erros consecutivos (blocos)">%s</erros_consecutivos_bloco>' % str(consecutive_block_errors),
		'      <erros_consecutivos_ferramenta description="Erros consecutivos (ferramentas)">%s</erros_consecutivos_ferramenta>' % str(consecutive_tool_errors),
		'      <insistiu_erro_bloco description="Vezes que insistiu no bloco errado">%s</insistiu_erro_bloco>' % str(repeated_block_error),
		'      <insistiu_erro_ferramenta description="Vezes que insistiu na ferramenta errada">%s</insistiu_erro_ferramenta>' % str(repeated_tool_error),
		'      <acertos_consecutivos description="Acertos consecutivos">%s</acertos_consecutivos>' % str(consecutive_hits),
		'      <de_primeira description="Acertos de primeira">%s</de_primeira>' % str(on_first_try),
		'      <tempo_medio_acerto description="Média de tempo até acerto">%s</tempo_medio_acerto>' % str(hit_average_time),
		'      <cliques_aleatorios description="Número de vezes em que houve cliques excessivos em um curto intervalo de tempo (3 cliques em 0.5s)">%s</cliques_aleatorios>' % str(random_clicks),
		'    </performance>',
		'    <acertos_de_primeira_localizacoes>',
		'      <de_primeira_direita description="Acertos de primeira na direita do tabuleiro">%s</de_primeira_direita>' % str(on_first_try_right),
		'      <de_primeira_esquerda description="Acertos de primeira na esquerda do tabuleiro">%s</de_primeira_esquerda>' % str(on_first_try_left),
		'      <de_primeira_baixo description="Acertos de primeira na parte inferior do tabuleiro">%s</de_primeira_baixo>' % str(on_first_try_bottom),
		'      <de_primeira_cima description="Acertos de primeira na parte superior do tabuleiro">%s</de_primeira_cima>' % str(on_first_try_top),
		'      <de_primeira_Q1 description="Acertos de primeira no quadrante superior esquerdo do tabuleiro">%s</de_primeira_Q1>' % str(on_first_try_Q1),
		'      <de_primeira_Q2 description="Acertos de primeira no quadrante superior direito do tabuleiro">%s</de_primeira_Q2>' % str(on_first_try_Q2),
		'      <de_primeira_Q3 description="Acertos de primeira no quadrante inferior esquerdo do tabuleiro">%s</de_primeira_Q3>' % str(on_first_try_Q3),
		'      <de_primeira_Q4 description="Acertos de primeira no quadrante inferior direito do tabuleiro">%s</de_primeira_Q4>' % str(on_first_try_Q4),
		'    </acertos_de_primeira_localizacoes>',
		'    <erros_localizacoes>',
		'      <bloco_errado_direita description="Erros na direita">%s</bloco_errado_direita>' % str(wrong_block_right),
		'      <bloco_errado_esquerda description="Erros na esquerda">%s</bloco_errado_esquerda>' % str(wrong_block_left),
		'      <bloco_errado_baixo description="Erros na parte inferior">%s</bloco_errado_baixo>' % str(wrong_block_bottom),
		'      <bloco_errado_cima description="Erros na parte superior">%s</bloco_errado_cima>' % str(wrong_block_top),
		'      <bloco_errado_Q1 description="Erros no quadrante superior esquerdo">%s</bloco_errado_Q1>' % str(wrong_block_Q1),
		'      <bloco_errado_Q2 description="Erros no quadrante superior direito">%s</bloco_errado_Q2>' % str(wrong_block_Q2),
		'      <bloco_errado_Q3 description="Erros no quadrante inferior esquerdo">%s</bloco_errado_Q3>' % str(wrong_block_Q3),
		'      <bloco_errado_Q4 description="Erros no quadrante inferior direito">%s</bloco_errado_Q4>' % str(wrong_block_Q4),
		'    </erros_localizacoes>',
		'    <total_cliques_localizacoes>',
		'      <clique_esquerda description="Total de cliques no lado esquerdo do tabuleiro">%s</clique_esquerda>' % str(left_click),
		'      <clique_direita description="Total de cliques no lado direito do tabuleiro">%s</clique_direita>' % str(right_click),
		'      <clique_baixo description="Total de cliques na parte inferior do tabuleiro">%s</clique_baixo>' % str(bottom_click),
		'      <clique_cima description="Total de cliques na parte superior do tabuleiro">%s</clique_cima>' % str(top_click),
		'      <quadrante_superior_esquerdo description="Total de cliques no quadrante superior esquerdo do tabuleiro">%s</quadrante_superior_esquerdo>' % str(upper_left_quadrant),
		'      <quadrante_superior_direito description="Total de cliques no quadrante superior direito do tabuleiro">%s</quadrante_superior_direito>' % str(upper_right_quadrant),
		'      <quadrante_inferior_esquerdo description="Total de cliques no quadrante inferior esquerdo do tabuleiro">%s</quadrante_inferior_esquerdo>' % str(lower_left_quadrant),
		'      <quadrante_inferior_direito description="Total de cliques no quadrante inferior direito do tabuleiro">%s</quadrante_inferior_direito>' % str(lower_right_quadrant),
		'    </total_cliques_localizacoes>',
		'    <demora_cliques>',
		'      <demorou_para_começar description="Demorou para começar (vezes de 5s)">%s</demorou_para_começar>' % str(took_a_long_time_start),
		'      <demorou_para_clicar description="Demorou para clicar durante o jogo (5s)">%s</demorou_para_clicar>' % str(count_taking_a_long_time),
		'    </demora_cliques>',
		'    <dicas_total>',
		'      <dica_sem_ferramenta description="Total de cliques sem ferramenta (primeira jogada)">%s</dica_sem_ferramenta>' % str(init_tool_tips),
		'      <dicas description="Total de dicas usadas (não conta com cliques sem ferramenta)">%s</dicas>' % str(tips),
		'      <dicas_de_bloco description="Dicas para blocos usadas">%s</dicas_de_bloco>' % str(block_tips_total),
		'      <dicas_de_ferramenta description="Dicas para ferramenta usadas (não conta com dicas de aviso sem ferramenta)">%s</dicas_de_ferramenta>' % str(tool_tips_total),
		'    </dicas_total>',
		'    <dicas_detalhes>',
		'      <dica_de_bloco_1 description="Vezes que usou a Primeira dica de bloco">%s</dica_de_bloco_1>' % str(block_tips_1),
		'      <dica_de_bloco_2 description="Vezes que usou a Segunda dica de bloco">%s</dica_de_bloco_2>' % str(block_tips_2),
		'      <dica_de_bloco_3 description="Vezes que usou a Terceira dica de bloco">%s</dica_de_bloco_3>' % str(block_tips_3),
		'      <dica_de_bloco_4 description="Vezes que usou a Última dica de bloco">%s</dica_de_bloco_4>' % str(block_tips_4),
		'      <dica_ferramenta_1 description="Vezes que usou a Primeira dica de ferramenta">%s</dica_ferramenta_1>' % str(tool_tips_1),
		'      <dica_ferramenta_2 description="Vezes que usou a Última dica de ferramenta">%s</dica_ferramenta_2>' % str(tool_tips_2),
		'      <errou_com_dica_bloco_4 description="Vezes que errou depois de ver a última dica (bloco)">%s</errou_com_dica_bloco_4>' % str(wrong_with_answer_block),
		'      <errou_com_dica_ferramenta_2 description="Vezes que errou depois de ver a última dica (ferramenta)">%s</errou_com_dica_ferramenta_2>' % str(wrong_with_answer_tool),
		'      <demorou_com_dica_bloco_4 description="Vezes que demorou depois de ver a última dica (bloco)">%s</demorou_com_dica_bloco_4>' % str(long_time_with_answer_block),
		'      <demorou_com_dica_ferramenta_2 description="Vezes que demorou depois de ver a última dica (ferramenta)">%s</demorou_com_dica_ferramenta_2>' % str(long_time_with_answer_tool),
		'      <tempo_jogo_dicas_erro_bloco description="Tempo de jogo que as dicas de erro foram usadas (bloco)">%s</tempo_jogo_dicas_erro_bloco>' % str(time_block_tips_error),
		'      <tempo_jogo_dicas_erro_fer description="Tempo de jogo que as dicas de erro foram usadas (ferramenta)">%s</tempo_jogo_dicas_erro_fer>' % str(time_tool_tips_error),
		'      <tempo_jogo_dicas_demora_bloco description="Tempo de jogo que as dicas de demora foram usadas (bloco)">%s</tempo_jogo_dicas_demora_bloco>' % str(time_block_tips_long_time),
		'      <tempo_jogo_dicas_demora_fer description="Tempo de jogo que as dicas de demora foram usadas (ferramenta)">%s</tempo_jogo_dicas_demora_fer>' % str(time_tool_tips_long_time),
		'    </dicas_detalhes>',
		'  </jogo_%s>' % Global.saved.game
	]
	var start_index = content.find("</dados>")
	if start_index == -1:
		print("Erro: tag de fechamento </dados> não encontrada")
		return
	
	var updated_content = content.substr(0, start_index) + "\n"
	for line in new_data:
		updated_content += line + "\n"
	updated_content += "</dados>"
	
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string(updated_content)
		file.close()
		print("XML atualizado com sucesso")
	else:
		print("Erro ao abrir o arquivo para escrita")
	


# Pausa ================================================================================
var pause_scene = preload("res://PauseScene.tscn")
var pause_instance = null

# alterna o estado de pausa
func _toggle_pause():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		pause_instance = pause_scene.instantiate()
		add_child(pause_instance)
		pause_instance.connect("quit_game", Callable(self, "_on_quit_game"))
	else:
		if pause_instance:
			remove_child(pause_instance)
			pause_instance.queue_free()
			pause_instance = null

func _on_pause_button_pressed():
	_toggle_pause()

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		if get_tree().paused:
			_toggle_pause()
		else:
			get_tree().change_scene_to_file("res://StartScene.tscn")

# Fim de jogo e Vitória ===============================================================
func _on_start_pressed():
	get_tree().change_scene_to_file("res://GameScene.tscn")

func _on_statistics_pressed():
	get_tree().change_scene_to_file("res://StatisticsScene.tscn")

func _on_home_pressed():
	get_tree().change_scene_to_file("res://StartScene.tscn")

# =====================================================================================
# Botões ==============================================================================
func _on_tool_1_pressed():
	tool = 1
	$Tools/ColorRect.visible = true
	$Tools/ColorRect2.visible = false
	$Tools/ColorRect3.visible = false

func _on_tool_2_pressed():
	tool = 2
	$Tools/ColorRect.visible = false
	$Tools/ColorRect2.visible = true
	$Tools/ColorRect3.visible = false

func _on_tool_3_pressed():
	tool = 3
	$Tools/ColorRect.visible = false
	$Tools/ColorRect2.visible = false
	$Tools/ColorRect3.visible = true

var check

func _on_texture_button_1_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 1)
	check = check_button(1)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_2_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 2)
	check = check_button(2)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_3_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 3)
	check = check_button(3)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_4_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 4)
	check = check_button(4)
	if check:
		hit_anim(mouse_position)
	
func _on_texture_button_5_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 5)
	check = check_button(5)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_6_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 6)
	check = check_button(6)
	if check:
		hit_anim(mouse_position)
	
func _on_texture_button_7_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 7)
	check = check_button(7)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_8_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 8)
	check = check_button(8)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_9_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 9)
	check = check_button(9)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_10_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 10)
	check = check_button(10)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_11_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 11)
	check = check_button(11)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_12_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 12)
	check = check_button(12)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_13_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 13)
	check = check_button(13)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_14_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 14)
	check = check_button(14)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_15_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 15)
	check = check_button(15)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_16_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 16)
	check = check_button(16)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_17_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 17)
	check = check_button(17)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_18_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 18)
	check = check_button(18)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_19_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 19)
	check = check_button(19)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_20_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 20)
	check = check_button(20)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_21_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 21)
	check = check_button(21)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_22_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 22)
	check = check_button(22)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_23_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 23)
	check = check_button(23)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_24_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 24)
	check = check_button(24)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_25_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 25)
	check = check_button(25)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_26_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 26)
	check = check_button(26)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_27_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 27)
	check = check_button(27)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_28_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 28)
	check = check_button(28)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_29_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 29)
	check = check_button(29)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_30_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 30)
	check = check_button(30)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_31_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 31)
	check = check_button(31)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_32_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 32)
	check = check_button(32)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_33_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 33)
	check = check_button(33)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_34_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 34)
	check = check_button(34)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_35_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 35)
	check = check_button(35)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_36_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 36)
	check = check_button(36)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_37_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 37)
	check = check_button(37)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_38_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 38)
	check = check_button(38)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_39_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 39)
	check = check_button(39)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_40_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 40)
	check = check_button(40)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_41_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 41)
	check = check_button(41)
	if check:
		hit_anim(mouse_position)

func _on_texture_button_42_pressed():
	var mouse_position = get_viewport().get_mouse_position()
	block_clicked(mouse_position, 42)
	check = check_button(42)
	if check:
		hit_anim(mouse_position)

func block_clicked(mouse_position, clicked):
	var color_rect_global_position = $Board/Back.global_position
	var color_rect_size = $Board/Back.size
	if Rect2(color_rect_global_position, color_rect_size).has_point(mouse_position) and tool != null and not removed.has(clicked):
		$Board/Back/TextureRect.position = mouse_position - $Board/Back.position - Vector2(42, 42)
		$Board/Back/AnimationPClick.play("anim_click")
		
func _on_hit_anim_frame_changed():
	var current_animation = $Board/Back/HitAnim.animation
	var current_frame = $Board/Back/HitAnim.frame
	var total_frames = 21
	if current_frame == total_frames - 1:
		$Board/Back/HitAnim.stop()
		$Board/Back/HitAnim.position = original_position_anim

func hit_anim(mouse_position):
	$Board/Back/HitAnim.position = mouse_position - $Board/Back.position - Vector2(0, 0)
	$Board/Back/HitAnim.play("fireworks")

