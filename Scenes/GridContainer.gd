extends GridContainer

onready var GM = preload("res://GameMechanics/15GameModel.gd").new()

func _ready():
	GM._ready()
	columns = GM.row_col
	_on_Button_pressed()

func _input(event):
	if  event is InputEventKey && event.is_pressed():
		if GM.next_step(event.get_scancode()):
			var _old_node = get_child(GM.old_position_idx)
			var _new_node = get_child(GM.new_position_idx)
			var _old_control = _old_node.get_node("Control")
			var _new_control = _new_node.get_node("Control")
			_old_node.remove_child(_old_control)
			_new_node.remove_child(_new_control)
			_old_node.add_child(_new_control)
			_new_node.add_child(_old_control)
			_new_control.set_owner(_old_node)
			_old_control.set_owner(_new_node)

func _on_Button_pressed():
	for i in get_children():
		remove_child(i)
	GM.run_new_game()
	var control = preload("res://Scenes/Cell.tscn")
	for i in GM.aModel:
		var new_control = control.instance()
		new_control.get_node("Control/ColorRect/Label").text = str(i)
		if i == 0:
			new_control.get_node("Control").set_visible(false)
		add_child(new_control)
