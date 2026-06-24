class_name Folder
extends Node

var folder_name: String;

var parent: Folder;
# subpastas dentro dessa pasta
var folders: Dictionary[String, Folder] = {};
# arquivos dentro dessa pasta
var files: Dictionary[String, File] = {};

func _init(name_: String, parent_: Folder):
	folder_name = name_;
	parent = parent_;

func create_folder(name_: String):
	# Não é permitido haver uma pasta e um arquivo com o mesmo nome
	# em um mesmo diretório
	if (not folders.get(name_) and not files.get(name_)):
		folders.set(name_, Folder.new(name_, self));

func create_file(name_: String):
	# Não é permitido haver uma pasta e um arquivo com o mesmo nome
	# em um mesmo diretório
	if (not folders.get(name_) and not files.get(name_)):
		files.set(name_, File.new(name_));

# TODO remover recursivamente
func remove_folder(name_: String):
	return folders.erase(name_);

func remove_file(name_: String):
	return files.erase(name_);

func get_folder(name_: String) -> Folder:
	if(name_ == ".."): return parent;
	return folders.get(name_);

func get_file(name_: String) -> File:
	return files.get(name_);

func get_files() -> Array[File]:
	return files.values();

func get_folders() -> Array[Folder]:
	return folders.values();

func _to_string():
	# Transformando o dict em uma string
	var dict = {
		"folders": {},
		"files": {}
	}
	for fold: Folder in folders.values():
		dict.folders.set(fold.folder_name, fold._to_string())
	
	for file: File in files.values():
		dict.files.set(file.file_name, file.content)
	# FIXME problema (att: consertei o problema, mas o comentário é muito importante):
	# Pra descobrir se um elemento é uma pasta ou um arquivo,
	# tou vendo se ele contém outro dicionario dentro dele ou
	# só uma string, a consequência ruim disso é que tudo que
	# dá pra salvar do arquivo no momento é o conteudo dele, como uma string.
	# Ideia pra resolver isso:
	# Dar uma propriedade especial "type" pros dois dicionários, dizendo se
	# ele é um arquivo ou pasta, problema disso é que não seria possível criar
	# uma pasta ou arquivo chamado type, obviamente dá só pra mudar o nome dessa
	# propriedade mas enfim
	# textão gigantesco mas eu tinha que salvar o problema e a solução aqui pra não
	# esquecer depois, agora eu vou continuar escrevendo um pouquinho pra completar
	# mais uma linha, talvez duas. Se você estiver lendo isso mande o Ceres procurar
	# algo melhor pra fazer da vida do que escrever 13 linhas de comentário
	return dict;

# data no formato:
#{
#	"folders": {
#		"a": {}
#	}
#	"files" {}
#}
func load_string(data: Dictionary):
	for x in range(data.folders.size()):
		var keys = data.folders.keys();
		create_folder(keys[x]);
		get_folder(keys[x]).load_string(data.folders.get(keys[x]));
	for y in range(data.files.size()):
		var keys = data.files.keys();
		create_file(keys[y]);
		var content = data.files.get(keys[y]);
		get_file(keys[y]).content = content if content else "";
