extends Panel


var connecting = false
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			
			if get_parent().graph_edit == null: 
				push_warning(get_parent().name + ": Has no graph edit as parent")
				return
			connecting = true
			get_parent().graph_edit.emit_signal("connection_begin",get_parent())
		elif !event.pressed and event.button_index == BUTTON_LEFT and connecting:
			connecting = false
#		print(str(connecting))
	pass # Replace with function body.
