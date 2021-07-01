extends Label

signal animation_finished

export var unit := " EP"
export var base_duration := .05
export var color := Color.rebeccapurple

var amount := 0

func _ready():
	text = "0" + unit
	set("custom_colors/font_color", color)


func animate():
	var t = Tween.new()
	add_child(t)
	t.interpolate_method(self, "change_text_value", 0, amount, base_duration * amount)
	t.start()
	yield(t, "tween_completed")
	emit_signal("animation_finished")
	t.queue_free()


func change_text_value(value: int = -1):
	if value != -1:
		text = str(value) + unit
		return
	
	# Gambiarra for setting the label's size to the maximum amount will occupy
	var string = ""
	for i in amount % 10:
		string += "W"
	text = string + unit


func _on_EP_resized():
	rect_min_size.x = max(rect_min_size.x, rect_size.x)
