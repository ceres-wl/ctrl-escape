extends Control

@onready var parede_cont = $Paredes
var paredes = []
var idx_atual = 0

func _ready() -> void:
	paredes = parede_cont.get_children()
	paredes[idx_atual].visible = true
	
# +1 para direita, -1 para esquerdd
func mudar_parede(desloc: int):
	paredes[idx_atual].visible = false
	idx_atual = (idx_atual + desloc + 4) % 4
	paredes[idx_atual].visible = true
