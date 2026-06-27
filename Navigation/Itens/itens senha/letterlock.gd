extends Node

@export var senha_correta = "0 0 0 0"
@export var id_senha = ""

var senha_atual = "A A A A"
var concluido = false

func _ready() -> void:
	$senha_atual.text = senha_atual
	ProgressionManager.set_senha(id_senha)
