extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var campo_imagem = texture_normal.get_image()
	var mascara = BitMap.new()
	mascara.create_from_image_alpha(campo_imagem, 0.5)
	texture_click_mask = mascara


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
