extends item
class_name item_coletavel
var coletado = false

func _ready():
	type_atual = type_item.COLLECTIBLE

func collect() -> void:
	if(Inventory.add_item(self)):
		visible = false
		coletado = true

func save():
	var dict = super.save();
	dict.set("collected", coletado);
	dict.set("visible", visible);
	return dict;

func load_self(data: Dictionary):
	if data.get("collected"):
		collect();
	
