extends Panel


var held:bool = false
var margin:float
onready var initial_margin = get_parent().margin_right
func _on_Scaler_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			margin = get_parent().margin_right
			held = true
		elif !event.pressed and event.button_index == BUTTON_LEFT:
			held = false
	elif event is InputEventMouseMotion and held:
		get_parent().margin_right = get_global_mouse_position().x
		if get_parent().margin_right < initial_margin: get_parent().margin_right = initial_margin
		get_parent().emit_signal("position_changed")
	pass # Replace with function body.


func _on_Scaler_mouse_exited():
	held = false
	if get_parent().margin_right < initial_margin: get_parent().margin_right = initial_margin
	get_parent().emit_signal("position_changed")
	pass # Replace with function body.
