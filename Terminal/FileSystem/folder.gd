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
	return folders.values();; 
