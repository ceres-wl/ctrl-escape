extends Node

# Maior parte desse código vem daqui:
# https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html

func _ready():
	# só pra testes
	#clear_save();
	pass

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		if !node.has_method("save"):
			push_warning("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		
		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		
		save_file.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return;

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ);
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line();

		# Creates the helper class to interact with JSON.
		var json = JSON.new();

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string);
		if not parse_result == OK:
			push_error("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line());
			continue;

		# Get the data from the JSON object.
		var node_data = json.data;
		var path = node_data.get("path")
		
		# Se o dado salvo não conter um "path, pular
		# O caso de não ter nada salvo sempre vai cair aqui tbm, acho
		if(!path):
			push_error("unknown persistent node doesn't have the necessary 'path' property, skipping...")
			continue;
		
		var node = get_node(path);
		if(!node):
			# Não precisa dessa linha pq o get_node já printa o erro
			#push_error("node in path '%s' was not found" % path);
			continue;
		if(!node.has_method("load_self")):
			push_error("persistent node '%s' is missing a load_self() function, skipped" % node.name);
			continue;
		node.call("load_self", node_data);

func has_save() -> bool:
	return FileAccess.file_exists("user://savegame.save")

func clear_save():
	DirAccess.remove_absolute("user://savegame.save");
