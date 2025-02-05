extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/Carapa.tscn"
var image = "res://assets/images/enemies/regular enemy/idle.png"
var name = "EN_CARAPA"
var sfx = "carapa"
var use_idle_sfx = false
var hp = {
	"easy": 30,
	"normal": 38,
	"hard": 48,
}
var battle_init = false
var size = "medium"
var change_phase = null
var unique_bgm = null

var states = {
	"easy": ["attack", "defend"],
	"normal": ["attack", "defend"],
	"hard": ["attack", "defend"],
}

var connections = {
	"easy": [
		["attack", "defend", 5],
		["attack", "attack", 5],
		["defend", "attack", 1],
	],
	"normal": [
		["attack", "defend", 5],
		["attack", "attack", 5],
		["defend", "attack", 1],
	],
	"hard": [
		["attack", "defend", 5],
		["attack", "attack", 5],
		["defend", "attack", 1],
	],
}

var first_state = {
	"easy": ["attack", "defend"],
	"normal": ["attack", "defend"],
	"hard": ["attack", "defend"],
}

var actions = {
	"easy": {
		"attack": [
			{"name": "damage", "value": [8, 12], "type": "regular", "animation": "atk2"}
		],
		"defend": [
			{"name": "shield", "value": [2, 3], "animation": "defense"},
			{"name": "damage", "value": [3, 5], "type": "regular", "animation": "atk"}
		],
	},
	"normal": {
		"attack": [
			{"name": "damage", "value": [10, 15], "type": "regular", "animation": "atk2"}
		],
		"defend": [
			{"name": "shield", "value": [4, 6], "animation": "defense"},
			{"name": "damage", "value": [5, 7], "type": "regular", "animation": "atk"}
		],
	},
	"hard": {
		"attack": [
			{"name": "damage", "value": [14, 18], "type": "regular", "animation": "atk2"}
		],
		"defend": [
			{"name": "shield", "value": [5, 9], "animation": "defense"},
			{"name": "damage", "value": [6, 12], "type": "regular", "animation": "atk"}
		],
	},
}


func _init():
	idle_anim_name = "stand"
	death_anim_name = "death"
	dmg_anim_name = "dmg"
	entry_anim_name = "enter"
	variant_idles = ["idle", "idle2"]
