extends Node

var config = ConfigFile.new()

func _ready() -> void:
	$"CanvasLayer/Menu_Config/Slider musica".value = MusicManager.obter_volume_salvo()

func _on_button_config_pressed() -> void:
	$CanvasLayer.visible = true

func _on_x_pressed() -> void:
	$CanvasLayer.visible = false

func _on_slider_musica_value_changed(value: float) -> void:
	MusicManager.atualizar_volume(value)

func _on_slider_som_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Som")
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_salvar_e_sair_pressed() -> void:
	pass # Replace with function body.
