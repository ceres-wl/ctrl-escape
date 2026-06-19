extends Node2D
class_name item

# TODO: Terminar a parte para permitir instancias generalizadas
@export var id = ""
@export var item_name = ""
@export var is_interactable = true
@export var item_texture : Texture2D

enum type_item {COLLECTIBLE, CONTAINER, ZOOM, TERMINAL}
var type_atual

func _ready():
	$Button.icon = item_texture

func interact():
	if type_atual == type_item.COLLECTIBLE:
		collect()
	elif type_atual == type_item.CONTAINER:
		open()
	elif type_atual == type_item.ZOOM:
		open_zoom()
	elif type_atual == type_item.TERMINAL:
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


func _on_button_pressed() -> void:
	interact()
