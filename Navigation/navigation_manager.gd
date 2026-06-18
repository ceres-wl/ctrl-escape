extends Node

var current_room : Node = null
var terminais

func _ready() -> void:
	$right_arrow.pressed.connect(_on_right_arrow_pressed)
	$left_arrow.pressed.connect(_on_left_arrow_pressed)
	hide_arrows()
	
	# temporario, devem chamar de acordo com a necessidade
	show_arrows()
	start_game()
	
func start_game() -> void:
	var sala_1_tscn = preload("res://Navigation/Rooms/room_1/Room_1.tscn")
	var instancia_sala = sala_1_tscn.instantiate()
	
	add_child(instancia_sala) 
	current_room = instancia_sala
	terminais = get_tree().get_nodes_in_group("")
	
func show_arrows() -> void:
	$right_arrow.visible = true
	$left_arrow.visible = true
	
func hide_arrows() -> void:
	$right_arrow.visible = false
	$left_arrow.visible = false
	
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
