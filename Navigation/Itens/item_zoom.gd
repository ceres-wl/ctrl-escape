extends item
class_name item_zoom

@export var cena_zoom : PackedScene

func _ready() -> void:
	type_atual = type_item.ZOOM

func open_zoom() -> void:
	NavegationManager.start_zoom(cena_zoom)
