extends Node

var events = ["inicio"];

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

# id é um identificador único do objeto 
# e action é um identificador único da ação sofrida
func submit_object_action(id: String, action: String):
	# TODO Definir os eventos
	on_event.emit(events.get(events.size()-1));

func submit_terminal_action(fs: FileSystem, cmd: String, stdout: String):
	# TODO Definir os eventos
	
	# Essa função vai ter que modificar o fs de vez em qnd,
	# tipo quando um pendrive for inserido,
	# ela já é meio gigante então vale passar isso pra outra classe ou outro método dps
	
	on_event.emit(events.get(events.size()-1));

signal on_event(name: String);

# Tudo aí embaixo é temporário, a não ser que não seja :)
# Documentação dos eventos, algumas convenções:
#	- Cada linha separada é um evento, no formato "NomeDoEvento" - ChamadaQueDáTriggerNoEvento(parâmetros):
#	- ? é um comentário (comentário dentro do comentário) ?
#	- Isso aqui seria muito melhor como uma planilha, mas eu tou com preguiça
# ---------------
# inicio - Nenhuma chamada, estado inicial
# ---------------
# ? Tem um ou mais eventos faltando aqui, que seria aquela ideia do elevador ?
# ---------------
# caboConectado - ? A chamada que aconteceria ao clicar no elevador, provavelmente submit_object_action("elevador", "usar") ?
# ---------------
# ? Não sei se tá faltando um ou dois desafios aqui com o terminal, esqueci o que a gente decidiu ?
# ---------------
# cofreAberto - submit_object_action("cofre", "abrir")
# ---------------
# pendriveBrancoColetado - submit_object_action("pendriveBranco", "coletar")
# ---------------
# pendriveBrancoInserido - submit_object_action("pendriveBranco", "inserir")
# ? Talvez essa ação seja originada no terminal, não sei dizer, chutei ?
# ---------------
# diretorioDevListado - submit_terminal_action(fs, "ls ...", "? a definir ?")
# ---------------
# pendriveBrancoMontado - submit_terminal_action(fs, "? Não sei que comando monta o sistema ?", "? ñ sei ?")
# ---------------
# ? Nota sobre essa sequencia de eventos abaixo: Ela é bem baseada no jogador acessar as três pastas em sequência,
# coisa que não tem como garantir de acontecer, tem que pensar os dialogos em volta disso ou repensar essa parte um pouco. ?
# historiaVilaoLida - submit_terminal_action(fs, "ls ...", "? história do vilao ?")
# ---------------
# grepPrimeiraMetadeSenha - submit_terminal_action(fs, "grep ...", "? ñsei ?")
# ---------------
# grepRecSegundaMetadeSenha - submit_terminal_action(fs, "grep -r ...", "? ñsei ?")
# ---------------
# fundoGavetaRemovido - submit_object_action("gaveta", "removerFundo")
# ---------------
# pendriveCinzaColetado - submit_object_action("pendriveCinza", "coletar")
# ---------------
# pendriveCinzaInserido - submit_object_action("pendriveCinza", "inserir")
# ---------------
# pendriveCinzaMontado - submit_terminal_action(fs, "? Não sei que comando monta o sistema ?", "? ñ sei ?")
# ---------------
# ? Esse próximo desafio é meio complexo, envolve vários comandos, tem que ver como a gente vai apresentar ele,
# ? Então não vou colocar os eventos de terminal dele ?
# ---------------
# pacoteProjetorEnviado - submit_terminal_action(fs, "pacoteDoJogador.zip > /projetor", "")
# ---------------
# senhaSalaInserida - submit_object_action("entradaSenha", "senhaCorreta")
# ---------------
