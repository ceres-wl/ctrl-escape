extends Node
class_name item

# TODO: Terminar a parte para permitir instancias generalizadas
@export var id = ""
@export var item_name = ""
@export var is_interactable = false
enum type_item {COLLECTIBLE, CONTAINER, ZOOM, TERMINAL}
var type_atual

# TODO: Terminar a parte do input_event
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	pass
	
func interact() -> void:
	if type_atual == type_item.COLLECTIBLE:
		collect()
	elif type_atual == type_item.CONTAINER:
		open()
	elif type_atual == type_item.ZOOM:
		open_zoom()
	elif type_atual == type_atual.TERMINAL:
		open_terminal()

func change_frame(idx: int):
	$Sprite.frame = idx
	
func open_terminal() -> void:
	pass
func collect() -> void:
	pass
func open() -> void:
	pass
func open_zoom() -> void:
	pass
