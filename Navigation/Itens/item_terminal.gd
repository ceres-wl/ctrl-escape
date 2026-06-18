extends item

signal open_t

func _init():
	type_atual = type_item.TERMINAL
	
func open_terminal() -> void:
	open_t.emit()
