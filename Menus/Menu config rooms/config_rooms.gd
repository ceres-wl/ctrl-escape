extends Node

var config = ConfigFile.new()

@onready var janela_historico = $CanvasLayer/Menu_Config/JanelaHistorico
@onready var texto_historico = $CanvasLayer/Menu_Config/JanelaHistorico/ScrollContainer/TextoHistorico

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
	PersistanceManager.save_game();
	NavigationManager.end_game();
	
func _on_button_historico_pressed() -> void:
	texto_historico.text = ""
	var lista_falas = DialogueManager.historico
	var texto_final = ""
	if(lista_falas.size() == 0):
		texto_final = "Nenhuma fala foi dita ainda!"
	else:
		for frase in lista_falas:
			texto_final += frase + "\n__________________________________________________________________________\n"
	
	texto_historico.text = texto_final
	#$CanvasLayer.visible = false
	janela_historico.visible = true
	
func _on_x_historico_pressed() -> void:
	janela_historico.visible = false
	#$CanvasLayer.visible = true
