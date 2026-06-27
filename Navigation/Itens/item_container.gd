extends item
class_name item_container

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
	if open:
		icon = other_texture
		size = other_texture.get_size()
	else:
		icon = original_texture
		size = original_texture.get_size()

	for filho in get_children():
		if filho is item:
			if(filho.type_atual != type_item.COLLECTIBLE || !filho.coletado):
				filho.visible = open

func save():
	var dict = super.save();
	dict.set("open", open);
	return dict;

func load_self(data: Dictionary):
	# HACK o ideal seria fazer um set_open e um set_close, algo assim
	open = !data.get("open");
	change_container()
