extends Control

var scale_data: Array = []
var rng := RandomNumberGenerator.new()

@onready var label_scale_name = $VBoxContainer/Label_ScaleName
@onready var label_chords = $VBoxContainer/Label_Chords
@onready var label_usage = $VBoxContainer/Label_Usage
@onready var button_random = $VBoxContainer/Button_Randomize

func _ready():
	load_data()
	button_random.pressed.connect(_on_Button_pressed)

func load_data():
	var file = FileAccess.open("res://data/jazz_scales.json", FileAccess.READ)
	if file:
		var text = file.get_as_text()
		var result = JSON.parse_string(text)
		if result:
			scale_data = result
			rng.randomize()
		else:
			push_error("JSON parsing failed.")
	else:
		push_error("Failed to open data file.")

func _on_Button_pressed():
	if scale_data.is_empty():
		return

	var index = rng.randi_range(0, scale_data.size() - 1)
	var scale = scale_data[index]

	label_scale_name.text = "🎵 " + scale["Scale Name"]
	label_chords.text = "Chords: " + scale["Compatible Chords"]
	label_usage.text = "Usage: " + scale["Common Usages"]
