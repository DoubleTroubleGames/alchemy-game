extends Character

signal acted

onready var animation = $Sprite/AnimationPlayer
onready var health_bar = $HealthBar
onready var intent = $Intent
onready var intent_animation = $Intent/AnimationPlayer
onready var sprite = $Sprite

const HEALTH_BAR_MARGIN = 10
const INTENT_MARGIN = 10
const INTENT_W = 60
const INTENT_H = 70
const INTENTS = {"attack": preload("res://assets/images/enemies/intents/attack.png"),
				 "defend": preload("res://assets/images/enemies/intents/defense.png"),
				 "random": preload("res://assets/images/enemies/intents/random.png"),
				}

var logic_


func act():
	var state = logic_.get_current_state()
	print("Going to "+state+"!")
	animation.play("attack")
	yield(animation, "animation_finished")
	animation.play("idle")
	emit_signal("acted")
	logic_.update_state()
	
	update_intent()


func setup(enemy_logic, new_texture):
	set_logic(enemy_logic)
	set_max_hp()
	set_image(new_texture)


func set_logic(enemy_logic):
	logic_ = load("res://game/enemies/EnemyLogic.gd").new()
	
	for state in enemy_logic.states:
		logic_.add_state(state)
	for link in enemy_logic.connections:
		logic_.add_connection(link[0], link[1], link[2])
	
	#Get random first state
	randomize()
	enemy_logic.first_state.shuffle()
	logic_.set_state(enemy_logic.first_state.front())


func set_max_hp():
	health_bar.max_value = max_hp
	health_bar.value = max_hp


func set_image(new_texture):
	sprite.texture = new_texture
	var w = new_texture.get_width()
	var h = new_texture.get_height()
	health_bar.rect_position.x = w/2 - health_bar.rect_size.x/2
	health_bar.rect_position.y = h + HEALTH_BAR_MARGIN


func set_intent(intent):
	assert(INTENTS.has(intent))
	
	var texture = INTENTS[intent]
	intent.texture = texture
	var tw = texture.get_width()
	var th = texture.get_height()
	
	#Fix Pivot offset
	intent.rect_pivot_offset = Vector2(tw/2.0, th/2.0)
	
	#Fix position

	intent.rect_position.x = floor(get_width()/2.0) - tw/2.0
	intent.rect_position.y = floor(-th/2.0) - INTENT_MARGIN
	
	#Fix scale
	intent.rect_scale = Vector2(INTENT_W/float(tw), INTENT_H/float(th))
	
	#Random position for idle animation
	randomize()
	intent_animation.seek(rand_range(0,1.5))


func update_intent():
	var state = logic_.get_current_state()
	set_intent(state)


func get_width():
	return sprite.texture.get_width()


func get_height():
	return sprite.texture.get_height()
