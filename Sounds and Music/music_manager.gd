extends Node

@onready var player = $AudioStreamPlayer
var config = ConfigFile.new()
var bus_index: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Musica")
	carregar_e_aplicar_volume_inicial()
	
	player.stream = preload("res://Sounds and Music/851360__josefpres__piano-loops-207-octave-long-loop-120-bpm_[cut_16sec].mp3")
	player.bus = "Musica"
	if not player.playing:
		player.play()

func carregar_e_aplicar_volume_inicial():
	var err = config.load("user://settings.cfg")
	var v = -10
	if err == OK:
		v = config.get_value("audio", "music_volume", -10)
	
	if bus_index != -1:
		AudioServer.set_bus_volume_db(bus_index, v)

func atualizar_volume(novo_valor: float):
	if bus_index != -1:
		AudioServer.set_bus_volume_db(bus_index, novo_valor)

	config.set_value("audio", "music_volume", novo_valor)
	config.save("user://settings.cfg")

func obter_volume_salvo() -> float:
	config.load("user://settings.cfg")
	return config.get_value("audio", "music_volume", -10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
