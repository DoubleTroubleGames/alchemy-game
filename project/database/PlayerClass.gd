extends Resource
class_name PlayerClass

export(String) var name
export(Array, String) var initial_recipes
export(Array, String) var initial_artifacts
export(Array, Array) var initial_reagents #Pair of String (name) and Int (amount)
export(Array, int) var max_hps = [100, 180, 250]
export(Array, int) var hand_size = [5, 8, 12]
export(Texture) var portrait
