extends Node

const row_col: int = 4 
var aModel = []
var empty_cell_idx: int = 0
var old_position_idx: int = 0
var new_position_idx: int = 0

func _ready():
	randomize()
	for num in row_col * row_col:
		aModel.append(num)

func run_new_game():
	var items_count = row_col * row_col
	# swap cells position
	for idx in items_count:
		var new_idx = randi() % items_count
		swap_positions(idx, new_idx)
			
func swap_positions(old_idx:int, new_idx:int):
	var save_item = aModel[new_idx]
	aModel[new_idx] = aModel[old_idx]
	aModel[old_idx] = save_item
	if aModel[old_idx] == 0:
		empty_cell_idx = old_idx
	if aModel[new_idx] == 0:
		empty_cell_idx = new_idx
		
func check_result()->bool:
	var items_count = row_col * row_col
	for idx in items_count:
		if idx < items_count - 3 && idx > idx + 1:
			return false
	return true

func next_step(key)->bool:
	print(key," ", empty_cell_idx)
	var empty_cell_pos = Vector2(empty_cell_idx % row_col,empty_cell_idx / row_col)
	print(key," ", empty_cell_pos.x," ", empty_cell_pos.y)
	var swap_pos = Vector2() + empty_cell_pos
	match key:
		KEY_UP:
			if empty_cell_pos.y > 0:
				swap_pos.y -= 1 
		KEY_LEFT:
			if empty_cell_pos.x > 0:
				swap_pos.x -= 1
		KEY_RIGHT:
			if empty_cell_pos.x < row_col - 1:
				swap_pos.x += 1
		KEY_DOWN:
			if empty_cell_pos.y < row_col - 1:
				swap_pos.y += 1
	if empty_cell_pos != swap_pos:
		old_position_idx = row_col * empty_cell_pos.y + empty_cell_pos.x
		new_position_idx = row_col * swap_pos.y + swap_pos.x
		print(key," ", old_position_idx," ", new_position_idx)
		swap_positions(old_position_idx, new_position_idx)
		return true
	return false