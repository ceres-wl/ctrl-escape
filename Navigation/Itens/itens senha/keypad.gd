extends Node

#TODO: metodo para avisar que deu certo ou deu errado a senha
@export var senha_correta = "0 0 0 0"
@export var id_senha = ""

var senha_atual = "_ _ _ _"
var idx_atual = 0
var concluido = false

# pode ser alterado para nao usar mais o progression manager

func _ready() -> void:
	$senha_atual.text = senha_atual
	ProgressionManager.set_senha(id_senha)
	
func _on_key_submit_pressed() -> void:
	if(idx_atual == 4 && !concluido):
		if senha_atual == senha_correta:
			$senha_atual.modulate = Color.GREEN
			concluido = true
			ProgressionManager.change_senha(id_senha)
		else:
			$senha_atual.modulate = Color.RED
			await get_tree().create_timer(1.0).timeout
			$senha_atual.modulate = Color.WHITE

func add_key(letra):
	if(idx_atual < 4 && !concluido):
		senha_atual[2 * idx_atual] = letra
		idx_atual = idx_atual + 1;
		$senha_atual.text = senha_atual
		
func _on_key_del_pressed() -> void:
	if(idx_atual > 0 && !concluido):
		idx_atual = idx_atual - 1
		senha_atual[2 * idx_atual] = '_'
		$senha_atual.text = senha_atual
	

func _on_key_1_pressed() -> void:
	add_key('1')
func _on_key_2_pressed() -> void:
	add_key('2')
func _on_key_3_pressed() -> void:
	add_key('3')
func _on_key_4_pressed() -> void:
	add_key('4')
func _on_key_5_pressed() -> void:
	add_key('5')
func _on_key_6_pressed() -> void:
	add_key('6')
func _on_key_7_pressed() -> void:
	add_key('7')
func _on_key_8_pressed() -> void:
	add_key('8')
func _on_key_9_pressed() -> void:
	add_key('9')
func _on_key_0_pressed() -> void:
	add_key('0')
