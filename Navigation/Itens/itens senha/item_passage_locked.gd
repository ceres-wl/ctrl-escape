extends item_passage

@export var id_senha = ""

func change_room() -> void:
		if ProgressionManager.get_status_senha(id_senha):
			super()
		else:
			alertar_tranca()
	
# TODO: mecanismo para alertar que esta trancado
func alertar_tranca():
	pass
