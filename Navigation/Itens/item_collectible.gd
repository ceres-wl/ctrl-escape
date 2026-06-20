extends item
class_name item_coletavel

func _ready():
	super()
	type_atual = type_item.COLLECTIBLE

func collect() -> void:
	if(Inventory.add_item(self)):
		queue_free()
