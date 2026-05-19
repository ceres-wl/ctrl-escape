class_name File
extends Node

# Classe que representa um arquivo

# Não vai ter como diferenciar extensão, pelo menos por enquanto
var file_name;

var content = ""; # Só texto?

func _init(name_: String):
	file_name = name_;

func strip_bbcode(text):
	# https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#stripping-bbcode-tags
	var regex = RegEx.new();
	regex.compile("\\[.*?\\]");
	return regex.sub(text, "", true);

func append_content(content_: String):
	content+=strip_bbcode(content_);
	print(content);

func set_content(content_: String):
	content=strip_bbcode(content_);
	print(content);
