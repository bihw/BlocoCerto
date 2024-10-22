extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.request_permission("android.permission.WRITE_EXTERNAL_STORAGE")
	pass

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit()
