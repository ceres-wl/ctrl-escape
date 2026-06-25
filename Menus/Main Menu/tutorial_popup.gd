extends CanvasLayer

signal tutorial_closed

func _ready():
	visible = false

func _on_continuar_pressed():
	visible = false
	tutorial_closed.emit()
