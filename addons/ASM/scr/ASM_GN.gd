extends GraphNode
class_name ASM_GN

onready var graph_control = get_parent().graph_control
onready var connection_manager:ConnectionManager = graph_control.connection_manager
var state:State = null

func get_connections() -> Array:
	return state.connections

func get_state() -> State:
	return state

func get_state_id() -> int:
	return state.ID

func get_parent_id() -> int:
	return state.parent_id

func change_names(text,pre_title) -> void:
	text = text.to_lower()
	text = text.replace(" ","_")
	title = pre_title+text
	name = text
	state.name = text

func close_request():
	for gnode in graph_control.get_active_gnodes():
		for id in gnode.state.connections:
			if id == state.ID:
				gnode.state.remove_connection(id)
				break;
		pass
	pass

func _ready():
	connect("mouse_entered",self,"_on_mouse_enter")
	connect("mouse_exited",self,"_on_mouse_exit")
	connect("offset_changed",self,"_on_move")
	pass

func _on_move():
	print("moved")
	print(str(get_connections()))
	pass

func _on_mouse_enter():
	graph_control.connection_manager.send_data(self,true)
	
	pass

func _on_mouse_exit():
	graph_control.connection_manager.send_data(self,false)
	pass
