extends Sprite2D

var total_score = 0
var minimum_score = 0
var threshold_index = 0
var threshold_value = 0
var money_earned = 0
var extra_lines = []
var reveal_delay = 0.18
var reveal_id = 0

@onready var info_labels = [$Score, $Threshold, $MoneyEarned, $ExtraLines]

func _ready() -> void:
	hide_info_labels()

func show_round_results(
	new_total_score,
	new_minimum_score,
	new_threshold_index,
	new_money_earned,
	new_threshold_value,
	new_extra_lines = []
) -> void:
	reveal_id += 1
	total_score = new_total_score
	minimum_score = new_minimum_score
	threshold_index = new_threshold_index
	money_earned = new_money_earned
	threshold_value = new_threshold_value
	extra_lines = new_extra_lines
	update_text()
	hide_info_labels()
	visible = true
	await reveal_info_labels(reveal_id)

func hide_sign() -> void:
	reveal_id += 1
	visible = false
	hide_info_labels()

func update_text() -> void:
	$Score.text = "Score: " + Lib.num_to_string(total_score) + " / " + Lib.num_to_string(minimum_score)
	$Threshold.text = "Threshold: x" + Lib.num_to_string(threshold_value) + " (Tier " + str(threshold_index) + ")"
	$MoneyEarned.text = "Earned: $" + Lib.num_to_string(money_earned)
	var lines = PackedStringArray()
	for line in extra_lines:
		lines.append(str(line))
	$ExtraLines.text = "\n".join(lines)

func hide_info_labels() -> void:
	for label in info_labels:
		label.visible = false

func reveal_info_labels(current_reveal_id: int) -> void:
	for label in info_labels:
		if current_reveal_id != reveal_id or !visible:
			return
		label.visible = true
		await get_tree().create_timer(reveal_delay).timeout
