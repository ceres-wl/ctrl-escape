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
			
			# FIXME Essas linhas não tavam fazendo nada eu acho, alguém confirma depois
			#var zoom = NavigationManager.zooms[$"../Mesa".cena_zoom.resource_path]
			#zoom.get_node("Cabo_plugado").visible = true
			
			$"../Cabo_plugado".visible = true
			
			Inventory.remove_item(item_selecionado)
			ProgressionManager.submit_object_action("computador_sala01", "ligado")

func save():
	return {
		"path": get_path(),
		"ligado": ligado,
		"pendrive": pendrive
	}

func load_self(data: Dictionary):
	ligado = data.get("ligado");
	if ligado:
		$"../Cabo_plugado".visible = true
	pendrive = data.get("pendrive");
	pass
