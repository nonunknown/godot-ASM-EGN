extends CheckBox

var animate:bool = false
var value = 0;
func _process(delta):
	if !animate: return
	var dir = sign(value)
	rect_rotation += 20 * dir
	
	if (dir > 0 and rect_rotation >= 0.1) or ( dir < 0 and rect_rotation < -90 ):
		animate = false
		if dir > 0: 
			rect_rotation = 0.1
			get_node("../Content").visible = true
			
		else: 
			rect_rotation = -90
			get_node("../Content").visible = false
	
	
func _on_CheckBox_toggled(button_pressed):
	print("pressed")
	if button_pressed:
		value = 0.1
		animate = true
		print("positive")
	else:
		value = -90
		animate = true
		print("negative")
	pass # Replace with function body.
