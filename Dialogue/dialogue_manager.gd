extends Node

var dialogues = {
	"tux_clique_1": [
		"Olá aventureiro! Eu nao sei o quanto eu preciso falar aqui",
		"porque isso depende do que voce ja viu no tutorial", 
		"o paulo é muito lindo",
		"vai dar um trabalho infernal ligar isso ao progresso"
	]
}

var current_dialogue = []
var dialogue_idx = 0

signal show_text(text: String)
signal close_dialogue()

func start_dialogue(dialogue_id: String):
	if(dialogues.has(dialogue_id)):
		current_dialogue = dialogues[dialogue_id]
		dialogue_idx = 0
		show_text.emit(current_dialogue[dialogue_idx])

func next_sentence():
	dialogue_idx += 1
	if(dialogue_idx < current_dialogue.size()):
		show_text.emit(current_dialogue[dialogue_idx])
	else:
		close_dialogue.emit()
