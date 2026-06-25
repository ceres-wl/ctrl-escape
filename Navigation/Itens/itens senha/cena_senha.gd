extends Node

var concluido = false

func _ready() -> void:
	var gerenciador = get_tree().get_first_node_in_group("gerenciador_senhas")
	if gerenciador:
		if not gerenciador.senha_concluida.is_connected(finish_senha):
			gerenciador.senha_concluida.connect(finish_senha)
	
func finish_senha():
	concluido = true
