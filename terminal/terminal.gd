class_name Terminal
extends Control

# TODO checar o comportamento de todos esses comandos pra ver se tão certos
# TODO acho que tá faltando vários feedbacks qnd o comando não é completado com sucesso
# TODO variáveis

# Existe algum processo rodando (grep)
var procRunning = false;
# Fila de Entrada do terminal enquanto um processo está rodando
var stdin = "";
# Fila de saida do terminal enquanto um processo está rodando
var stdout = "";

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

# Função de uso interno, com opção de sanitizar o bbcode
func t_print(text_: String, sanitize = false, newline = true):
	if(sanitize): text_ = text_.replace("[", "[lb]");
	%Output.append_text(text_);
	if(newline): %Output.newline();

func clear(_args: PackedStringArray, _flags: Dictionary):
	%Output.clear();

# TODO -m = não adicionar quebra de linha
func echo(args: PackedStringArray, flags: Dictionary):
	var text = " ".join(args);
	text = text.replace("[", "[lb]");
	return text;

func cd(args: PackedStringArray, _flags: Dictionary):
	%FileSystem.navigate("".join(args));
	%DisplayPath.text = %FileSystem.cur_path;

# TODO -a = Mostrar arquivos escondidos
func ls(args: PackedStringArray, flags: Dictionary):
	var path = "".join(args);
	var folders = %FileSystem.list_folders(path);
	var files = %FileSystem.list_files(path);
	
	var tokens = PackedStringArray();
	for folder: Folder in folders:
		tokens.push_back("[color=#A0A0FF]%s[/color]" % folder.folder_name);
	for file: File in files:
		tokens.push_back("[color=#FFA0A0]%s[/color]" % file.file_name);
	tokens.sort();
	return " ".join(tokens);

# TODO -p = Criar diretórios pais inexistentes
func mkdir(args: PackedStringArray, flags: Dictionary):
	# FIXME sanitizar nome da pasta
	# FIXME não deixar recriar uma pasta que já existe
	%FileSystem.create_folder("".join(args));

func touch(args: PackedStringArray, _flags: Dictionary):
	# FIXME sanitizar nome do arquivo
	# FIXME não deixar recriar um arquivo que já existe
	%FileSystem.create_file("".join(args));

# TODO -r = Apagar pastas
func rm(args: PackedStringArray, flags: Dictionary):
	pass

# TODO -r = Copiar pastas
func cp(args: PackedStringArray, flags: Dictionary):
	pass

func mv(args: PackedStringArray, _flags: Dictionary):
	pass

func cat(args: PackedStringArray, _flags: Dictionary):
	pass

func pwd(_args: PackedStringArray, _flags: Dictionary):
	return %FileSystem.cur_path.replace("[", "[lb]");

# TODO -r = recursivo
func grep(args: PackedStringArray, flags: Dictionary):
	pass

# Nome provisório, comando que prepara arquivo do projetor
func zip(args: PackedStringArray, _flags: Dictionary):
	pass

# === Funções auxiliares === #

# TODO echo hdausd/ads/*.txt <-- expansão, dificil, baixa prioridade
# TODO adicionar "a b" ou a\ b como um argumento só
# TODO substituir quebra de linha por [br]
# TODO atualizar lastOutput
# TODO mudar o nome dessa função, não me faz mt sentido esse
func parse(input: String):
	# Regex que dá split nos operadores pra achar os comandos
	var regexCmds = RegEx.create_from_string("[^>]+");
	
	# Regex que acha os operadores
	# A pattern sem os escapes de string é \s+>>\s+|\s+>\s+
	# Provavelmente tem como deixar essa pattern mais bonitinha
	var regexOp = RegEx.create_from_string("\\s+>>\\s+|\\s+>\\s+");
	
	# Printar linha que foi executada
	t_print(">> "+input, true);
	
	var ops = [];
	for op in regexOp.search_all(input):
		ops.push_back(op.get_string().strip_edges());
	if len(ops) > 1:
		# Como só temos os operadores > e >>, não podemos ter mais de 2 operadores
		# Obviamente essa solução é bem especifica pro nosso caso, mas está correta
		t_print("Quantidade inválida de operadores")
		return;
	
	var cmds = regexCmds.search_all(input);
	
	var i = 0;
	while i < len(cmds):
		var cmd = parse_command(cmds[i].get_string().strip_edges());
		var op = ops[i] if i+1 != len(cmds) else null;
		if(ACTIONS.get(cmd.command)):
			var output = ACTIONS[cmd.command].call(cmd.args, cmd.flags);
			match op:
				">>": # Append
					i+=1;
					# Isso deveria ser um path válido, se não for é papel do sistema de arquivos testar
					var path = cmds[i].get_string().strip_edges();
					%FileSystem.append_content(path, output);
				">": # Sobrescreve
					i+=1;
					# Isso deveria ser um path válido, se não for é papel do sistema de arquivos testar
					var path = cmds[i].get_string().strip_edges();;
					%FileSystem.set_content(path, output);
				_:
					if(output): t_print(output);
		else:
			t_print("O comando %s não existe" % cmd.command, true);
			break; # Se algum comando falhar, os outros são cancelados
		i+=1;
# Supõe que a entrada é um comando unico, sem redirecionamento
# Argumentos para flags não foram implementados
func parse_command(input: String) -> Dictionary:
	var args: PackedStringArray =  input.strip_edges().split(" ");
	var cmd = args[0]; # args é um PackedStringArray então não tem pop_front
	var flags = {} # Flags são um set mas poderiam ser uma lista sem problemas
	args.remove_at(0);
	
	for token: String in args:
		if(token[0] == "-"):
			# Como tou supondo que nenhuma flag tem argumento,
			# O argumento da flag é sempre null
			flags.set(token.substr(1), null)
	
	return {
		"command": cmd,
		"args": args,
		"flags": flags
	}

func _on_input_text_submitted(_new_text):
	parse(%Input.text);
	%Input.text = "";
