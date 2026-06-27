extends item_container

# conferir se e o mesmo da tranca
@export var id_senha = ""
@export var id_lock = ""

func _ready():
	super()
	for filho in get_children():
		if filho is item && filho.id == id_lock:
			filho.visible = true

func change_container():
	if open || ProgressionManager.get_status_senha(id_senha):
		super()
		for filho in get_children():
			if filho is item && filho.id == id_lock:
				filho.visible = !open
		
	else:
		alertar_tranca()
	
# TODO: mecanismo para alertar que esta trancado
func alertar_tranca():
	pass
