extends Node

signal mostrar_dica(texto_dica: String)
signal esconder_dica()

var dicionario_dicas = {
	"inicio_tutorial": "Tente ver o que está escrito na carta no seu inventário (tecla E)",
	"senha_correta_tutorial": "A porta do elevador está aberta! Entre nele para prosseguir"
}

func pedir_dica():
	var ultimo_evento = ProgressionManager.lastEvent
	var dica = dicionario_dicas.get(ultimo_evento, "Continue explorando o ambiente e interagindo com os objetos")
	mostrar_dica.emit(dica)
