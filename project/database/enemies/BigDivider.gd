extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/BigDivider.tscn"
var image = "res://assets/images/enemies/big divider/idle.png"
var name = "EN_BIG_DIVIDER"
var sfx = "divider"
var use_idle_sfx = false
var hp = {
	"easy": 60,
	"normal": 80,
	"hard": 100,
}
var battle_init = true
var size = "medium"
var change_phase = null
var unique_bgm = null

var states = {
	"easy": ["init", "attack", "defend", "poison"],
	"normal": ["init", "attack", "defend", "poison"],
	"hard": ["init", "attack", "defend", "poison"],
}

var connections = {
	"easy": [
		["init", "poison", 1],
		["attack", "poison", 1],
		["defend", "poison", 1],
		["poison", "attack", 1],
		["poison", "defend", 1],
	],
	"normal": [
		["init", "poison", 1],
		["attack", "poison", 1],
		["defend", "poison", 1],
		["poison", "attack", 1],
		["poison", "defend", 1],
	],
	"hard": [
		["init", "poison", 1],
		["attack", "poison", 1],
		["defend", "poison", 1],
		["poison", "attack", 1],
		["poison", "defend", 1],
	],
}

var first_state = {
	"easy": ["init"],
	"normal": ["init"],
	"hard": ["init"],
}

var actions = {
	"easy": {
		"init": [
			{"name": "status", "status_name": "splitting", "value": 2, "target": "self", "positive": true, "extra_args": {"enemy": "medium_divider"}, "animation": ""}
		],
		"attack": [
			{"name": "damage", "value": [20, 35], "type": "regular", "animation": "02_atk"}
		],
		"defend": [
			{"name": "shield", "value": [16, 25], "animation": ""},
			{"name": "damage", "value": [12, 27], "type": "regular", "animation": "02_atk"}
		],
		"poison": [
			{"name": "damage", "value": [17, 32], "type": "venom", "animation": "02_atk"},
		],
	},
	"normal": {
		"init": [
			{"name": "status", "status_name": "splitting", "value": 2, "target": "self", "positive": true, "extra_args": {"enemy": "medium_divider"}, "animation": ""}
		],
		"attack": [
			{"name": "damage", "value": [25, 35], "type": "regular", "animation": "02_atk"}
		],
		"defend": [
			{"name": "shield", "value": [20, 25], "animation": ""},
			{"name": "damage", "value": [17, 27], "type": "regular", "animation": "02_atk"}
		],
		"poison": [
			{"name": "damage", "value": [20, 32], "type": "venom", "animation": "02_atk"},
		],
	},
	"hard": {
		"init": [
			{"name": "status", "status_name": "splitting", "value": 2, "target": "self", "positive": true, "extra_args": {"enemy": "medium_divider"}, "animation": ""}
		],
		"attack": [
			{"name": "damage", "value": [30, 35], "type": "regular", "animation": "02_atk"}
		],
		"defend": [
			{"name": "shield", "value": [22, 25], "animation": ""},
			{"name": "damage", "value": [22, 27], "type": "regular", "animation": "02_atk"}
		],
		"poison": [
			{"name": "damage", "value": [26, 32], "type": "venom", "animation": "02_atk"},
		],
	},
}


func _init():
	idle_anim_name = "01_idle"
	death_anim_name = "04_death"
	dmg_anim_name = "03_dmg"
