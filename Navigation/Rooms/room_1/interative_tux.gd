extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if texture_normal != null:
		var campo_imagem = texture_normal.get_image()
		var mascara = BitMap.new()
		mascara.create_from_image_alpha(campo_imagem, 0.5)
		texture_click_mask = mascara
	pressed.connect(_on_pressed)

func _on_pressed():
	DialogueManager.start_dialogue()
