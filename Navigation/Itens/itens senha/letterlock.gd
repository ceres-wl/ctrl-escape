extends Node

@export var senha_correta = "B B B B"
@export var id_senha = ""

var senha_atual = "A A A A"
var concluido = false

func _ready() -> void:
	$Senha_atual.text = senha_atual
	ProgressionManager.set_senha(id_senha)

func check():
	if senha_atual == senha_correta:
		$Senha_atual.modulate = Color.GREEN
		concluido = true
		ProgressionManager.change_senha(id_senha)
		
func change(idx : int):
	if !concluido:
		if senha_atual[idx] == 'Z':
			senha_atual[idx] = 'A' 
		else:
			senha_atual[idx] = char(1 + ord(senha_atual[idx]))
	$Senha_atual.text = senha_atual
	check()
	
func _on_first_pressed() -> void:
	change(0)
func _on_second_pressed() -> void:
	change(2)
func _on_third_pressed() -> void:
	change(4)
func _on_forth_pressed() -> void:
	change(6)
	
