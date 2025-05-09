extends Node

@export var file_path: String

var statements: Array[String]

func _ready():
	$ScriptParser.open_file(file_path)
	var lines = $ScriptParser.get_all_lines()
	for line in lines:
		statements.append(line[0])
