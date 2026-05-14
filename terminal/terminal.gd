class_name Terminal
extends Control

# TODO checar o comportamento de todos esses comandos pra ver se tão certos
# TODO acho que tá faltando vários feedbacks qnd o comando não é completado com sucesso
# TODO redirecionamento
# TODO variáveis

# TODO separar o terminal do sistema de arquivos

var ACTIONS = {
	"clear": clear,
	"echo": echo,
	"cd" : cd,
	"ls": ls,
	"mkdir": mkdir,
	"touch": touch,
	"rm": rm,
	"cp": cp,
	"mv": mv,
	"cat": cat,
	"pwd": pwd,
	"grep": grep
}

var lastOutput = "";

func _ready():
	%DisplayPath.text = %FileSystem.cur_path;

# Função de uso interno, o texto tem que ser sanitizado por causa do BBcode
func t_print(text_: String):
	%Output.append_text(text_);
	%Output.newline();

func clear(_args: PackedStringArray):
	%Output.clear();

# TODO -m = não adicionar quebra de linha
func echo(args: PackedStringArray):
	var text = " ".join(args);
	text = text.replace("[", "[lb]")
	t_print(text);

func cd(args: PackedStringArray):
	%FileSystem.navigate("".join(args));
	%DisplayPath.text = %FileSystem.cur_path;

# TODO -a = Mostrar arquivos escondidos
func ls(args: PackedStringArray):
	var path = "".join(args);
	var folders = %FileSystem.list_folders(path);
	var files = %FileSystem.list_files(path);
	
	var tokens = PackedStringArray();
	for folder: Folder in folders:
		tokens.push_back("[color=#A0A0FF]%s[/color]" % folder.folder_name);
	for file: File in files:
		tokens.push_back("[color=#FFA0A0]%s[/color]" % file.file_name);
	tokens.sort();
	t_print(" ".join(tokens));

# TODO -p = Criar diretórios pais inexistentes
func mkdir(args: PackedStringArray):
	# FIXME não deixar recriar uma pasta que já existe
	%FileSystem.create_folder("".join(args));

func touch(args: PackedStringArray):
	# FIXME não deixar recriar um arquivo que já existe
	%FileSystem.create_file("".join(args));

# TODO -r = Apagar pastas
func rm(args: PackedStringArray):
	pass

# TODO -r = Copiar pastas
func cp(args: PackedStringArray):
	pass

func mv(args: PackedStringArray):
	pass

func cat(args: PackedStringArray):
	pass

func pwd(args: PackedStringArray):
	echo(PackedStringArray([%FileSystem.cur_path]));

# TODO -r = recursivomkd
func grep(args: PackedStringArray):
	pass

# Nome provisório, comando que prepara arquivo do projetor
func zip(args: PackedStringArray):
	pass

# === Funções auxiliares === #

# TODO echo hdausd/ads/*.txt <-- expansão, dificil, baixa prioridade
# TODO adicionar "a b" ou a\ b como um argumento só
# TODO substituir quebra de linha por [br]
# TODO atualizar lastOutput
func parse(input: String):
	# ls | grep [>>, >] arquivo.txt
	# TODO Função que roda os comandos, aplicando os operadores
	pass

# Supõe que a entrada é um comando, sem redirecionamento por exemplo
func parse_command(input: String):
	return {
		"command": "cmd",
		"args": [],
		"flags": {
				"p": "arg"
			}
	}

func _on_submit_pressed():
	# TODO Adicionar sinal(sinaliza o output do comando, não o comando em si)
	var args: PackedStringArray =  %Input.text.split(" ");
	var cmd = args[0]; # args é um PackedStringArray então não tem pop_front
	
	# Printar comando que foi executado
	var display_cmd = args.duplicate();
	display_cmd.insert(0, ">>");
	echo(display_cmd);
	
	args.remove_at(0);
	if(ACTIONS.get(cmd)):
		ACTIONS[cmd].call(args);
	else:
		echo(PackedStringArray(["O comando %s não existe" % cmd]));
	
	%Input.text = "";


func _on_input_text_submitted(_new_text):
	_on_submit_pressed();
