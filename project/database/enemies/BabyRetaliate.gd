extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/BabyRetaliate.tscn"
var image = "res://assets/images/enemies/baby retaliate/idle.png"
var name = "EN_BABY_RETALIATE"
var sfx = "virulyn-prickler"
var use_idle_sfx = false
var hp = {
	"normal": 42,
	"hard": 65,
}
var battle_init = true
var size = "small"
var change_phase = null
var unique_bgm = null

var states = {
	"normal": ["init", "attack", "bigattack", "bigbuff"],
	"hard": ["init", "attack", "bigattack", "bigbuff"],
}

var connections = {
	"normal": [
		["init", "attack", 1],
		["attack", "attack", 3],
		["attack", "bigattack", 1],
		["attack", "bigbuff", 1],
		["bigbuff", "attack", 2],
		["bigbuff", "bigattack", 1],
		["bigattack", "attack", 2],
		["bigattack", "bigbuff", 1],
	],
	"hard": [
		["init", "attack", 1],
		["attack", "attack", 3],
		["attack", "bigattack", 1],
		["attack", "bigbuff", 1],
		["bigbuff", "attack", 2],
		["bigbuff", "bigattack", 1],
		["bigattack", "attack", 2],
		["bigattack", "bigbuff", 1],
	],
}

var first_state = {
	"normal": ["init"],
	"hard": ["init"],
}

var actions = {
	"normal": {
		"init": [
			{"name": "status", "status_name": "retaliate", "value": 5, "target": "self", "positive": true, "animation": "03_dmg"},
		],
		"attack": [
			{"name": "status", "status_name": "retaliate", "value": 5, "target": "self", "positive": true, "animation": "03_dmg"},
			{"name": "damage", "value": [6,10], "type": "regular", "animation": "02_atk"}
		],
		"bigattack": [
			{"name": "damage", "value": [9,15], "type": "regular", "animation": "02_atk"}
		],
		"bigbuff": [
			{"name": "status", "status_name": "retaliate", "value": 15, "target": "self", "positive": true, "animation": "03_dmg"},
		]
	},
	"hard": {
		"init": [
			{"name": "status", "status_name": "retaliate", "value": 10, "target": "self", "positive": true, "animation": "03_dmg"},
		],
		"attack": [
			{"name": "status", "status_name": "retaliate", "value": 5, "target": "self", "positive": true, "animation": "03_dmg"},
			{"name": "damage", "value": [6,10], "type": "regular", "animation": "02_atk"}
		],
		"bigattack": [
			{"name": "damage", "value": [9,15], "type": "regular", "animation": "02_atk"}
		],
		"bigbuff": [
			{"name": "status", "status_name": "retaliate", "value": 15, "target": "self", "positive": true, "animation": "03_dmg"},
		]
	},
}


func _init():
	idle_anim_name = "01_idle"
	death_anim_name = "04_death"
	dmg_anim_name = "03_dmg"
