tool
extends Panel

onready var camera:Camera2D = get_node("../Camera2D")

var held:bool = false
var pos
var zoom_factor = Vector2(.5,.5)
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_WHEEL_UP:
			if camera.zoom.x - zoom_factor.x <= 0.01 : return
			camera.zoom -= zoom_factor
#			Input.warp_mouse_position(get_local_mouse_position()-zoom_factor)
			
			camera.position = get_global_mouse_position()
			pass
		elif event.pressed and event.button_index == BUTTON_WHEEL_DOWN:
			
			camera.zoom += zoom_factor
#			Input.warp_mouse_position(get_local_mouse_position()+zoom_factor)
			camera.position = get_global_mouse_position()
			
			pass
		
		if event.pressed and event.button_index == BUTTON_MIDDLE:
			held = true
			mouse_default_cursor_shape = Control.CURSOR_DRAG
		elif !event.pressed and event.button_index == BUTTON_MIDDLE:
			held = false
			mouse_default_cursor_shape = Control.CURSOR_ARROW
	elif event is InputEventMouseMotion and held:
		get_node("../Camera2D").global_transform.origin -= event.relative
#		get_node("../Camera2D").global_transform.origin.x += get_global_mouse_position().x
#		get_node("../Camera2D").global_transform.origin.y = pos.y - get_global_mouse_position().y
	pass # Replace with function body.




