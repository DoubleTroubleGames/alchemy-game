extends Node

const REAGENT = preload("res://game/reagents/Reagent.tscn")
const FONT_PATH = "res://assets/fonts/TooltipImageFont.tres"


func random_type():
	var types = ReagentDB.get_types()
	randomize()
	types.shuffle() 
	return types[0] if types[0] != "unknown" else types[1]


func create_object(type: String):
	var reagent_data = ReagentDB.get_from_name(type)
	var reagent = REAGENT.instance()
	
	#Duplicate material so shader parameters only affect this object
	var mat_override = reagent.get_node("Image").get_material().duplicate()
	reagent.get_node("Image").set_material(mat_override)
	
	reagent.type = type
	reagent.set_image(reagent_data.image)
	return reagent


func get_data(type: String):
	return ReagentDB.get_from_name(type)

#Given a base reagent, returns all reagents that can substitute into it
func substitute_into(base_reagent):
	var upgrade_list = []
	var all_reagents = ReagentDB.get_reagents()
	for reagent_type in all_reagents:
		for substitute_reagent in all_reagents[reagent_type].substitute:
			if substitute_reagent == base_reagent:
				upgrade_list.append(reagent_type)
				break
	return upgrade_list


func randomize_reagent(reagent):
	var type = random_type()
	var reagent_data = ReagentDB.get_from_name(type)
	reagent.type = type
	reagent.set_image(reagent_data.image)


func get_tooltip(type: String, upgraded:= false, unstable:= false, burned:= false):
	var data = get_data(type)
	var text
	var title
	data.tooltip = tr(data.tooltip)
	data.name = tr(data.name)
	var value; var upgraded_value
	if typeof(data.effect) == TYPE_ARRAY:
		value = []
		upgraded_value = []
		for effect in data.effect:
			value.append(effect.value)
			upgraded_value.append(effect.upgraded_value)
	else:
		value = data.effect.value
		upgraded_value = data.effect.upgraded_value
	if not upgraded:
		title = data.name
		text = data.tooltip % value
	else:
		title = data.name + "+"
		text = data.tooltip % upgraded_value + ". "
		if typeof(data.effect) == TYPE_ARRAY:
			for effect in data.effect:
				text += tr("BOOST_RECIPES") % \
					tr(effect.upgraded_boost.type)
				text += " " + str(effect.upgraded_boost.value) + ". "
		else:
			text += tr("BOOST_RECIPES") % \
					tr(data.effect.upgraded_boost.type)
			text += " " + str(data.effect.upgraded_boost.value) + "."
	if unstable:
		text += " " + tr("UNSTABLE") + "."
	if burned:
		text += " " + tr("ON_FIRE") + "."
	
	var subtitle = tr(data.rarity + "_REAGENT")
	
	var tooltip = {"title": title, "text": text, \
				   "title_image": data.tooltip_image_path, "subtitle": subtitle}

	return tooltip


func get_substitution_tooltip(type):
	var data = get_data(type)
	if data.substitute.size() <= 0:
		return null
	
	var text
	if data.substitute.size() == 1:
		text = tr("SUBSTITUTION_TOOLTIP_SINGULAR")
	else:
		text = tr("SUBSTITUTION_TOOLTIP_PLURAL")
	text += ": "
	for sub_reagent in data.substitute:
		var sub_data = get_data(sub_reagent)
		var path = sub_data.image.get_path()
		text += "[font="+FONT_PATH+"][img=48x48]"+path+"[/img][/font]  "
	var tooltip = {"title": "SUBSTITUTES", "text": text, \
				   "title_image": data.tooltip_image_path}
	
	return tooltip


#Given an array of reagents for a recipe, and and array of given reagentes, 
#checks if you can create the recipe with the given reagents, taking into
#consideration substitutions. If possible, will return an array of indexes
#for which reagents to use in the given_reagents array
func get_reagents_to_use(recipe_array: Array, given_reagents : Array):
	var given = []
	var given_rank = []
	#Initial bitmask where 1 means we still need this reagent from recipe array
	var starting_bitmask = (1 << recipe_array.size()) - 1
	#Memoization bitmask matrix, where each position on the first dimension represents a given reagent,
	#And the second dimension is an array of each possible bitmap for that reagent
	#The final value inside is the total rank cost of this solution
	var memoization = []
	for i in given_reagents.size():
		given.append([])
		memoization.append([])
		for _j in starting_bitmask + 1:
			memoization[i].append(-1)
		var reagent = given_reagents[i]
		if reagent:
			var data = ReagentDB.get_from_name(reagent)
			var possible_substitutions = data.substitute
			possible_substitutions.append(reagent)
			given_rank.append(data.rank)
			for j in recipe_array.size():
				if possible_substitutions.has(recipe_array[j]):
					given[i].append(j)
		else:
			given_rank.append(INF)

	var result = pd_recursion(given, given_rank, memoization, 0, starting_bitmask)
	if result >= INF:
		return false
	else:
		var solution = []
		for _i in given.size():
			solution.append(false)
		reconstruct_solution(solution, recipe_array, given, given_rank, memoization, 0, starting_bitmask)
		return solution


#Recursive method that invariably returns the total cost of using all given reagents with index >=idx
func pd_recursion(given, given_rank, memoization, idx, mask):
	if mask == 0: #Fullfilled all reagents requirements sucessfully
		return 0
	if idx == given.size(): 
		return INF #Didn't use all reagents sucessfully (guaranteed given previous return)
	
	var result = memoization[idx][mask]
	if result == -1: #Didn't check this given reagent
		result = pd_recursion(given, given_rank, memoization, idx+1, mask)
		memoization[idx][mask] = result
		for reagent in given[idx]:
			if (mask >> reagent)%2 == 1:
				result = min(result, given_rank[idx] + pd_recursion(given, given_rank, memoization, idx+1, mask^(1<<reagent)))
				memoization[idx][mask] = result
	return result

#Recursive method that reconstructs the final solution array
#At the end of the function, invariably all given reagents with index >= idx are sorted and used in the final solution array
func reconstruct_solution(solution, recipe_array, given, given_rank, memoization, idx, mask):
	if mask == 0: #Fullfilled all reagents requirements sucessfully
		return
	if idx == given.size(): 
		push_error("Something is wrong, mask isn't empty at end of recursion")
		return
		
	var result = memoization[idx][mask]
	if result == pd_recursion(given, given_rank, memoization, idx+1, mask):
		#Can progress through this solution without using this reagent
		reconstruct_solution(solution, recipe_array, given, given_rank, memoization, idx+1, mask)
	else:
		for reagent_idx in given[idx]:
			if (mask >> reagent_idx)%2 == 1:
				var new_mask = mask^(1<<reagent_idx)
				if result == given_rank[idx] + pd_recursion(given, given_rank, memoization, idx+1, new_mask):
					#I am using this exact substitution on the solution, mark on the solution
					solution[idx] = recipe_array[reagent_idx]
					reconstruct_solution(solution, recipe_array, given, given_rank, memoization, idx+1, new_mask)
					return #Avoids checking other substitutions


func is_same_reagent_array(array1, array2):
	var a1 = array1.duplicate()
	for reagent in array2:
		var i = a1.find_last(reagent) 
		if i == -1:
			return false
		a1.remove(i)
	if a1.empty():
		return true
	return false

#Returns an array containing all possible one-reagent downgrade from a given array
#(downgrade means that the original reagent substitutes into another)
func downgraded_arrays(reagent_array):
	var downgraded_array_list = []
	for i in reagent_array.size():
		var reagent = reagent_array[i]
		var data = get_data(reagent)
		for substitute in data.substitute:
			var new_array = reagent_array.duplicate()
			new_array[i] = substitute
			downgraded_array_list.append(new_array)
	
	return downgraded_array_list


#Returns an array containing all possible one-reagent upgrade from a given array
#(upgrade means that another reagent can substitute into one of its reagents)
func upgraded_arrays(reagent_array):
	var upgraded_array_list = []
	for i in reagent_array.size():
		var reagent = reagent_array[i]
		for substitute_reagent in substitute_into(reagent):
			var new_array = reagent_array.duplicate()
			new_array[i] = substitute_reagent
			upgraded_array_list.append(new_array)
	
	return upgraded_array_list


func get_array_from_matrix(reagent_matrix):
	var array = []
	for i in reagent_matrix.size():
		for reagent in reagent_matrix[i]:
			if reagent:
				array.append(reagent)
	return array


func create_matrix_from_array(original_matrix, reagent_array):
	var matrix = original_matrix.duplicate(true)
	var count = 0
	for i in matrix.size():
		for j in matrix[i].size():
			if matrix[i][j]:
				matrix[i][j] = reagent_array[count]
				count += 1
	return matrix


#Given a reagent matrix, returns all possible matrixes considering its reagent substitutions
func get_all_substitution_matrices(original_reagent_matrix):
	var final_arrays = []
	var original_reagent_array = get_array_from_matrix(original_reagent_matrix)
	var reagent_arrays_to_check = [original_reagent_array]
	var reagent_arrays_viewed = [original_reagent_array]
	while not reagent_arrays_to_check.empty():
		var cur_reagents_array = reagent_arrays_to_check.pop_front()
		final_arrays.append(cur_reagents_array)
		for substituted_array in ReagentManager.downgraded_arrays(cur_reagents_array):
			var unique = true
			for array_viewed in reagent_arrays_viewed:
				if ReagentManager.is_same_reagent_array(array_viewed, substituted_array):
					unique = false
					break
			if unique:
				reagent_arrays_to_check.append(substituted_array)
				reagent_arrays_viewed.append(substituted_array)
	
	var possible_matrices = []
	for array in final_arrays:
		possible_matrices.append(create_matrix_from_array(original_reagent_matrix, array))
	return possible_matrices
