extends Node

var dialogues = {
	"inicio_sala01": [
		"Olá! Sou Tux, o Pinguim.",
		"Que bom que você chegou...Embora eu esteja sorrindo, estava começando a me preocupar pensando que ninguém viria me salvar...",
		"Mas agora está tudo bem, pois sei que você vai me tirar daqui!",
		"Bom, para isso você vai precisar usar esse computador que está aqui ao meu lado, mas ele está desligado.",
		"Sei que em algum lugar nessa sala tem um cabo de força para alimentá-lo...Procure por ele e conecte-o ao pc e à tomada para que possamos continuar."
	],
	"cabo_conectado_sala01": [
		"Excelente! Agora irei ensiná-lo o básico sobre o terminal.",
		#"Se você se esquecer do que eu acabei de dizer, basta abrir o menu principal clicando na engrenagem que aparece no canto superior direito da tela para rever o que eu te expliquei.",
		"Quero que você use 4 comandos: pwd, ls, cd e cat.",
		"Vamos ver como eles funcionam na prática.",
		"Primeiro, entre no terminal e escreva o comando pwd."
	],
	"terminal_pwd_sala01": [
		"O pwd (print working directory) te diz qual o diretório em que você está. Um diretório é basicamente uma pasta no seu computador ou, em outra palavras, um \"lugar\" que guarda arquivos e outros diretórios dentro de si. Movendo-se pelos diretórios você tem acesso aos diferentes arquivos do computador, inclusive aos que contém as informações necessárias para sairmos daqui juntos!",
		"Seguindo para o próximo comando...",
		"A qualquer momento, você pode escrever \"cd /\" para ir imediatamente para a pasta raiz. Tente fazer isso agora."
	],
	"terminal_cd_slash_sala01": [
		"O cd (change directory) serve para você mudar o seu diretório atual. Executando \"cd /\", você seguiu diretamente para a pasta raiz, que é onde todos os arquivos do sistema estão guardados.",
		"Experimente agora rodar o comando ls."
	],
	"terminal_ls_root_sala01": [
		"O ls (list) mostra quais os arquivos e diretórios que estão guardados no diretório em que você se encontra atualmente. As pastas são exibidas em azul e os arquivos, em vermelho.",
		"Tente entrar na pasta \"Senhas\" rodando o comando \"cd Senhas\"."
	],
	"terminal_cd_senhas_sala01": [
		"Excelente! Você pode verificar que sua pasta atual mudou rodando o comando pwd novamente.",
		"Quando desejar seguir em frente, escreva \"ls\" para encontrarmos o arquivo com a senha do cofre."
	],
	"terminal_ls_senhas_sala01": [
		"Agora temos que visualizar o conteúdo do arquivo com a senha do cofre. Perceba, entretanto que ele possui espaços em branco no seu nome.",
		"Por causa disso, utilizaremos aspas duplas para delimitar o nome do arquivo na chamada do próximo comando.",
		"Escreva cat \"Senha do Cofre.txt\""
	],
	"terminal_cat_senhacofre_sala01": [
		"O comando cat (concatenate) tem um nome meio estranho, mas ele serve basicamente para visualizar o conteúdo de um arquivo.",
		"Nesse computador que você vai usar, quase todos os arquivos são arquivos de texto, o que significa que ao visualizar o conteúdo deles você encontrará um conjunto de letras, números, espaços e outros caracteres que formam um texto que pode ser lido por nós.",
		"Agora que temos a senha do cofre, vamos abri-lo!"
	]
}

var current_dialogue_label = ""
var current_dialogue = []
var dialogue_idx = 0

var historico = []

signal show_text(text: String)
signal close_dialogue()

func _ready():
	add_to_group("persist");

func start_dialogue():
	current_dialogue_label = ProgressionManager.lastEvent
	current_dialogue = dialogues[current_dialogue_label]
	dialogue_idx = 0
	
	for frase in current_dialogue:
		if(not historico.has(frase)):
			historico.append(frase)
	
	show_text.emit(current_dialogue[dialogue_idx])

func next_sentence():
	dialogue_idx += 1
	if(dialogue_idx < current_dialogue.size()):
		show_text.emit(current_dialogue[dialogue_idx])
	else:
		close_dialogue.emit()

func save():
	return {
		"path": get_path(),
		"historico": historico
	}

func load_self(data: Dictionary):
	historico = data.get("historico");
