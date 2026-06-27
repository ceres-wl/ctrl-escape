extends CanvasLayer

@onready var texto_dica = $Background/Text
@onready var painel = $Background
@onready var close = $Background/CloseButton

func _ready() -> void:
	visible = false
	HintManager.mostrar_dica.connect(_on_mostrar_dica)
	HintManager.esconder_dica.connect(_on_esconder_dica)

func _on_mostrar_dica(texto: String):
	texto_dica.text = texto
	visible = true

func _on_close_button_pressed():
	_on_esconder_dica()

func _on_esconder_dica():
	visible = false
