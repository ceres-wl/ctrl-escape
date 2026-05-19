class_name FileSystem
extends Node

# Entidade que é responsável por guardar 
# e navegar pelo sistema de arquivos

# Opções pro sistema de arquivos(Escolhi a primeira opção):
# Uma árvore em que cada pasta aponta pras pastas dentro dela
# Um dicionario (com que estrutura não sei), se a gente se importar com o tempo de acesso

var root: Folder = Folder.new("", null);

# Pasta sendo navegada atualmente
var cur_folder: Folder = root;
var cur_path: String = "/"; # Caminho atual

var lastModifiedFolder = null;
var lastModifiedFile = null;

func navigate(path: String):
	var folder = resolve_path(path, true);
	if(folder):
		cur_folder = folder;
		cur_path = get_full_path(folder);

# TODO o mkdir avisa se o folder foi criado com sucesso ou não?
# TODO lastModifiedFolder
func create_folder(path: String):
	var formatted = format_path(path);
	var folder_name = formatted.tokens[formatted.tokens.size()-1];
	formatted.tokens.remove_at(formatted.tokens.size()-1);
	
	# folder pai do folder que vai ser criado
	var folder = resolve_path_tokens(formatted.tokens, formatted.cur);
	if(folder):
		folder.create_folder(folder_name);
		return true;
	return false;

# TODO não sei se o touch avisa tbm
# TODO atualizar lastModifiedFile
# TODO lastModifiedFolder
func create_file(path: String):
	var formatted = format_path(path);
	var file_name = formatted.tokens[formatted.tokens.size()-1]
	formatted.tokens.remove_at(formatted.tokens.size()-1);
	
	# folder pai do arquivo que vai ser criado
	var folder = resolve_path_tokens(formatted.tokens, formatted.cur);
	if(folder): 
		folder.create_file(file_name);
		return true;
	return false;

# TODO lastModifiedFolder
func remove_folder(path: String):
	pass

# TODO atualizar lastModifiedFile
# TODO lastModifiedFolder
func remove_file(path: String):
	pass

# TODO atualizar lastModifiedFile
# TODO lastModifiedFolder
# Cria arquivo no path se ele não existe e o folder pai existe
func append_content(path: String, content: String):
	var file = resolve_file(path);
	if(!file):
		return false;
	file.append_content(content);
	return true;

# TODO atualizar lastModifiedFile
# TODO lastModifiedFolder
func set_content(path: String, content: String):
	var file = resolve_file(path);
	if(!file):
		return false;
	file.set_content(content);
	return true;

# Cria arquivo no path se ele não existe e o folder pai existe
func resolve_file(path):
	var formatted = format_path(path);
	var file_name = formatted.tokens[formatted.tokens.size()-1]
	formatted.tokens.remove_at(formatted.tokens.size()-1);
	
	var folder = resolve_path_tokens(formatted.tokens, formatted.cur);
	if(!folder):
		return null;
	if(!folder.get_file(file_name)):
		create_file(path);
	return folder.get_file(file_name);

func get_content(path: String):
	pass

func list_files(path: String) -> Array[File]:
	var folder = resolve_path(path);
	if(!folder): return [];
	return folder.get_files();

func list_folders(path: String) -> Array[Folder]:
	var folder = resolve_path(path);
	if(!folder): return [];
	return folder.get_folders();

# Função pra pegar o caminho de uma pasta a partir do root
func get_full_path(folder: Folder) -> String:
	var path = folder.folder_name;
	var cur = folder.get_folder("..");
	while cur:
		path = cur.folder_name + "/" + path;
		cur = cur.get_folder("..");
	return "/" if path == "" else path;
	
func format_path(path: String):
	path = path.strip_edges();
	
	var absolute = false;
	
	if(path.begins_with("./")): path = path.replace("./", "");
	elif(path.begins_with("/")): absolute = true;
	
	var tokens = path.split("/", false);
	var cur: Folder = root if absolute else cur_folder;
	
	return {
		"tokens": tokens,
		"cur": cur
	}

# Isso tá separado em duas funções pq as vezes
# vai ser util modificar os tokens antes de resolver o path,
# a função de cima é uma função de conveniência basicamente
func resolve_path(path: String, absolute: bool = false) -> Folder:
	var formated = format_path(path);
	var tokens = formated.tokens;
	var cur = formated.cur;
	
	return resolve_path_tokens(tokens, cur, absolute);
func resolve_path_tokens(tokens: PackedStringArray, cur: Folder, absolute: bool = false):
	if(tokens.size() == 0): return root if absolute else cur;
	
	# Ignorar caso o usuário coloque um "/" no fim do caminho
	if(tokens[tokens.size()-1] == ""): tokens.remove_at(tokens.size()-1);
	
	for token in tokens:
		cur = cur.get_folder(token);
		if(cur == null): break;
	return cur;
