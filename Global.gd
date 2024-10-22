extends Node

var saved = SettingsData
const SAVE_PATH = "user://resource.tres"

var music_player: AudioStreamPlayer
var tween: Tween

func _ready():
	load_saved()
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	var music_stream = preload("res://SubwooferLullaby.mp3")
	if music_stream is AudioStream:
		music_stream.loop = false
	music_player.stream = music_stream
	music_player.volume_db = -40
	tween = create_tween()
	music_player.connect("finished", Callable(self, "_on_music_finished"))
	if Global.saved.music_check:
		music_player.play()
		music_player.seek(32.0)
		tween.tween_property(music_player, "volume_db", 0, 0.6).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		music_player.process_mode = PROCESS_MODE_ALWAYS

func _on_music_finished():
	music_player.play()

func save_saved():
	ResourceSaver.save(saved, SAVE_PATH)

func load_saved():
	if ResourceLoader.exists(SAVE_PATH):
		saved = ResourceLoader.load(SAVE_PATH).duplicate(true)
	else:
		saved = SettingsData.new()
