extends CanvasLayer

signal tutorial_closed

func _ready():
	visible = false

func _on_continuar_pressed():
	$ComoJogar.visible = false
	$ComoJogar2.visible = true

func _on_continuar_2_pressed() -> void:
	visible = false
	tutorial_closed.emit()
