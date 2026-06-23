extends item
class_name item_coletavel
var coletado = false

func _ready():
	type_atual = type_item.COLLECTIBLE

func collect() -> void:
	if(Inventory.add_item(self)):
		self.visible = false
		coletado = true
