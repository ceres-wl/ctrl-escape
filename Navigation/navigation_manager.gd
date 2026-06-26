extends Node

var current_room : Node = null
var zoom_stack : Array[Node] = []
var zooms = {}

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

func start_tutorial() -> void:
	var tutorial_tscn = preload("res://Tutorial/TutorialRoom.tscn")
	var instancia_sala = tutorial_tscn.instantiate()
	add_child(instancia_sala) 
	current_room = instancia_sala

func change_room(new_room: PackedScene):
	hide_arrows()
	remove_child(current_room)
	var instancia_sala = new_room.instantiate()
	
	add_child(instancia_sala)
	current_room = instancia_sala
	if current_room.need_arrow:
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
	if zoom_stack.is_empty():
		return
	var ultimo_zoom = zoom_stack.pop_back()
	ultimo_zoom.visible = false
	if not zoom_stack.is_empty():
		zoom_stack.back().visible = true
	else:
		show_arrows()
		hide_back_zoom()

func finish_zoom_tutorial():
	if zoom_stack.is_empty():
		return
	var ultimo_zoom = zoom_stack.pop_back()
	ultimo_zoom.visible = false
	if not zoom_stack.is_empty():
		zoom_stack.back().visible = true
	else:
		hide_back_zoom()

func setup_zoom(cena_zoom: PackedScene):
	var path = cena_zoom.resource_path
	if !zooms.has(path):
		var instancia = cena_zoom.instantiate()
		instancia.visible = false
		add_child(instancia)
		zooms[path] = instancia

# Recebe o nó já instânciado, retorna a referencia
func start_zoom(cena_zoom: PackedScene):
	var cena = zooms[cena_zoom.resource_path]
	if zoom_stack.size() > 0:
		zoom_stack.back().visible = false
	cena.visible = true
	zoom_stack.append(cena)
	hide_arrows()
	show_back_zoom()
	return cena
