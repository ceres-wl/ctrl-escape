extends Node

var events = { "inicio_tutorial": true }
var lastEvent = "inicio_tutorial"

# HACK pra dar a volta no sistema de inserir pendrive no terminal
# o ideal seria fazer um sistema que permita que o terminal receba dados
var cur_fs: FileSystem = null;

# dicionario usado para as senhas (PODE SER EXCLUIDO, PENSE DUAS VEZES
# ANTES DE USAR, VOCE FOI AVISADO)

var status_senha = {}

func set_senha(id_senha: String):
	status_senha[id_senha] = false
	
func change_senha(id_senha: String):
	status_senha[id_senha] = true
	
func get_status_senha(id_senha: String):
	if status_senha.has(id_senha):
		return status_senha[id_senha]
	return false

func _ready():
	add_to_group("persist")

func set_event(event: String):
	if not events.get(event):
		events.set(event, true)
		lastEvent = event

# id é um identificador único do objeto 
# e action é um identificador único da ação sofrida
func submit_object_action(id: String, action: String):
	# NOTA: a ordem desse match não é exatamente a ordem
	# que os eventos vão ocorrer
	match id:
		"painel_tutorial":
			set_event("senha_correta_tutorial");
		"elevador_tutorial":
			set_event("inicio_sala01");
		"computador_sala01":
			set_event("cabo_conectado_sala01");
			# TODO permitir que o terminal seja acessado
		"terminal_sala01" when action == "pwd":
			set_event("terminal_pwd_sala01");
		"terminal_sala01" when action == "inserir_pendrive_branco":
			# TODO inserir dados do pendrive no fs
			set_event("pendrive_branco_inserido_sala01");
		"terminal_sala01" when action == "inserir_pendrive_vermelho":
			# TODO inserir dados do pendrive no fs
			set_event("pendrive_vermelho_inserido_sala01")
		"cofre_sala01":
			set_event("cofre_aberto_sala01");
		"gaveta_senha_sala01":
			set_event("gaveta_senha_aberta_sala01");
		"elevador_sala01":
			set_event("fim_sala01")
	on_event.emit(events.get(events.size()-1));

func submit_terminal_action(fs: FileSystem, cmd: String, stdout: String):
	cur_fs = fs;
	# TODO implementar lógica que checa se o evento aconteceu ou nn
	# "cd1_sala01" - submit_terminal_action(fs, "cd ?", "")
	# "cat_senha1_sala01" - submit_terminal_action(fs, "cat ?", "?senha?")
	# "pendrive_branco_montado_sala01" - submit_terminal_action(fs, "?", "?")
	# "grep1_sala01" - submit_terminal_action(fs, "?", "?")
	# "grepr1_sala01" - submit_terminal_action(fs, "?", "?")
	# "grepc1_sala01" - submit_terminal_action(fs, "?", "?")
	# "pendrive_vermelho_montado_sala01" - submit_terminal_action(fs, "?", "?")
	# "pptx_enviado_sala01" - submit_terminal_action(fs, "cat enigma.pptx > /dev/projetor", "")
	
	on_event.emit(events.get(events.size()-1));

signal on_event(name: String);

# "inicio_tutorial" - Nenhuma chamada, estado inicial
# ---------------------------
#1. Dar zoom no papel com a senha e digitar a senha no painel do elevador, abrindo a porta dele

# "senha_correta_tutorial" - submit_object_action("painel_tutorial", "senha_correta")
# ---------------------------
#2. Entrando no elevador e saindo dentro da sala principal, o jogador deve abrir a gaveta, pegar o cabo de força e conectar no computador

# "inicio_sala01" - submit_object_action("elevador_tutorial", "entrar")
# "cabo_conectado_sala01" - submit_object_action("computador_sala01", "conectar_cabo")
# ---------------------------
#3. Abrindo o terminal, deve-se navegar pelos diretórios como o Tux diz pra fazer e dar cat em um arquivo com a senha que deve ser inserida no cofre com o pendrive branco
# "terminal_aberto1_sala01" - submit_object_action("terminal_sala01", "abrir")
# "cd1_sala01" - submit_terminal_action(fs, "cd ?", "")
# "cat_senha1_sala01" - submit_terminal_action(fs, "cat ?", "?senha?")
# "cofre_aberto_sala01" - submit_object_action("cofre_sala01", "abrir")
# "pendrive_branco_inserido_sala01" - submit_object_action("terminal_sala01", "inserir_pendrive_branco")
# ---------------------------
#4. Montar o pendrive pela primeira vez com as pastas contendo os textos com a história do vilão
# "pendrive_branco_montado_sala01" - submit_terminal_action(fs, "?", "?")
# ---------------------------
#5. Tux te ensina a usar o grep, mostra as flags -r (recursive) e -c (count)
# "grep1_sala01" - submit_terminal_action(fs, "?", "?")
# "grepr1_sala01" - submit_terminal_action(fs, "?", "?")
# "grepc1_sala01" - submit_terminal_action(fs, "?", "?")
# ---------------------------
#6. Tux pede pra você contar o número de ocorrências da palavra "eu" nos textos
# ---------------------------
#7. O número de ocorrências é a senha da gaveta que contém o pendrive vermelho
# "gaveta_senha_aberta_sala01" - submit_object_action("gaveta_senha_sala01", "abrir")
# ---------------------------
#8. Montando o sistema do segundo do pendrive, vai ter um arquivo que deve ser enviado para o projetor usando redirecionamento de saída junto com o comando cat (tipo cat enigma.pptx > /dev/projetor)
# "pendrive_vermelho_inserido_sala01" - submit_object_action("terminal_sala01", "inserir_pendrive_vermelho")
# "pendrive_vermelho_montado_sala01" - submit_terminal_action(fs, "?", "?")
# "pptx_enviado_sala01" - submit_terminal_action(fs, "cat enigma.pptx > /dev/projetor", "")
# ---------------------------
#9. Agora o projetor começa a exibir o enigma "As árvores em nosso tempo são cheias de zeros à esquerda"
# ---------------------------
#10. Contando a quantidade de galhos à esquerda e à direita da árvore, obtém-se o número binário 01110010, que na base decimal é 114
# ---------------------------
#11. Ao inserir essa no elevador, o jogador é levado à tela de despedida
# "fim_sala01" - submit_object_action("elevador_sala01", "entrar")

# Só deus sabe se isso tá funcionando, tem que testar depois
func save():
	var fs = null;
	if(cur_fs): fs = cur_fs.get_path();
	return {
		"path": get_path(),
		"events": events,
		"fs": fs,
		"senhas": status_senha
	}

func load_self(data: Dictionary):
	if data.get("fs") != null: cur_fs = get_node(data.get("fs"));
	events = data.get("events");
	status_senha = data.get("senhas");
	
