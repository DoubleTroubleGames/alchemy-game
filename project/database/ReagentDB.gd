class_name ReagentDB

const DB = {
	"faint": {
		"name": "RGNT_FAIN_ELEM_NAME",
		"rarity": "FAINT",
		"image": preload("res://assets/images/reagents/faint_elementium.png"),
		"tooltip_image_path": "res://assets/images/reagents/faint_elementium_borderless.png",
		"tooltip" : "RGNT_ELEM_TOOLTIP",
		"effect" : {"type": "damage", "value": 2, "upgraded_value": 2, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 5,
		"substitute" : ["common"],
		"transmutations" : ["common", "weak_damaging", "weak_defensive"],
		"rank": 1,
	},
	"common": {
		"name": "RGNT_COM_ELEM_NAME",
		"rarity": "COMMON",
		"image": preload("res://assets/images/reagents/common_elementium.png"),
		"tooltip_image_path": "res://assets/images/reagents/common_elementium_borderless.png",
		"tooltip" : "RGNT_ELEM_TOOLTIP",
		"effect" : {"type": "damage", "value": 3, "upgraded_value": 4, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 15,
		"substitute" : [],
		"transmutations" : ["uncommon", "damaging", "defensive"],
		"rank": 2,
	},
	"uncommon": {
		"name": "RGNT_UNC_ELEM_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/uncommon_elementium.png"),
		"tooltip_image_path": "res://assets/images/reagents/uncommon_elementium_borderless.png",
		"tooltip" : "RGNT_ELEM_TOOLTIP",
		"effect" : {"type": "damage", "value": 5, "upgraded_value": 6, "upgraded_boost": {"type": "all", "value": 2}},
		"gold_value" : 25,
		"substitute" : ["common"],
		"transmutations" : ["rare", "super_damaging", "super_defensive"],
		"rank": 3,
	},
	"rare": {
		"name": "RGNT_RARE_ELEM_NAME",
		"rarity": "RARE",
		"image": preload("res://assets/images/reagents/rare_elementium.png"),
		"tooltip_image_path": "res://assets/images/reagents/rare_elementium_borderless.png",
		"tooltip" : "RGNT_ELEM_TOOLTIP",
		"effect" : {"type": "damage", "value": 8, "upgraded_value": 10, "upgraded_boost": {"type": "all", "value": 3}},
		"gold_value" : 50,
		"substitute" : ["uncommon", "common"],
		"transmutations" : [],
		"rank": 4,
	},
	"weak_damaging": {
		"name": "RGNT_FAIN_DAMAGE_NAME",
		"rarity": "FAINT",
		"image": preload("res://assets/images/reagents/black_salt.png"),
		"tooltip_image_path": "res://assets/images/reagents/black_salt_borderless.png",
		"tooltip" : "RGNT_DAMAGE_TOOLTIP",
		"effect" : {"type": "damage_all", "value": 2, "upgraded_value": 2, "upgraded_boost": {"type": "damage", "value": 1}},
		"gold_value" : 5,
		"substitute" : ["damaging"],
		"transmutations" : ["damaging"],
		"rank": 1,
	},
	"damaging": {
		"name": "RGNT_COM_DAMAGE_NAME",
		"rarity": "COMMON",
		"image": preload("res://assets/images/reagents/black_powder.png"),
		"tooltip_image_path": "res://assets/images/reagents/black_powder_borderless.png",
		"tooltip" : "RGNT_DAMAGE_TOOLTIP",
		"effect" : {"type": "damage_all", "value": 3, "upgraded_value": 5, "upgraded_boost": {"type": "damage", "value": 2}},
		"gold_value" : 15,
		"substitute" : [],
		"transmutations" : ["super_damaging"],
		"rank": 2,
	},
	"super_damaging": {
		"name": "RGNT_UNC_DAMAGE_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/black_quartz.png"),
		"tooltip_image_path": "res://assets/images/reagents/black_quartz_borderless.png",
		"tooltip" : "RGNT_DAMAGE_TOOLTIP",
		"effect" : {"type": "damage_all", "value": 5, "upgraded_value": 7, "upgraded_boost": {"type": "damage", "value": 3}},
		"gold_value" : 35,
		"substitute" : ["damaging"],
		"transmutations" : [],
		"rank": 3,
	},
	"weak_defensive": {
		"name": "RGNT_FAIN_DEFENSE_NAME",
		"rarity": "FAINT",
		"image": preload("res://assets/images/reagents/scale_shard.png"),
		"tooltip_image_path": "res://assets/images/reagents/scale_shard_borderless.png",
		"tooltip" : "RGNT_DEFENSE_TOOLTIP",
		"effect" : {"type": "shield", "value": 2, "upgraded_value": 2, "upgraded_boost": {"type": "shield", "value": 1}},
		"gold_value" : 5,
		"substitute" : ["defensive"],
		"transmutations" : ["defensive"],
		"rank": 1,
	},
	"defensive": {
		"name": "RGNT_COM_DEFENSE_NAME",
		"rarity": "COMMON",
		"image": preload("res://assets/images/reagents/shell_shard.png"),
		"tooltip_image_path": "res://assets/images/reagents/shell_shard_borderless.png",
		"tooltip" : "RGNT_DEFENSE_TOOLTIP",
		"effect" : {"type": "shield", "value": 3, "upgraded_value": 5, "upgraded_boost": {"type": "shield", "value": 2}},
		"gold_value" : 15,
		"substitute" : [],
		"transmutations" : ["super_defensive"],
		"rank": 2,
	},
	"super_defensive": {
		"name": "RGNT_UNC_DEFENSE_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/rune_shard.png"),
		"tooltip_image_path": "res://assets/images/reagents/rune_shard_borderless.png",
		"tooltip" : "RGNT_DEFENSE_TOOLTIP",
		"effect" : {"type": "shield", "value": 5, "upgraded_value": 7, "upgraded_boost": {"type": "shield", "value": 3}},
		"gold_value" : 35,
		"substitute" : ["defensive"],
		"transmutations" : [],
		"rank": 3,
	},
	"healing": {
		"name": "RGNT_HEALING_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/invigorating_root.png"),
		"tooltip_image_path": "res://assets/images/reagents/invigorating_root_borderless.png",
		"tooltip" : "RGNT_HEALING_TOOLTIP",
		"effect" : {"type": "heal", "value": 1, "upgraded_value": 3, "upgraded_boost": {"type": "heal", "value": 5}},
		"gold_value" : 30,
		"substitute" : [],
		"transmutations" : [],
		"rank": 3,
	},
	"poison": {
		"name": "RGNT_POISON_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/noxious_essence.png"),
		"tooltip_image_path": "res://assets/images/reagents/noxious_essence_borderless.png",
		"tooltip" : "RGNT_POISON_TOOLTIP",
		"effect" : {"type": "status", "status_type": "poison", "target": "random_enemy", "positive": false, "value": 2, "upgraded_value": 4, "upgraded_boost": {"type": "status", "value": 2}},
		"gold_value" : 20,
		"substitute" : [],
		"transmutations" : [],
		"rank": 3,
	},
	"buff": {
		"name": "RGNT_BUFF_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/horn_fragment.png"),
		"tooltip_image_path": "res://assets/images/reagents/horn_fragment_borderless.png",
		"tooltip" : "RGNT_BUFF_TOOLTIP",
		"effect" : {"type": "status", "status_type": "temp_strength", "target": "self", "positive": true, "value": 2, "upgraded_value": 4, "upgraded_boost": {"type": "status", "value": 2}},
		"gold_value" : 25,
		"substitute" : [],
		"transmutations" : ["debuff"],
		"rank": 3,
	},
	"debuff": {
		"name": "RGNT_DEBUFF_NAME",
		"rarity": "UNCOMMON",
		"image": preload("res://assets/images/reagents/cracked_skull.png"),
		"tooltip_image_path": "res://assets/images/reagents/cracked_skull_borderless.png",
		"tooltip" : "RGNT_DEBUFF_TOOLTIP",
		"effect" : {"type": "status", "status_type": "weakness", "target": "random_enemy", "positive": false, "value": 1, "upgraded_value": 2, "upgraded_boost": {"type": "status", "value": 2}},
		"gold_value" : 25,
		"substitute" : [],
		"transmutations" : ["buff"],
		"rank": 3,
	},
	"trash": {
		"name": "RGNT_TRASH_NAME",
		"rarity": "BEETLE",
		"image": preload("res://assets/images/reagents/putrid_beetle.png"),
		"tooltip_image_path": "res://assets/images/reagents/putrid_beetle_borderless.png",
		"tooltip" : "RGNT_TRASH_TOOLTIP",
		"effect" : {"type": "damage_self", "value": 3, "upgraded_value": 1, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 1,
		"substitute" : [],
		"transmutations" : ["common"],
		"rank": 2,
	},
	"trash_plus": {
		"name": "RGNT_TRASH_PLUS_NAME",
		"rarity": "BEETLE",
		"image": preload("res://assets/images/reagents/preserved_beetle.png"),
		"tooltip_image_path": "res://assets/images/reagents/preserved_beetle_borderless.png",
		"tooltip" : "RGNT_TRASH_PLUS_TOOLTIP",
		"effect" : {"type": "damage_self", "value": 3, "upgraded_value": 4, "upgraded_boost": {"type": "all", "value": 1}},
		"gold_value" : 25,
		"substitute" : ["trash"],
		"transmutations" : ["uncommon"],
		"rank": 3,
	},
	"unknown": {
		"name": "UNKNOWN",
		"rarity": "UNKNOWN",
		"image": preload("res://assets/images/reagents/unknown_reagent.png"),
		"tooltip_image_path": "res://assets/images/reagents/unknown_reagent.png",
		"tooltip" : "UNKNOWN",
		"effect" : {"type": "damage_self", "value": 10, "upgraded_value": 1, "upgraded_boost": {"type": "all", "value": 2}},
		"gold_value" : 1,
		"substitute" : [],
		"transmutations" : [],
		"rank": 1,
	}
}


static func get_types() -> Array:
	return DB.keys()


static func get_reagents() -> Dictionary:
	return DB


static func get_from_name(name: String) -> Dictionary:
	if not DB.has(name):
		push_error("Given type of reagent doesn't exist: " + str(name))
	return DB[name].duplicate(true)


static func get_rank(name: String) -> int:
	if not DB.has(name):
		push_error("Given type of reagent doesn't exist: " + str(name))
	return DB[name].rank


static func get_substitutions(name: String) -> int:
	if not DB.has(name):
		push_error("Given type of reagent doesn't exist: " + str(name))
	return DB[name].substitute.duplicate(true)
