extends Control

const PRACTICE_LOG_PATH = "user://practice_log.json"

@onready var list = $MarginContainer/VBoxContainer/ItemList_Practices
@onready var button_back = $MarginContainer/VBoxContainer/Button_Back

func _ready():
	load_history()
	button_back.pressed.connect(_on_Back_pressed)

func load_history():
	list.clear()

	if not FileAccess.file_exists(PRACTICE_LOG_PATH):
		list.add_item("No practice history yet.")
		return

	var file = FileAccess.open(PRACTICE_LOG_PATH, FileAccess.READ)
	var text = file.get_as_text()
	var parsed = JSON.parse_string(text)

	if parsed is Array:
		for entry in parsed:
			var time = entry["Timestamp"]
			var scale = entry["Scale Name"]
			list.add_item("%s - %s" % [time, scale])
	else:
		list.add_item("Could not parse practice log.")

func _on_Back_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")
	print("Back to Main Window.")
