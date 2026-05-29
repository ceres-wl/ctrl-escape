extends Node

var current_room : Node = null

# TODO: mudar o mouse em cima dos botaos
func _ready() -> void:
	
	$right_arrow.pressed.connect(_on_right_arrow_pressed)
	$left_arrow.pressed.connect(_on_left_arrow_pressed)
	var sala_1_tscn = preload("res://Navegaçao/Rooms/room_1/Room_1.tscn")
	var instancia_sala = sala_1_tscn.instantiate()
	add_child(instancia_sala) 
	current_room = instancia_sala
	
func _on_right_arrow_pressed():
	if current_room != null:
		current_room.mudar_parede(1)
	else:
		print("Erro: Nenhuma sala atual definida!")

func _on_left_arrow_pressed():
	if current_room != null:
		current_room.mudar_parede(-1)
	else:
		print("Erro: Nenhuma sala atual definida!")
