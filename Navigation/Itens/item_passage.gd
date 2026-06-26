extends item
class_name item_passage

@export var destiny_room : PackedScene

func _ready() -> void:
	type_atual = type_item.PASSAGE

# adicionar algum efeito de transiçao? 
func change_room() -> void:
	NavigationManager.change_room(destiny_room)
