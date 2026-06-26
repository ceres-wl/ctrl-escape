extends item_container

# conferir se e o mesmo da tranca
@export var id_senha = ""

func change_container():
	if open:
		super()
	else:
		if ProgressionManager.get_status_senha(id_senha):
			super()
		else:
			alertar_tranca()
	
	
# TODO: mecanismo para alertar que esta trancado
func alertar_tranca():
	pass
