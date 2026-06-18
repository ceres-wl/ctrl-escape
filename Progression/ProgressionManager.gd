extends Node

var cur_event = "inicio";

# TODO descobrir o que os objetos vão passar pra colocar aqui
func submit_object_action():
	# TODO Definir os eventos
	pass

func submit_terminal_action(fs: FileSystem, cmd: String, stdout: String):
	# TODO Definir os eventos
	pass

signal on_event(name: String);
