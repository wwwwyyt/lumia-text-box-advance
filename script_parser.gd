extends Control

@export var file_path: String
var file: FileAccess


func _ready():
	open_file(file_path)


func open_file(path: String):
	file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("打开文件失败 path: ", path)
		return false
	print("打开文件成功 path: ", path)
	return true


func read_csv_line():
	return file.get_csv_line()


func get_all_lines():
	var lines: Array[PackedStringArray]
	while file.get_position() < file.get_length():
		lines.append(file.get_csv_line())
	return lines
