extends item

#TODO: Verificar se ele pode ser utilizado ou nao (se esta ligado)
func _ready():
	super()
	type_atual = type_item.TERMINAL
	
func open_terminal() -> void:
	NavegationManager.start_terminal()
