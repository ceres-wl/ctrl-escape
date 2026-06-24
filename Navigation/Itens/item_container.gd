extends item

@export var other_texture : Texture2D
@export var original_texture : Texture2D

var open = false

func _ready():
	type_atual = type_item.CONTAINER
	for filho in get_children():
		if filho is item:
			filho.visible = false

func change_container():
	open = !open
	
	if(open):
		icon = other_texture
	else:
		icon = original_texture

	for filho in get_children():
		if filho is item:
			if(filho.type_atual != type_item.COLLECTIBLE || !filho.coletado):
				filho.visible = open
	
