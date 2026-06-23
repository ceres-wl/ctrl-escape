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

var FLAGS_DESC = {
	"clear": {}, # clear não possui flags (no nosso jogo)
	"echo": {"n" : false}, # echo possui uma única flag, -n, que não recebe argumento
	"cd" : {},
	"ls": {"a" : false},
	"mkdir": {"p" : false},
	"touch": {},
	"rm": {"r" : false},
	"cp": {"r" : false},
	"mv": {},
	"cat": {},
	"pwd": {},
	"grep": {"e" : true, "v" : false} # grep possui duas flags, uma recebe argumento e a outra não
}

var lastOutput = "";

func _ready():
	%DisplayPath.text = %FileSystem.cur_path;

# Função de uso interno, com opção de sanitizar o bbcode
func t_print(text_: String, sanitize = false, newline = true):
	if(sanitize): text_ = text_.replace("[", "[lb]");
	%Output.append_text(text_);
	if(newline): %Output.newline();

func clear(_operands: PackedStringArray, _flags: Dictionary):
	%Output.clear();

func echo(operands: PackedStringArray, flags: Dictionary):
	var text = " ".join(operands);
	if not flags.get("n"):
		text = text + "\n"
	return text;

func cd(operands: PackedStringArray, flags: Dictionary):
	%FileSystem.navigate("".join(operands));
	%DisplayPath.text = %FileSystem.cur_path;

func ls(operands: PackedStringArray, flags: Dictionary):
	var tokens = PackedStringArray();
	var i = 0
	# Emulando do while
	while true:
		var path = "" if operands.size() == 0 else operands[i]
		if operands.size() > 1: tokens.push_back(path + ":")
		
		var folders = %FileSystem.list_folders(path);
		var files = %FileSystem.list_files(path);
		var folder_tokens = PackedStringArray()
		var file_tokens = PackedStringArray()
		
		for folder: Folder in folders:
			if not flags.get("a") and folder.folder_name[0] == ".": continue
			folder_tokens.push_back(folder.folder_name)
		for file: File in files:
			if not flags.get("a") and file.file_name[0] == ".": continue
			file_tokens.push_back(file.file_name)
		
		folder_tokens.sort()
		file_tokens.sort()
		
		var j = 0
		while j < len(folder_tokens):
			if folder_tokens[j].find(" ") != -1:
				folder_tokens[j] = "\'%s\'" % folder_tokens[j]
			folder_tokens[j] = "[color=#A0A0FF]%s[/color]" % folder_tokens[j]
			j+=1
		j = 0
		while j < len(file_tokens):
			if file_tokens[j].find(" ") != -1:
				file_tokens[j] = "\'%s\'" % file_tokens[j]
			file_tokens[j] = "[color=#FFA0A0]%s[/color]" % file_tokens[j]
			j+=1
		tokens = tokens + folder_tokens + file_tokens
		
		i+=1
		if (i >= operands.size()): break;
	
	return "\n".join(tokens);

# TODO -p = Criar diretórios pais inexistentes
func mkdir(operands: PackedStringArray, flags: Dictionary):
	# FIXME sanitizar nome da pasta
	# FIXME não deixar recriar uma pasta que já existe
	for operand in operands:
		if (operand != ""): %FileSystem.create_folder(operand);

func touch(operands: PackedStringArray, flags: Dictionary):
	# FIXME sanitizar nome do arquivo
	# FIXME não deixar recriar um arquivo que já existe
	for operand in operands:
		%FileSystem.create_file(operand);

# TODO -r = Apagar pastas
func rm(operands: PackedStringArray, flags: Dictionary):
	#for arg in args:
		#%FileSystem.remove_file()
	pass

# TODO -r = Copiar pastas
func cp(operands: PackedStringArray, flags: Dictionary):
	pass

func mv(operands: PackedStringArray, flags: Dictionary):
	pass

func cat(operands: PackedStringArray, flags: Dictionary):
	pass

func pwd(_operands: PackedStringArray, _flags: Dictionary):
	return %FileSystem.cur_path.replace("[", "[lb]");

# TODO -r = recursivo
func grep(operands: PackedStringArray, flags: Dictionary):
	pass

# Nome provisório, comando que prepara arquivo do projetor
func zip(operands: PackedStringArray, flags: Dictionary):
	pass

# === Funções auxiliares === #

# TODO echo hdausd/ads/*.txt <-- expansão, dificil, baixa prioridade
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
			var output = ACTIONS[cmd.command].call(cmd.operands, cmd.flags);
			if output == null: break; # Se algum comando falhar, os outros são cancelados
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
func parse_command(input: String):
	var args_start = input.find(" ") # Identifica final do nome do comando
	var cmd = input.substr(0, args_start) # Nome do comando executado
	var args = PackedStringArray() # Lista com os argumentos recebidos
	
	var quotes = ["\"", "\'"]
	var insideQuotes = false
	var currentParsedArg = ""
	
	# Separa os argumentos (incluindo operandos e flags) levando em consideração
	# as aspas, mas não as barras invertidas
	if args_start != -1:
		var i = args_start + 1
		while i < len(input):
			if (not insideQuotes and input[i] in quotes):
				insideQuotes = true
			elif (insideQuotes and input[i] in quotes):
				insideQuotes = false
				args.append(currentParsedArg)
				currentParsedArg = ""
			elif (not insideQuotes and input[i] == " "):
				args.append(currentParsedArg)
				currentParsedArg = ""
			else: currentParsedArg += input[i]
			i += 1
		if (currentParsedArg != ""):
			args.append(currentParsedArg)
			currentParsedArg = ""
	
	# Na lista de argumentos, separa as flags dos operandos, definindo os estados
	# de cada flag que não recebe argumentos como true ou false e os das que recebem
	# argumentos como uma string com o respectivo argumento
	var possibleFlags = FLAGS_DESC.get(cmd)
	var operands = PackedStringArray()
	var flags = Dictionary()
	var i = 0
	while i < args.size():
		if len(args[i]) == 2 and args[i][0] == "-" and possibleFlags.get(args[i][1]) != null:
			if possibleFlags.get(args[i][1]):
				if i + 1 < args.size():
					flags.set(args[i][1], args[i+1])
					i+=1
				else:
					t_print("%s: a opção requer um argumento -- \"%s\"" % [cmd, args[i][1]])
					return null
			else:
				flags.set(args[i][1], true)
		else:
			operands.push_back(args[i])
		i+=1
	if possibleFlags != null:
		for flag in possibleFlags:
			if flags.get(flag) == null:
				flags.set(flag, false)
	
	return {
		"command": cmd,
		"operands": operands,
		"flags": flags
	}

func _on_input_text_submitted(_new_text):
	parse(%Input.text);
	%Input.text = "";

func _on_submit_pressed():
	parse(%Input.text);
	%Input.text = "";
