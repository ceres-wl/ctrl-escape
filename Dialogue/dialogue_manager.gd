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
		"O pwd (print working directory) te diz qual o diretório em que você está. Um diretório é basicamente uma pasta no seu computador ou, em outra palavras, um \"lugar\" que guarda arquivos e outros diretórios dentro de si. Movendo-se pelos diretórios você tem acesso aos diferentes arquivos do computador, inclusive aos que contém as informações necessárias para sairmos daqui juntos!",
		"O ls (list) mostra quais os arquivos e diretórios que estão guardados no diretório em que você se encontra atualmente. As pastas são exibidas em azul e os arquivos, em vermelho.",
		"O cd (change directory) serve para você mudar o seu diretório atual. Você pode mudar para um diretório que se encontra dentro do diretório em que você está no momento ou então ir para o diretório pai do seu diretório atual, ou seja, o diretório dentro do qual o seu diretório está! É importante lembrar que há um diretório do sistema que não possui pai. Este é o chamado diretório raiz, dentro do qual se encontram todos os arquivos e diretórios do seu computador, direta ou indiretamente.",
		"Por fim, quero que você entenda como usar o cat (concatenate). Sei que o nome dele é meio estranho, mas ele serve basicamente para visualizar o conteúdo de um arquivo. Nesse computador que você vai usar, quase todos os arquivos são arquivos de texto, o que significa que ao visualizar o conteúdo deles você encontrará um conjunto de letras, números, espaços e outros caracteres que formam um texto que pode ser lido por nós.",
		"Agora vamos ver isso na prática.",
		"Primeiro, entre no terminal e escreva o comando pwd."
	],
	"terminal_pwd_sala01": [
		"Como você pode ver pela saída do comando pwd, atualmente você se encontra no diretório /. Este é exatamente o diretório raiz, que não contém pai."
	]
}

var current_dialogue_label = ""
var current_dialogue = []
var dialogue_idx = 0

signal show_text(text: String)
signal close_dialogue()

func start_dialogue():
	current_dialogue_label = ProgressionManager.lastEvent
	current_dialogue = dialogues[current_dialogue_label]
	dialogue_idx = 0
	show_text.emit(current_dialogue[dialogue_idx])

func next_sentence():
	dialogue_idx += 1
	if(dialogue_idx < current_dialogue.size()):
		show_text.emit(current_dialogue[dialogue_idx])
	else:
		close_dialogue.emit()
