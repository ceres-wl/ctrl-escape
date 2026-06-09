extends Node

# TODO: Terminar a parte para permitir instancias generalizadas
@export var id = ""
@export var item_name = ""
@export var is_interactable = false
enum type_item {COLLECTIBLE, CONTAINER, ZOOM}
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

func change_frame(idx: int):
	$Sprite.frame = idx
	
# vao ser implementado pelas classes filhas
func collect() -> void:
	pass
func open() -> void:
	pass
func open_zoom() -> void:
	pass
