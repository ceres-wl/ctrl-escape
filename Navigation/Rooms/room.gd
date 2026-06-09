extends Node

@onready var wall_content = $Walls
var walls  = []
var idx_atual = 0

func _ready() -> void:
	walls = wall_content.get_children()
	for i in range(4):
		walls[i].visible = false
	walls[idx_atual].visible = true
	
# +1 para direita, -1 para esquerdd
func mudar_parede(desloc: int):
	walls[idx_atual].visible = false
	idx_atual = (idx_atual + desloc + 4) % 4
	walls[idx_atual].visible = true
