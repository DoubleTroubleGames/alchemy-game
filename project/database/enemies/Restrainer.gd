extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/Restrainer.tscn"
var image = "res://assets/images/enemies/restrainer/idle.png"
var name = "EN_RESTRAINER"
var sfx = "restrainer"
var use_idle_sfx = false
var hp = {
	"easy": 420,
	"normal": 450,
	"hard": 480,
}
var battle_init = false
var size = "big"
var change_phase = null
var unique_bgm = null


var states = {
	"easy": ["attack1", "attack2", "attack3", "charging", "big_restrain", "medium_restrain"],
	"normal": ["attack1", "attack2", "attack3", "charging", "big_restrain", "medium_restrain"],
	"hard": ["attack1", "attack2", "attack3", "charging", "big_restrain", "medium_restrain"],
}

var connections = {
	"easy": [   
		["attack1", "attack2", 4],
		["attack1", "attack3", 4],
		["attack1", "medium_restrain", 3],
		["attack1", "charging", 2],
		["attack2", "attack1", 4],
		["attack2", "attack3", 4],
		["attack2", "medium_restrain", 3],
		["attack2", "charging", 2],
		["attack3", "medium_restrain", 3],
		["attack3", "charging", 3],
		["attack3", "attack1", 2],
		["attack3", "attack2", 2],
		["charging", "big_restrain", 1],
		["big_restrain", "attack1", 4],
		["big_restrain", "attack2", 4],
		["big_restrain", "attack3", 2],
		["medium_restrain", "attack1", 4],
		["medium_restrain", "attack2", 4],
		["medium_restrain", "attack3", 3],
	],
	"normal": [   
		["attack1", "attack2", 4],
		["attack1", "attack3", 4],
		["attack1", "medium_restrain", 3],
		["attack1", "charging", 2],
		["attack2", "attack1", 4],
		["attack2", "attack3", 4],
		["attack2", "medium_restrain", 3],
		["attack2", "charging", 2],
		["attack3", "medium_restrain", 3],
		["attack3", "charging", 3],
		["attack3", "attack1", 2],
		["attack3", "attack2", 2],
		["charging", "big_restrain", 1],
		["big_restrain", "attack1", 4],
		["big_restrain", "attack2", 4],
		["big_restrain", "attack3", 2],
		["medium_restrain", "attack1", 4],
		["medium_restrain", "attack2", 4],
		["medium_restrain", "attack3", 3],
	],
	"hard": [   
		["attack1", "attack2", 4],
		["attack1", "attack3", 4],
		["attack1", "medium_restrain", 3],
		["attack1", "charging", 2],
		["attack2", "attack1", 4],
		["attack2", "attack3", 4],
		["attack2", "medium_restrain", 3],
		["attack2", "charging", 2],
		["attack3", "medium_restrain", 3],
		["attack3", "charging", 3],
		["attack3", "attack1", 2],
		["attack3", "attack2", 2],
		["charging", "big_restrain", 1],
		["big_restrain", "attack1", 4],
		["big_restrain", "attack2", 4],
		["big_restrain", "attack3", 2],
		["medium_restrain", "attack1", 4],
		["medium_restrain", "attack2", 4],
		["medium_restrain", "attack3", 3],
	],
}

var first_state = {
	"easy": ["attack1", "attack2"],
	"normal": ["attack1", "attack2"],
	"hard": ["attack1", "attack2"],
}

var actions = {
	"easy": {
		"attack1": [
			{"name": "status", "status_name": "restrain", "value": 5, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": [25, 40], "type": "regular", "animation": "02_atk"}
		],
		"attack2": [
			{"name": "status", "status_name": "restrain", "value": 7, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": [30, 35], "type": "regular", "animation": "02_atk"}
		],
		"attack3": [
			{"name": "damage", "value": 55, "type": "regular", "animation": "02_atk"}
		],
		"charging": [
			{"name": "idle", "sfx": "charge", "animation": ""}
		],
		"big_restrain": [
			{"name": "status", "status_name": "restrain", "value": 16, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": 12, "type": "piercing", "animation": "02_atk"},
			{"name": "status", "status_name": "perm_strength", "value": 4, "target": "self", "positive": true, "animation": ""},
		],
		"medium_restrain": [
			{"name": "status", "status_name": "restrain", "value": 14, "target": "player", "positive": false, "animation": "02_atk"},
			{"name": "status", "status_name": "temp_strength", "value": 15, "target": "self", "positive": true, "animation": ""},
		],
	},
	"normal": {
		"attack1": [
			{"name": "status", "status_name": "restrain", "value": 6, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": [25, 45], "type": "regular", "animation": "02_atk"}
		],
		"attack2": [
			{"name": "status", "status_name": "restrain", "value": 8, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": [30, 40], "type": "regular", "animation": "02_atk"}
		],
		"attack3": [
			{"name": "damage", "value": 66, "type": "regular", "animation": "02_atk"}
		],
		"charging": [
			{"name": "idle", "sfx": "charge", "animation": ""}
		],
		"big_restrain": [
			{"name": "status", "status_name": "restrain", "value": 16, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": 15, "type": "piercing", "animation": "02_atk"},
			{"name": "status", "status_name": "perm_strength", "value": 5, "target": "self", "positive": true, "animation": ""},
		],
		"medium_restrain": [
			{"name": "status", "status_name": "restrain", "value": 14, "target": "player", "positive": false, "animation": "02_atk"},
			{"name": "status", "status_name": "temp_strength", "value": 20, "target": "self", "positive": true, "animation": ""},
		],
	},
	"hard": {
		"attack1": [
			{"name": "status", "status_name": "restrain", "value": 10, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": [25, 45], "type": "regular", "animation": "02_atk"}
		],
		"attack2": [
			{"name": "status", "status_name": "restrain", "value": 12, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": [30, 40], "type": "regular", "animation": "02_atk"}
		],
		"attack3": [
			{"name": "damage", "value": 66, "type": "regular", "animation": "02_atk"}
		],
		"charging": [
			{"name": "idle", "sfx": "charge", "animation": ""}
		],
		"big_restrain": [
			{"name": "status", "status_name": "restrain", "value": 16, "target": "player", "positive": false, "animation": ""},
			{"name": "damage", "value": 20, "type": "piercing", "animation": "02_atk"},
			{"name": "status", "status_name": "perm_strength", "value": 8, "target": "self", "positive": true, "animation": ""},
		],
		"medium_restrain": [
			{"name": "status", "status_name": "restrain", "value": 14, "target": "player", "positive": false, "animation": "02_atk"},
			{"name": "status", "status_name": "temp_strength", "value": 24, "target": "self", "positive": true, "animation": ""},
		],
	},
}


func _init():
	idle_anim_name = "01_idle"
	death_anim_name = "04_death"
	dmg_anim_name = "03_dmg"
