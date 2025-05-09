extends Control

@export var displayer_id: String = ""
@export var normal_font_size: int = 40
@export var font_color: Color = Color.WHITE
@export var background_color: Color = Color.BLACK

var scripts: Array[Node]
var script_index = 0
var scripts_num = 0
var is_active = false
var statements_list: Array[String]
var statements_list_index = 0
var statements_list_num = 0


func _ready() -> void:
	$BackgroundLayer/CanvasModulate.color = background_color
	$TextLayer/CanvasModulate.color = Color.WHITE
	$TextLayer/RichTextLabel.add_theme_font_size_override("bold_font_size", normal_font_size)
	$TextLayer/RichTextLabel.add_theme_font_size_override("bold_italics_font_size", normal_font_size)
	$TextLayer/RichTextLabel.add_theme_font_size_override("italics_font_size", normal_font_size)
	$TextLayer/RichTextLabel.add_theme_font_size_override("mono_font_size", normal_font_size)
	$TextLayer/RichTextLabel.add_theme_font_size_override("normal_font_size", normal_font_size)
	$TextLayer/RichTextLabel.add_theme_color_override("default_color", font_color)
	
	scripts = $Scripts.get_children()
	scripts_num = len(scripts)
	print("已加载 ", scripts_num," 个剧本")
	
	$BackgroundLayer/ColorRect.size = size
	$TextLayer/RichTextLabel.size = size
	$BackgroundLayer/ColorRect.position = position
	$TextLayer/RichTextLabel.position = position


func _unhandled_input(event):
	if Input.is_action_pressed("ui_accept"):
		if not is_active:
			print("当前无播放剧本")
			if script_index >= scripts_num:
				print("无剩余剧本")
				return
			add_script(script_index)
		else:
			print("当前正在播放剧本：", script_index)
			print("尝试播放剧本中的下一段对话")
			_display_next_statements()


func _display_next_statements():
	if statements_list_index >= statements_list_num:
		is_active = false
		script_index += 1
		print("当前剧本播放结束...")
		return
	var statements = statements_list[statements_list_index]
	print("播放对话：", statements_list_index)
	
	# 当对话切换成功时，使对话列表索引增加
	# 但是对话切换次数永远比对话数量少一次，因此最后总是需要添加一个空对话
	if _text_transition(statements):
		statements_list_index += 1


var tween
var current_text = ""
func _text_transition(next_text: String=""):
	var time = len(next_text) * 0.1
	var text_label = $TextLayer/RichTextLabel
	if tween and tween.is_running():
		tween.kill()
		text_label.text = current_text
		text_label.visible_ratio = 1.0
		return false
	tween = create_tween()
	tween.tween_property(text_label, "visible_ratio", 0.0, 0)
	tween.tween_property(text_label, "text", next_text, 0)
	tween.tween_property(text_label, "visible_ratio", 1.0, time)
	current_text = next_text
	return true


func add_script(script_index: int=0):
	statements_list = scripts[script_index].statements  # 语句列表来源于 Scripts 子结点中的 statements 成员
	statements_list_num = len(statements_list)
	statements_list_index = 0
	is_active = true
