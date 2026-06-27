extends Control

var need_arrow = false
@onready var porta = $Door
var porta_trancada = true

func _ready() -> void:
	porta_trancada = true
	add_to_group("sala_tutorial")
	$Letter.interact()
	if porta.is_connected("pressed", _on_porta_pressed):
		porta.disconnect("pressed", _on_porta_pressed)
	porta.pressed.connect(_on_porta_pressed)
	
func abrir_porta():
	porta_trancada = false
	porta.texture_normal = load("res://Arts/porta_aberta.png")
	
func _on_porta_pressed():
	if(porta_trancada == false):
		Inventory.remove_item($Letter)
		NavigationManager.start_game()
		PersistanceManager.load_game()
		queue_free()
