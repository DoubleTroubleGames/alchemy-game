extends Node2D
class_name MapLine

signal filled


const LIGHT_TEX = preload("res://assets/images/map/light_tex.png")
const BALL_COLOR = Color.black
const BALL_DIST = 30
const BALL_SIZE = Vector2(10, 10)
const MAP_NODE_SIZE = 64
const PATH_FILL_TIME = 1.8
const WAIT_TIMER = .1
const PATH_FILL_TIME_TURBO = .5
const WAIT_TIMER_TURBO = 0.05
const IMAGES = [preload("res://assets/images/map/path-map-1.png"),
	preload("res://assets/images/map/path-map-2.png"),
	preload("res://assets/images/map/path-map-3.png")]

var ball_amount : int
var ball_count : int
var balls := []
var line_vector : Vector2
var time := 0.0
var floor_level :int


func _ready():
	set_process(false)


func _process(delta):
	time += delta
	update()
	var fill_time
	var wait_time
	if Profile.get_option("turbo_mode"):
		fill_time = PATH_FILL_TIME_TURBO
		wait_time = WAIT_TIMER_TURBO
	else:
		fill_time = PATH_FILL_TIME
		wait_time = WAIT_TIMER
	if time >= fill_time:
		set_process(false)
		yield(get_tree().create_timer(wait_time), "timeout")
		emit_signal("filled")


func _draw():
	var fill_time
	if Profile.get_option("turbo_mode"):
		fill_time = PATH_FILL_TIME_TURBO
	else:
		fill_time = PATH_FILL_TIME
	for i in ball_amount:
		var pos := line_vector.clamped(i * BALL_DIST)
		var radius_multiplier = ball_amount * time / fill_time - i
		radius_multiplier = clamp(radius_multiplier, 0, 1)
		var size = BALL_SIZE * radius_multiplier
		draw_texture_rect(balls[i], Rect2(pos - size / 2, size), false)


func begin_fill():
	var fill_time
	if Profile.get_option("turbo_mode"):
		fill_time = PATH_FILL_TIME_TURBO
	else:
		fill_time = PATH_FILL_TIME
	set_process(true)
	ball_count = 0
	$Tween.interpolate_method(self, "play_sfx", 0, ball_amount, fill_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func play_sfx(value):
	if value >= ball_count + 1:
		ball_count += 1
		if floor_level >= 1 and floor_level <= 3 and randf() > 0.1:
			AudioManager.play_sfx("map_points_appear"+str(floor_level), false, -(ball_count-1)*3.0)


func set_line(origin:Vector2, target:Vector2, current_level:int):
	var dist := origin.distance_to(target) - MAP_NODE_SIZE
	floor_level = current_level
	line_vector = target - origin
	ball_amount = int(dist / BALL_DIST) + 1
	dist -= (ball_amount - 1) * BALL_DIST
	position = origin + line_vector.clamped((MAP_NODE_SIZE + dist) / 2)
	randomize()
	for i in ball_amount:
		balls.append(IMAGES[randi() % IMAGES.size()])
#		var light = Light2D.new()
#		light.texture = LIGHT_TEX
#		light.mode = Light2D.MODE_MIX
#		light.texture_scale = rand_range(.5, .8)
#		light.rotation = rand_range(0, 360)
#		light.position = line_vector.clamped(i * BALL_DIST)
#		light.energy = 0
#		light.range_item_cull_mask = 16 #bit 4
#		$Lights.add_child(light)
#		light.enabled = not Profile.get_option("disable_map_fog")


func enable_lights():
	for light in $Lights.get_children():
		light.enabled = true


func disable_lights():
	for light in $Lights.get_children():
		light.enabled = true
