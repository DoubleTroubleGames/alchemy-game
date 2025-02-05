extends Control

onready var middle_container = $MarginContainer/VBoxContainer/HBoxContainer/Middle
onready var right_container = $MarginContainer/VBoxContainer/HBoxContainer/Right
onready var description = $MarginContainer/VBoxContainer/Description
onready var grid = $MarginContainer/VBoxContainer/HBoxContainer/Left/GridContainer
onready var title = $MarginContainer/VBoxContainer/TitleContainer/Title
onready var reagent_list = $MarginContainer/VBoxContainer/HBoxContainer/Right/ReagentList
onready var left_column = $MarginContainer/VBoxContainer/HBoxContainer/Right/ReagentList/LeftColumn
onready var right_column = $MarginContainer/VBoxContainer/HBoxContainer/Right/ReagentList/RightColumn
onready var icon = $Icon
onready var tooltip = $MarginContainer/VBoxContainer/Description/TooltipCollision

const REAGENT = preload("res://game/recipe-book/ReagentDisplay.tscn")
const REAGENT_SIZE = 50
const MASTERED_TEXTURE = preload("res://assets/images/ui/book/mastered_recipe_page.png")
const REAGENT_AMOUNT = preload("res://game/ui/ReagentAmountBig.tscn")
const MAX_REAGENT_COLUMN = 4
const MAX_TITLE_FONT_SIZE = 50

var combination : Combination
var mastery_unlocked = false
var tooltip_enabled = false
var block_tooltips = false

func _ready():
	var font = title.get("custom_fonts/font").duplicate(true)
	title.set("custom_fonts/font", font)


func update_title_size():
	var font = title.get("custom_fonts/font")
	font.set("size", MAX_TITLE_FONT_SIZE)
	var font_size = MAX_TITLE_FONT_SIZE
	while title.get_visible_line_count() < title.get_line_count():
		font_size = font_size-4
		font.set("size", font_size)
		

func set_combination(_combination: Combination):
	combination = _combination
	icon.texture = combination.recipe.fav_icon
	title.text = combination.recipe.name
	update_title_size()
	description.text = RecipeManager.get_description(combination.recipe)
	grid.columns = combination.grid_size
	
	for i in range(combination.grid_size):
		for j in range(combination.grid_size):
			var reagent = REAGENT.instance()
			reagent.rect_min_size = Vector2(REAGENT_SIZE, REAGENT_SIZE)
			reagent.set_mode("grid")
			grid.add_child(reagent)
			reagent.set_reagent(combination.known_matrix[i][j])
	
	if combination.discovered:
		right_container.queue_free()
		middle_container.queue_free()
	else:
		var columns := [left_column, right_column]
		var i := 0
		for reagent in combination.reagent_amounts:
			var reagent_amount = REAGENT_AMOUNT.instance()
# warning-ignore:integer_division
			columns[i / MAX_REAGENT_COLUMN].add_child(reagent_amount)
			reagent_amount.set_reagent(reagent)
			reagent_amount.set_amount(combination.reagent_amounts[reagent])
			i += 1


func update_combination():
	for i in range(combination.grid_size):
		for j in range(combination.grid_size):
			var reagent = grid.get_child(i*combination.grid_size + j)
			reagent.set_reagent(combination.known_matrix[i][j])
	
	if combination.discovered:
		if right_container and is_instance_valid(right_container):
			right_container.queue_free()
		if middle_container and is_instance_valid(middle_container):
			middle_container.queue_free()


func master_combination():
	title.text = tr(combination.recipe.name) + "+"
	update_title_size()
	description.text = RecipeManager.get_description(combination.recipe, true)
	$BG.texture = MASTERED_TEXTURE
	mastery_unlocked = true

func enable_tooltips():
	block_tooltips = false
	for reagent in grid.get_children():
		reagent.enable_tooltips()
	if left_column and is_instance_valid(left_column):
		for reagent in left_column.get_children():
			reagent.enable_tooltips()
	if right_column and is_instance_valid(right_column):
		for reagent in right_column.get_children():
			reagent.enable_tooltips()


func disable_tooltips():
	block_tooltips = true
	for reagent in grid.get_children():
		reagent.disable_tooltips()
	if left_column and is_instance_valid(left_column):
		for reagent in left_column.get_children():
			reagent.disable_tooltips()
	if right_column and is_instance_valid(right_column):
		for reagent in right_column.get_children():
			reagent.disable_tooltips()
	remove_tooltips()

func remove_tooltips():
	if tooltip_enabled:
		tooltip_enabled = false
		TooltipLayer.clean_tooltips()


func _on_TooltipCollision_enable_tooltip():
	if block_tooltips or not combination:
		return
	
	tooltip_enabled = true
	var tip = RecipeManager.get_tooltip(combination.recipe, mastery_unlocked)
	TooltipLayer.add_tooltip(tooltip.get_position(), tip.title, \
							 tip.text, tip.title_image, tip.subtitle, true)


func _on_TooltipCollision_disable_tooltip():
	if tooltip_enabled:
		remove_tooltips()
