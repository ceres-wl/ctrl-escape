extends Node

var current_room : Node = null
var scene

func _ready() -> void:
	$right_arrow.pressed.connect(_on_right_arrow_pressed)
	$left_arrow.pressed.connect(_on_left_arrow_pressed)
	hide_arrows()
	
func start_game() -> void:
	var sala_1_tscn = preload("res://Navigation/Rooms/room_1/Room_1.tscn")
	var instancia_sala = sala_1_tscn.instantiate()
	
	add_child(instancia_sala) 
	current_room = instancia_sala
	# temporario, depende da sala que vai ser chamada
	show_arrows()
	
func show_arrows() -> void:
	$right_arrow.visible = true
	$left_arrow.visible = true
	
func hide_arrows() -> void:
	$right_arrow.visible = false
	$left_arrow.visible = false
	
func show_back_zoom() -> void:
	$CanvasLayer.visible = true
	
func hide_back_zoom() -> void:
	$CanvasLayer.visible = false
	
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

func _on_back_zoom_pressed() -> void:
	finish_zoom()

func finish_zoom():
	show_arrows()
	hide_back_zoom()
	if scene != null:
		scene.queue_free()
		scene = null

func start_zoom(cena_zoom:PackedScene):
	hide_arrows()
	show_back_zoom()
	scene = cena_zoom.instantiate()
	add_child(scene)
	
