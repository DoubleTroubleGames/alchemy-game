extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/Rager.tscn"
var image = "res://assets/images/enemies/rager/idle.png"
var name = "EN_RAGER"
var sfx = "rager"
var use_idle_sfx = false
var hp = {
	"easy": 85,
	"normal": 100,
	"hard": 120,
}
var battle_init = true
var size = "medium"
var change_phase = null
var unique_bgm = null

var states = {
	"easy": ["init", "attack1", "attack2", "attack3"],
	"normal": ["init", "attack1", "attack2", "attack3"],
	"hard": ["init", "attack1", "attack2", "attack3"],
}

var connections = {
	"easy": [
		["init", "attack1", 1],
		["attack1", "attack2", 1],
		["attack2", "attack3", 1],
		["attack3", "attack1", 1],
	],
	"normal": [
		["init", "attack1", 1],
		["attack1", "attack2", 1],
		["attack2", "attack3", 1],
		["attack3", "attack1", 1],
	],
	"hard": [
		["init", "attack1", 1],
		["attack1", "attack2", 1],
		["attack2", "attack3", 1],
		["attack3", "attack1", 1],
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
			{"name": "status", "status_name": "enrage", "value": 3, "target": "self", "positive": true, "animation": "02_atk"}
		],
		"attack1": [
			{"name": "damage", "value": [4, 8], "type": "regular", "animation": "02_atk"}
		],
		"attack2": [
			{"name": "damage", "value": [4, 8], "type": "regular", "animation": "02_atk"}
		],
		"attack3": [
			{"name": "damage", "value": 1, "amount": 3, "type": "regular", "animation": "02_atk"}
		],
	},
	"normal": {
		"init": [
			{"name": "status", "status_name": "enrage", "value": 4, "target": "self", "positive": true, "animation": "02_atk"}
		],
		"attack1": [
			{"name": "damage", "value": [4, 9], "type": "regular", "animation": "02_atk"}
		],
		"attack2": [
			{"name": "damage", "value": [4, 9], "type": "regular", "animation": "02_atk"}
		],
		"attack3": [
			{"name": "damage", "value": 1, "amount": 3, "type": "regular", "animation": "02_atk"}
		],
	},
	"hard": {
		"init": [
			{"name": "status", "status_name": "enrage", "value": 8, "target": "self", "positive": true, "animation": "02_atk"}
		],
		"attack1": [
			{"name": "damage", "value": [7, 9], "type": "regular", "animation": "02_atk"}
		],
		"attack2": [
			{"name": "damage", "value": [7, 9], "type": "regular", "animation": "02_atk"}
		],
		"attack3": [
			{"name": "damage", "value": 2, "amount": 3, "type": "regular", "animation": "02_atk"}
		],
	},
}


func _init():
	idle_anim_name = "01_idle"
	death_anim_name = "04_death"
	dmg_anim_name = "03_dmg"
