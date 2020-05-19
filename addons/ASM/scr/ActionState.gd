tool
extends ItemList




func _on_visibility_changed():
	if !visible: return
	rect_position = get_global_mouse_position() - Vector2(10,10)


func _on_mouse_exited():
	unselect_all()
	visible = false
	pass # Replace with function body.


func _on_item_selected(index):
	#TODO: Action
	visible = false
	pass # Replace with function body.
