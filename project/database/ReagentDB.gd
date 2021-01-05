class_name ReagentDB

const DB = {
	"faint": {
		"name": "Faint Elementium",
		"rarity": "Faint",
		"image": preload("res://assets/images/reagents/faint_elementium.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to a random enemy",
		"effect" : {"type": "damage", "value": 2, "upgraded_value": 2, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 1,
		"substitute" : ["common"],
		"transmutations" : ["common", "weak_damaging", "weak_defensive"],
	},
	"common": {
		"name": "Common Elementium",
		"rarity": "Common",
		"image": preload("res://assets/images/reagents/common_elementium.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to a random enemy",
		"effect" : {"type": "damage", "value": 3, "upgraded_value": 4, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 10,
		"substitute" : [],
		"transmutations" : ["uncommon"],
	},
	"uncommon": {
		"name": "Uncommon Elementium",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/uncommon_elementium.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to a random enemy",
		"effect" : {"type": "damage", "value": 5, "upgraded_value": 6, "upgraded_boost": {"type": "all", "value": 2}},
		"gold_value" : 25,
		"substitute" : ["common"],
		"transmutations" : ["rare"],
	},
	"rare": {
		"name": "Rare Elementium",
		"rarity": "Rare",
		"image": preload("res://assets/images/reagents/rare_elementium.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to a random enemy",
		"effect" : {"type": "damage", "value": 8, "upgraded_value": 10, "upgraded_boost": {"type": "all", "value": 3}},
		"gold_value" : 50,
		"substitute" : ["uncommon", "common"],
		"transmutations" : [],
	},
	"weak_damaging": {
		"name": "Black Salt",
		"rarity": "Faint",
		"image": preload("res://assets/images/reagents/black_salt.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to all enemies",
		"effect" : {"type": "damage_all", "value": 2, "upgraded_value": 2, "upgraded_boost": {"type": "damage", "value": 1}},
		"gold_value" : 1,
		"substitute" : ["damaging"],
		"transmutations" : ["damaging"],
	},
	"damaging": {
		"name": "Black Powder",
		"rarity": "Common",
		"image": preload("res://assets/images/reagents/black_powder.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to all enemies",
		"effect" : {"type": "damage_all", "value": 3, "upgraded_value": 5, "upgraded_boost": {"type": "damage", "value": 2}},
		"gold_value" : 15,
		"substitute" : [],
		"transmutations" : ["super_damaging"],
	},
	"super_damaging": {
		"name": "Black Quartz",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/black_quartz.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to all enemies",
		"effect" : {"type": "damage_all", "value": 5, "upgraded_value": 7, "upgraded_boost": {"type": "damage", "value": 3}},
		"gold_value" : 35,
		"substitute" : ["damaging"],
		"transmutations" : [],
	},
	"weak_defensive": {
		"name": "Scale Shard",
		"rarity": "Faint",
		"image": preload("res://assets/images/reagents/scale_shard.png"),
		"tooltip" : "If used in a miscombination, gives %s shield to user",
		"effect" : {"type": "shield", "value": 2, "upgraded_value": 2, "upgraded_boost": {"type": "shield", "value": 1}},
		"gold_value" : 15,
		"substitute" : ["defensive"],
		"transmutations" : ["defensive"],
	},
	"defensive": {
		"name": "Shell Shard",
		"rarity": "Common",
		"image": preload("res://assets/images/reagents/shell_shard.png"),
		"tooltip" : "If used in a miscombination, gives %s shield to user",
		"effect" : {"type": "shield", "value": 3, "upgraded_value": 5, "upgraded_boost": {"type": "shield", "value": 2}},
		"gold_value" : 15,
		"substitute" : [],
		"transmutations" : ["super_defensive"],
	},
	"super_defensive": {
		"name": "Rune Shard",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/rune_shard.png"),
		"tooltip" : "If used in a miscombination, gives %s shield to user",
		"effect" : {"type": "shield", "value": 5, "upgraded_value": 7, "upgraded_boost": {"type": "shield", "value": 3}},
		"gold_value" : 35,
		"substitute" : ["defensive"],
		"transmutations" : [],
	},
	"healing": {
		"name": "Invigorating Root",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/invigorating_root.png"),
		"tooltip" : "If used in a miscombination, heals the user %s hp",
		"effect" : {"type": "heal", "value": 1, "upgraded_value": 3, "upgraded_boost": {"type": "heal", "value": 5}},
		"gold_value" : 40,
		"substitute" : [],
		"transmutations" : [],
	},
	"poison": {
		"name": "Noxious Essence",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/noxious_essence.png"),
		"tooltip" : "If used in a miscombination, applies %s poison to a random enemy",
		"effect" : {"type": "status", "status_type": "poison", "target": "random_enemy", "positive": false, "value": 2, "upgraded_value": 4, "upgraded_boost": {"type": "status", "value": 2}},
		"gold_value" : 20,
		"substitute" : [],
		"transmutations" : [],
	},
	"buff": {
		"name": "Horn Fragment",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/horn_fragment.png"),
		"tooltip" : "If used in a miscombination, applies %s temporary strength to user",
		"effect" : {"type": "status", "status_type": "temp_strength", "target": "self", "positive": true, "value": 2, "upgraded_value": 4, "upgraded_boost": {"type": "status", "value": 2}},
		"gold_value" : 25,
		"substitute" : [],
		"transmutations" : ["debuff"],
	},
	"debuff": {
		"name": "Cracked Skull",
		"rarity": "Uncommon",
		"image": preload("res://assets/images/reagents/cracked_skull.png"),
		"tooltip" : "If used in a miscombination, applies %s weakness to a random enemy",
		"effect" : {"type": "status", "status_type": "weakness", "target": "random_enemy", "positive": false, "value": 1, "upgraded_value": 2, "upgraded_boost": {"type": "status", "value": 2}},
		"gold_value" : 25,
		"substitute" : [],
		"transmutations" : ["buff"],
	},
	"trash": {
		"name": "Putrid Beetle",
		"rarity": "Putrid",
		"image": preload("res://assets/images/reagents/putrid_beetle.png"),
		"tooltip" : "If used in a miscombination, deals %s regular damage to the user",
		"effect" : {"type": "damage_self", "value": 2, "upgraded_value": 1, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 1,
		"substitute" : [],
	}
}


static func get_types() -> Array:
	return DB.keys()

static func get_reagents() -> Dictionary:
	return DB

static func get_from_name(name: String) -> Dictionary:
	if not DB.has(name):
		push_error("Given type of reagent doesn't exist: " + str(name))
		assert(false)
	return DB[name]
