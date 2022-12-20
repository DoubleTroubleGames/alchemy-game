extends Control

signal closed
signal combination_studied

const RECIPE = preload("res://game/rest/RestRecipe.tscn")
const REST_HEAL_PERCENTAGE = 35
const GREAT_REST_HEAL_PERCENTAGE = 70
const FULL_REST_HEAL_PERCENTAGE = 100
const SEASONAL_MOD = {
	"halloween": {
		"green_color": "green",
		"purple_color": "purple",
		"fuchsia_color": "fuchsia",
		"regular_color": "black",
		"cant_rest_color": "#870900",
	},
	"eoy_holidays": {
		"green_color": "yellow",
		"purple_color": "purple",
		"fuchsia_color": "purple",
		"regular_color": "#c1feffff",
		"cant_rest_color": "#870900",
	},
}

onready var warning = $Warning
onready var warning_label = $Warning/Label
onready var heal_button_label = $ButtonContainer/HealButton/Text
onready var hint_button_label = $ButtonContainer/HintButton/Text
onready var recipes_container = $Panel/Recipes/HBox

var map_node : MapNode
var player
var combinations
var state = "main"
var disable_heal_text = false
var green_color = "green"
var purple_color = "purple"
var fuchsia_color = "fuchsia"
var regular_color = "black"
var cant_rest_color = "#870900"

func _ready():
	if Debug.seasonal_event:
		set_seasonal_look(Debug.seasonal_event)


func setup(node, _player, _combinations):
	state = "main"
	map_node = node
	player = _player
	combinations = _combinations
	
	update_heal_button()
	
	hint_button_label.bbcode_text = tr("DISCOVER_RECIPE")%[purple_color]
	
	$Warning.modulate.a = 0
	$BackButton.show()
	$ButtonContainer/HealButton.show()
	$ButtonContainer/HintButton.show()
	$Panel.hide()
	$ContinueButton.hide()


func set_seasonal_look(event_string):
	regular_color = SEASONAL_MOD[event_string].regular_color
	green_color = SEASONAL_MOD[event_string].green_color
	purple_color = SEASONAL_MOD[event_string].purple_color
	fuchsia_color = SEASONAL_MOD[event_string].fuchsia_color
	cant_rest_color = SEASONAL_MOD[event_string].cant_rest_color
	
	for node in [heal_button_label, hint_button_label]:
		node.add_color_override("default_color", regular_color)


func get_percent_heal_color():
	if player.has_artifact("full_rest"):
		return fuchsia_color
	elif player.has_artifact("great_rest"):
		return green_color
	else:
		return regular_color


func get_percent_heal():
	if player.has_artifact("full_rest"):
		return FULL_REST_HEAL_PERCENTAGE
	elif player.has_artifact("great_rest"):
		return GREAT_REST_HEAL_PERCENTAGE
	else:
		return REST_HEAL_PERCENTAGE


func get_heal_value():
	if player.has_artifact("full_rest"):
		return player.max_hp
	elif player.has_artifact("great_rest"):
		return GREAT_REST_HEAL_PERCENTAGE/100.0 * player.max_hp
	else:
		return REST_HEAL_PERCENTAGE/100.0 * player.max_hp


func update_heal_button():
	var button = $ButtonContainer/HealButton
	if player.has_artifact("cursed_scholar_mask"):
		heal_button_label.bbcode_text = "[center][color="+cant_rest_color+"]"+tr("CANT_HEAL")+"[/color][/center]"
		disable_heal_text = "CANT_HEAL_SCHOLAR_MASK"
	else:
		disable_heal_text = false
		button.modulate.r = 1.0; button.modulate.g = 1.0; button.modulate.b = 1.0
		heal_button_label.bbcode_text = tr("HEAL_TEXT") % \
				[purple_color, green_color, get_heal_value(), get_percent_heal_color(), get_percent_heal()] 


func reset_room():
	if map_node:
		map_node.set_type(MapNode.EMPTY)


func reset_recipes():
	for child in recipes_container.get_children():
		recipes_container.remove_child(child)


func setup_recipes():
	reset_recipes()
	
	for combination in combinations:
		create_display(combination)


func create_display(combination):
	var recipe_display = RECIPE.instance()
	recipes_container.add_child(recipe_display)
	recipe_display.set_combination(combination)
	recipe_display.enable_tooltips()
	recipe_display.connect("chosen", self, "_on_recipe_chosen")


func _on_HealButton_pressed():
	if disable_heal_text:
		AudioManager.play_sfx("error")
		warning_label.text = tr(disable_heal_text)
		var tween = $Warning/WarningTween
		var cur_a = warning.modulate.a
		tween.stop_all()
		tween.interpolate_property(warning, "modulate:a", cur_a, 1, (1-cur_a)*.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		tween.interpolate_property(warning, "modulate:a", 1, 0, .3, Tween.TRANS_CUBIC, Tween.EASE_IN, 4.6)
		tween.start()
	else:
		AudioManager.play_sfx("heal")
		player.hp = min(player.hp + get_heal_value(), player.max_hp)
		reset_room()
		emit_signal("closed")


func _on_HintButton_pressed():
	if combinations.size() > 0:
		$ChooseOneLabel.hide()
		$ButtonContainer/HealButton.hide()
		$ButtonContainer/HintButton.hide()
		$Panel.show()
		setup_recipes()
		state = "recipes"
	else:
		AudioManager.play_sfx("error")


func _on_ContinueButton_pressed():
	reset_room()
	for recipe in recipes_container.get_children():
		recipe.disable_tooltips()
	emit_signal("closed")


func _on_BackButton_pressed():
	if state == "recipes":
		$ChooseOneLabel.show()
		$ButtonContainer/HealButton.show()
		$ButtonContainer/HintButton.show()
		$Panel.hide()
		reset_recipes()
		state = "main"
	else:
		emit_signal("closed")


func _on_recipe_chosen(chosen_recipe):
	for recipe_display in recipes_container.get_children():
		if recipe_display != chosen_recipe:
			recipes_container.remove_child(recipe_display)

	emit_signal("combination_studied", chosen_recipe.combination)
	$ContinueButton.show()
	$BackButton.hide()


func _on_button_mouse_entered():
	AudioManager.play_sfx("hover_button")
