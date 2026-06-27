extends item_zoom

var ligado = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


func _on_pressed() -> void:
	if ligado:
		super.open_zoom()
	else:
		var item_selecionado = Inventory.hotbar[Inventory.selected_slot]
		if item_selecionado and item_selecionado.item_name == "Cabo":
			ligado = true
			Inventory.remove_item(item_selecionado)
			ProgressionManager.submit_object_action("computador_sala01", "ligado")
