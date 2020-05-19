tool
extends ASM_GN

var has_graph:bool = false
var the_graph = null
onready var le_name:LineEdit = $LineEdit
func _ready():
	le_name.text = "sc_"+str(randi())
	name = le_name.text
	print("parent id: "+str(graph_control.get_parent_id()))
	state = State.new(graph_control.get_ai_id(),graph_control.get_parent_id(),le_name.text,offset,State.Type.CONTAINER,self)
	print("attached id: "+str(state.ID)+"/ parent id: "+str(state.parent_id))
	pass

func _on_bt_enter_pressed():
	if !has_graph:
		the_graph = graph_control.main_add_graph_edit()
		has_graph = true
	graph_control.goto(the_graph.ID)
	graph_control.active_graph = the_graph
	pass # Replace with function body.


func _on_LineEdit_text_changed(text):
	change_names(text,"StateContainer: ")
	pass # Replace with function body.
