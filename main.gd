extends Control

var current_score := 0
var busy := false
@onready var score_label: Label = %Score
@onready var status_label: Label = %Status
@onready var add_button: Button = %AddPoints
@onready var ai_button: Button = %GenerateQuest


func _ready() -> void:
	if not OS.has_feature("web"):
		Prototir.mock_ai_handler = func(_prompt: String, _max_tokens: int) -> String:
			return "Editor mock: explore the signal hidden beyond the next door."
	Prototir.ready()
	var request := Prototir.storage_get("example.score")
	request.completed.connect(_on_score_loaded)
	request.failed.connect(_on_request_failed.bind("Storage"))


func _on_add_points_pressed() -> void:
	current_score += 10
	_update_score()
	Prototir.score(current_score)
	Prototir.event("points_added", {"amount": 10, "score": current_score})
	var request := Prototir.storage_set("example.score", str(current_score))
	request.completed.connect(func(_value): status_label.text = "Saved score %d" % current_score)
	request.failed.connect(_on_request_failed.bind("Storage"))


func _on_generate_quest_pressed() -> void:
	_set_busy(true)
	status_label.text = "Generating…"
	var request := Prototir.ai_generate(
		"Write one short, family-friendly quest hook for a tiny adventure game.",
		60
	)
	request.completed.connect(_on_quest_generated)
	request.failed.connect(_on_ai_failed)


func _on_score_loaded(value) -> void:
	if value != null:
		current_score = int(value)
	_update_score()
	status_label.text = "Ready · restored score %d" % current_score


func _on_quest_generated(text) -> void:
	status_label.text = str(text)
	Prototir.event("quest_generated")
	_set_busy(false)


func _on_ai_failed(code: String, message: String) -> void:
	status_label.text = "AI unavailable (%s): %s" % [code, message]
	_set_busy(false)


func _on_request_failed(code: String, message: String, label: String) -> void:
	status_label.text = "%s unavailable (%s): %s" % [label, code, message]


func _set_busy(value: bool) -> void:
	busy = value
	add_button.disabled = value
	ai_button.disabled = value


func _update_score() -> void:
	score_label.text = str(current_score)
