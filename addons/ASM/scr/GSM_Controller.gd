tool
extends Control
class_name GSM_Controller

enum ACTIONS { STATE}


func show_action(action:int):
	match action:
		ACTIONS.STATE: $Actions/A_State.visible = true
		_: return

#
#export var np_main_graph_edit:NodePath
#
#var ps_graph = load("res://addons/ASM/MainGraphEdit.tscn")
#var ps_state = load("res://addons/ASM/GraphNodes/GN_State.tscn")
#var ps_statec = load("res://addons/ASM/GraphNodes/GN_StateContainer.tscn")
#
#var graphs = []
#var states = []
#var id_auto_increment:int = 1
#var active_graph = null
#var graph_id_auto_increment:int = 0;
#
#var connection_manager:ConnectionManager
#
##var script_manager:ScriptManager = ScriptManager.new();
#onready var viewer:JSONViewer = $JSONViewer
#onready var start_state:GraphNode = $Graphs/MainGraphEdit/GNStart
#func _ready():
#	connection_manager = ConnectionManager.new(self)
#	add_child_below_node(self,connection_manager,true)
#	print("initialized HraphController")
#	active_graph = get_node(np_main_graph_edit);
#	print("activegraph: "+active_graph.name)
#	graphs.append(active_graph)
#	pass
#
#func _process(delta):
#	if Input.is_action_just_pressed("ui_cancel") and active_graph.exitable:
##		print("pressed cancel: "+str(father.ID))
#		if active_graph.ID != 0:
#			goto(active_graph.father.ID)
#			print("going to father")
##	viewer.set_data(script_manager.data)
#		pass
#
#func _add_graph_node(node:GraphNode):
#	print(graphs)
#	print(active_graph)
#	active_graph.add_child(node)
#	node.set_owner(active_graph)
#	print("node owner: "+node.owner.name)
#	node.offset = active_graph.get_local_mouse_position()
#
#func add_state():
#	_add_graph_node(ps_state.instance())
#	pass # Replace with function body.
#
#func add_statec():
#	_add_graph_node(ps_statec.instance())
#
#func get_ai_id() -> int:
#	var id = id_auto_increment;
#	id_auto_increment += 1;
#	return id
#
#func get_parent_id() -> int:
#	return active_graph.ID
#
#func main_add_graph_edit() -> Node:
#	var node = ps_graph.instance()
#	graph_id_auto_increment += 1
#	get_child(0).add_child(node)
#	node.set_owner(self)
#	node.ID = graph_id_auto_increment
#	node.exitable = true
#	node.get_node("Panel").visible = true
#	node.father = active_graph
#	graphs.append(node)
#	return node
#
#
#func goto(idx:int):
#	print("going to")
#	for graph in graphs:
#		if graph.ID == idx:
#			graph.visible = true
#			active_graph = graph
#			active_graph._on_enter()
#		else: graph.visible = false
#
#func get_connections_from(from) -> Array:
#	var arr = active_graph.get_connection_list()
#	var list = []
#	for i in range(arr.size()):
#		var dict = arr[i]
#		if dict["from"] == from:
#			list.append(active_graph.find_node(dict["to"]))
#	return list
#
#func get_all_gnodes() -> Array:
#	return get_tree().get_nodes_in_group("ASM_GN");
#
#func get_active_gnodes() -> Array:
#	var arr = []
#	var temp = active_graph.get_children()
#	for child in temp:
#		if child.is_in_group("ASM_GN"):
#			arr.append(child)
#		else: continue
#	return arr
#
#func get_graph_node_by_state_id(id:int) -> ASM_GN:
#	var graph = null
#	for gnode in get_active_gnodes():
#		if gnode.state.ID == id:
#			graph = gnode
#			break
#	return graph
#
#
#func on_screen_entered(name):
#	if name != "ASM": return
#
#
#func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
#	print("disconnect")
#	active_graph.disconnect_node(from, from_slot, to, to_slot)
#	pass # Replace with function body.
#
#func _on_bt_compile_pressed():
#	var compiler:Compiler = Compiler.new()
#	compiler.compile_state_machine(self)
#	pass # Replace with function body.
#
#
#func _on_bt_erase_line_pressed():
#	pass # Replace with function body.
#
#
#func _on_focus_entered():
#	print("focus")
#	pass # Replace with function body.
#
#
#func _on_focus_exited():
#	print("unfocus")
#	pass # Replace with function body.
#
#func _on_ActionList_item_selected(index):
#	active_graph.add_stuff(index)
#	$ActionList.visible = false
#	pass # Replace with function body.
#
#
#func _on_ActionList_mouse_exited():
#	$ActionList.visible = false
#	pass # Replace with function body.
#
#
#func _on_StateConfigList_item_selected(index):
#	active_graph.state_config(index)
#	pass # Replace with function body.
#
#
#func _on_StateConfigList_mouse_exited():
#	$StateConfigList.visible = false
#	pass # Replace with function body.
#
#
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_RIGHT:
			print("pressed")
			show_action(ACTIONS.STATE)
