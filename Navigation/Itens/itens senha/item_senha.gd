extends item_zoom

var concluido = false
var cena_instanciada

func open_zoom() -> void:
	cena_instanciada = NavigationManager.start_zoom(cena_zoom)
	
func is_finished():
	if cena_instanciada:
		concluido = cena_instanciada.concluido
	return concluido
	
