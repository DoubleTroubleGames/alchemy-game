extends Control

const MARGIN = 20

signal setted_up

func get_title():
	return $Title.text

func setup(_title, _text):
	modulate = Color(1,1,1,0)
	$Title.rect_size.x = TooltipLayer.get_width() - 2*MARGIN
	$Title.text = _title
	$Text.bbcode_text = _text
	update_size()

func update_size():
	$BG.rect_size.x = TooltipLayer.get_width()
	
	#Need to wait a frame so get_content_height gets the apropriate size
	#and title rect has increased in size to accomodate new text
	yield(TooltipLayer.get_tree(),"idle_frame")
	
	var text_h = $Text.get_content_height()
	$BG.rect_size.y = $Text.rect_position.y + text_h + MARGIN
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), .2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	
	#Update title size to fit textbox
	var scale = (TooltipLayer.get_width() - 2*MARGIN)/$Title.rect_size.x
	$Title.rect_scale = Vector2(scale,scale)
	emit_signal("setted_up")

func get_width():
	return $BG.rect_size.x

func get_height():
	return $BG.rect_size.y
