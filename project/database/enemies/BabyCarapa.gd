extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/BabyCarapa.tscn"
var image = "res://assets/images/enemies/small regular enemy/idle.png"
var name = "EN_BABY_CARAPA"
var sfx = "carapa"
var use_idle_sfx = false
var hp = {
	"easy": 10,
	"normal": 15,
	"hard": 25,
}
var battle_init = false
var size = "small"
var change_phase = null
var unique_bgm = null

var states = {
	"easy": ["attack"],
	"normal": ["attack"],
	"hard": ["attack"],
}

var connections = {
	"easy":[
		["attack", "attack", 1],
	],
	"normal":[
		["attack", "attack", 1],
	],
	"hard":[
		["attack", "attack", 1],
	],
}

var first_state = {
	"easy": ["attack"],
	"normal": ["attack"],
	"hard": ["attack"],
}

var actions = {
	"easy": {
		"attack": [
			{"name": "damage", "value": [3,6], "type": "regular", "animation": "atk"}
		]
	},
	"normal": {
		"attack": [
			{"name": "damage", "value": [5,7], "type": "regular", "animation": "atk"}
		]
	},
	"hard": {
		"attack": [
			{"name": "damage", "value": [7,9], "type": "regular", "animation": "atk"}
		]
	},
}


func _init():
	idle_anim_name = "stand"
	death_anim_name = "death"
	dmg_anim_name = "dmg"
	entry_anim_name = "enter"
	variant_idles = ["idle", "idle2"]
