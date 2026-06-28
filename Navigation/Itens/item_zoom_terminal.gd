extends item_zoom

var ligado = false
var pendrive = 0
#TODO: terminar as mudanças do pendrive

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

func _on_pressed() -> void:
	var item_selecionado = Inventory.hotbar[Inventory.selected_slot]
	if ligado:
		if item_selecionado:
			if item_selecionado.item_name == "pendrive_1":
				pendrive = 1
			if pendrive == 1 and item_selecionado.item_name == "pendrive_2":
				pendrive = 2
		else:
			super.open_zoom()
	else:
		if item_selecionado and item_selecionado.item_name == "Cabo":
			ligado = true
			Inventory.remove_item(item_selecionado)
			ProgressionManager.submit_object_action("computador_sala01", "ligado")
