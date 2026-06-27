extends CanvasLayer

@onready var painel = $Background
@onready var texto_label = $Background/Text
@onready var botao_avancar = $Background/NextButton

func _ready() -> void:
	visible = false
	DialogueManager.show_text.connect(_exibir_texto)
	DialogueManager.close_dialogue.connect(_esconder_balao)
	
func _exibir_texto(texto: String):
	visible = true
	texto_label.text = texto

func _esconder_balao():
	visible = false

func _on_next_button_pressed():
	DialogueManager.next_sentence()
