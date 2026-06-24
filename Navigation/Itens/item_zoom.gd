extends item
class_name item_zoom

@export var cena_zoom : PackedScene

func _ready() -> void:
	NavigationManager.setup_zoom(cena_zoom)
	type_atual = type_item.ZOOM

func open_zoom() -> void:
	NavigationManager.start_zoom(cena_zoom)
