extends Control

signal senha_correta
signal fechar_zoom

var senha_certa = "1234"
var input_atual = ""
var porta: TextureButton = null

@onready var display = $Keypad/display

func atualizar_visor():
	var novo_texto = ""
	for i in range(4):
		if(i < input_atual.length()):
			novo_texto += input_atual[i] + " "
		else:
			novo_texto += "_ "
	display.text = novo_texto.strip_edges()

func limpar_visor():
	input_atual = ""
	display.modulate = Color.WHITE
	atualizar_visor()

func _ready():
	atualizar_visor()
	
	if get_tree().current_scene.has_node("Door"):
		porta = get_tree().current_scene.get_node("Door") as TextureButton
	
	#conectar cada botao numerico
	$Keypad/key_0.pressed.connect(_on_botao_numero_pressed.bind("0"))
	$Keypad/key_1.pressed.connect(_on_botao_numero_pressed.bind("1"))
	$Keypad/key_2.pressed.connect(_on_botao_numero_pressed.bind("2"))
	$Keypad/key_3.pressed.connect(_on_botao_numero_pressed.bind("3"))
	$Keypad/key_4.pressed.connect(_on_botao_numero_pressed.bind("4"))
	$Keypad/key_5.pressed.connect(_on_botao_numero_pressed.bind("5"))
	$Keypad/key_6.pressed.connect(_on_botao_numero_pressed.bind("6"))
	$Keypad/key_7.pressed.connect(_on_botao_numero_pressed.bind("7"))
	$Keypad/key_8.pressed.connect(_on_botao_numero_pressed.bind("8"))
	$Keypad/key_9.pressed.connect(_on_botao_numero_pressed.bind("9"))

func _on_botao_numero_pressed(numero: String):
	if(input_atual.length() < 4):
		input_atual += numero
		atualizar_visor()

func _on_botao_submit_pressed():
	if(input_atual == senha_certa):
		display.modulate = Color.GREEN
		
		get_tree().call_group("sala_tutorial", "abrir_porta")
		
		#espera 1 segundo antes de fechar
		await get_tree().create_timer(1.0).timeout
		NavigationManager.finish_zoom_tutorial()
	else:
		display.modulate = Color.RED
		await get_tree().create_timer(1.0).timeout
		limpar_visor()
