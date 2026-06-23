extends Node2D
class_name item

# TODO: Terminar a parte para permitir instancias generalizadas
@export var id = ""
@export var item_name = ""
@export var is_interactable = true
@export var item_texture : Texture2D
var type_atual

enum type_item {COLLECTIBLE, CONTAINER, ZOOM}


func _ready():
	$Button.icon = item_texture

func interact():
	if type_atual == type_item.COLLECTIBLE:
		collect()
	elif type_atual == type_item.CONTAINER:
		change_container()
	elif type_atual == type_item.ZOOM:
		open_zoom()
	
func collect() -> void:
	pass
func change_container() -> void:
	pass
func open_zoom() -> void:
	pass


func _on_button_pressed() -> void:
	interact()
