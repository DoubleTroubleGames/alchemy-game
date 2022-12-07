extends EnemyData

var scene_path = "res://game/enemies/enemy-scenes/BabyCarapaPlus.tscn"
var image = "res://assets/images/enemies/small regular enemy plus/idle.png"
var name = "EN_BABY_CARAPA_PLUS"
var sfx = "carapa"
var use_idle_sfx = false
var hp = {
	"easy": 38,
	"normal": 45,
	"hard": 60,
}
var battle_init = false
var size = "small"
var change_phase = null
var unique_bgm = null

var states = {
	"normal": ["attack"],
	"hard": ["attack"],
}

var connections = {
	"normal":[
		["attack", "attack", 1],
	],
	"hard":[
		["attack", "attack", 1],
	],
} 

var first_state = {
	"normal": ["attack"],
	"hard": ["attack"],
}

var actions = {
	"normal": {
		"attack": [
			{"name": "damage", "value": [8,15], "type": "regular", "animation": "atk2"}
		]
	},
	"hard": {
		"attack": [
			{"name": "damage", "value": [13,18], "type": "regular", "animation": "atk2"}
		]
	},
} 


func _init():
	idle_anim_name = "stand"
	death_anim_name = "death"
	dmg_anim_name = "dmg"
	entry_anim_name = "enter"
	variant_idles = ["idle", "idle2"]
