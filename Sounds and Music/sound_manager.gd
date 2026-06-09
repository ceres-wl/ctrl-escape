extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func play_sfx(path: String):
	var asp = AudioStreamPlayer.new()
	asp.stream = load(path)
	asp.finished.connect(asp.queue_free)
	if AudioServer.get_bus_index("Som") != -1:
		asp.bus = "Som"
	else:
		asp.bus = "Master"
		
	add_child(asp)
	asp.play()
	
	asp.finished.connect(asp.queue_free)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
