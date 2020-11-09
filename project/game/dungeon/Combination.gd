extends Node
class_name Combination

signal fully_discovered

var grid_size : int
var recipe : Recipe
var matrix : Array
var known_matrix : Array
var unknown_reagent_coords : Array
var discovered : bool
var reagent_amounts := {}
var hints := 0


func create_from_recipe(_recipe: Recipe, combinations: Dictionary):
	recipe = _recipe
	grid_size = recipe.grid_size
	var available_positions := []
	var elements := (recipe.reagents.duplicate() as Array)
	
	# Counting reagents
	elements.sort()
	for reagent in elements:
		if reagent_amounts.has(reagent):
			reagent_amounts[reagent] += 1
		else:
			reagent_amounts[reagent] = 1
	
	# Initializing matrices
	for i in range(grid_size):
		var line = []
		var unknown_line = []
		for j in range(grid_size):
			line.append(null)
			unknown_line.append("unknown")
			unknown_reagent_coords.append([i, j])
			available_positions.append([i, j])
		matrix.append(line)
		known_matrix.append(unknown_line)
	
	while(true):
		var temp_matrix = matrix.duplicate(true)
		var temp_available_pos = available_positions.duplicate(true)
		var temp_elements = elements.duplicate(true)
		
		# Placing the first two reagents that guarantee grid size consistency
		temp_elements.shuffle()
		var pos1 : Array
		var pos2 : Array
		if randf() < .5:
			pos1 = [0, randi() % grid_size]
			pos2 = [grid_size - 1, randi() % grid_size]
		else:
			pos1 = [randi() % grid_size, 0]
			pos2 = [randi() % grid_size, grid_size - 1]
		temp_matrix[pos1[0]][pos1[1]] = temp_elements.pop_front()
		temp_matrix[pos2[0]][pos2[1]] = temp_elements.pop_front()
		temp_available_pos.erase(pos1)
		temp_available_pos.erase(pos2)
		
		# Placing the rest
		temp_available_pos.shuffle()
		while not temp_elements.empty():
			var pos = temp_available_pos.pop_front()
			temp_matrix[pos[0]][pos[1]] = temp_elements.pop_front()
		
		#Check if there isn't another recipe with the same layout,
		#but with reagents that can substitute into the exact recipe
		if check_if_unique(temp_matrix, combinations):
			matrix = temp_matrix
			break


func check_if_unique(test_matrix: Array, combinations: Dictionary):
	if not combinations.has(grid_size):
		return true
	for comb in combinations[grid_size]:
		if is_downgraded_version_of(comb.matrix, test_matrix) or\
		   is_downgraded_version_of(test_matrix, comb.matrix):
			return false
	return true


#Checks if matrix1 can be downgraded into matrix2 via reagents substitutes
func is_downgraded_version_of(matrix1:Array, matrix2:Array):
	for i in range(grid_size):
		for j in range(grid_size):
			#Same reagents, continue comparison
			if matrix1[i][j] == matrix2[i][j]:
				continue
			#Check if reagent isn't nil
			if matrix1[i][j]:
				var equal = false
				var data = ReagentManager.get_data(matrix1[i][j])
				#Check for equality for each substitute the reagent can have
				for reagent in data.substitute:
					if reagent == matrix2[i][j]:
						equal = true
						break
				if equal:
					continue
				else:
					return false
			#Check if matrix1 reagent is nil, cant downgrade into matrix2
			else:
				return false
	return true


func get_hint(which := 0):
	if not which:
		hints += 1
	elif hints > which or discovered:
		return
	else:
		hints = which
	
	match hints:
		1:
			_first_hint()
		2:
			_second_hint()
		_:
			discover_all_reagents()


func _first_hint():
	unknown_reagent_coords.shuffle()
	
	# check if recipe would be obvious after discovering empty spaces
	if reagent_amounts.keys().size() == 1:
		var reagent = reagent_amounts.keys()[0]
		var n = reagent_amounts[reagent]
		var last_kept = "(￢‿￢)"
		var kept_coords = []
		if n > (grid_size * grid_size) / 2:
			n = (grid_size * grid_size) / 2
		while n:
			var i = n
			for coords in unknown_reagent_coords:
				if matrix[coords[0]][coords[1]] != last_kept:
					last_kept = matrix[coords[0]][coords[1]]
					kept_coords.append(coords)
					n -= 1
					break
			if i == n:
				var coords = unknown_reagent_coords.front()
				last_kept = matrix[coords[0]][coords[1]]
				kept_coords.append(coords)
				n -= 1
		for coords in unknown_reagent_coords:
			if coords in kept_coords:
				continue
			known_matrix[coords[0]][coords[1]] = matrix[coords[0]][coords[1]]
		unknown_reagent_coords = kept_coords
	else:
		# discover empty spaces
		for i in grid_size:
			for j in grid_size:
				if not matrix[i][j]:
					known_matrix[i][j] = null
					unknown_reagent_coords.erase([i, j])
		# discover more if half of the spaces haven't been discovered
		var half_amount = grid_size * grid_size / 2
		if unknown_reagent_coords.size() > half_amount:
			_discover_reagents(unknown_reagent_coords.size() - half_amount)
	
	# check if it was equivalent to the second hint
	if unknown_reagent_coords.size() == 2:
		hints = 2


func _second_hint():
	if unknown_reagent_coords.size() <= 2:
		discover_all_reagents()
		return
	
	unknown_reagent_coords.shuffle()
	
	# discover all but two reagents (preferably different ones)
	var first = {"reagent": null, "coords": null}
	var second = {"reagent": null, "coords": null}
	
	for coords in unknown_reagent_coords:
		var reagent = matrix[coords[0]][coords[1]]
		if not reagent:
			continue
		
		if not first.reagent:
			first.reagent = reagent
			first.coords = coords
		elif reagent != first.reagent:
			second.reagent = reagent
			second.coords = coords
			break
	
	# make the result not obvious
	if not second.coords:
		for coords in unknown_reagent_coords:
			var reagent = matrix[coords[0]][coords[1]]
			if reagent != first.reagent:
				second.reagent = reagent
				second.coords = coords
				break
	
	for coords in unknown_reagent_coords:
		if coords != first.coords and coords != second.coords:
			known_matrix[coords[0]][coords[1]] = matrix[coords[0]][coords[1]]
	
	unknown_reagent_coords = [first.coords, second.coords]


func _discover_reagents(amount: int):
	assert(amount > 0)
	if amount >= unknown_reagent_coords.size():
		discover_all_reagents()
		return
	
	unknown_reagent_coords.shuffle()
	for _i in range(amount):
		var coords = unknown_reagent_coords.pop_front()
		known_matrix[coords[0]][coords[1]] = matrix[coords[0]][coords[1]]


func discover_all_reagents():
	if not discovered:
		discovered = true
		known_matrix = matrix
		unknown_reagent_coords.clear()
		emit_signal("fully_discovered", self)
