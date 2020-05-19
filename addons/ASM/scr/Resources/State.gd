extends Resource
class_name State

enum Type {NORMAL,ENTRY,EXIT,CONTAINER}
export(int) var ID;
export(int) var parent_id;
export(String) var name;
export(Type) var type = Type.NORMAL
export(bool) var has_init = false;
export(bool) var has_exit = false;
export(Vector2) var offset;
export(Vector2) var max_connections = Vector2(100000,100000) #Vector2(max_connections_can_do,max_connections_can_receive)
export(bool) var can_receive_connection = true
export(bool) var can_make_connection = true
#export(Array, Resource) var connections setget set_connections,get_connections; #Resource as State
export(Array, int) var connections setget ,get_connections
export(Dictionary) var clicked_points

var graph_node:GraphNode setget set_graph_node

func _init(id:int,parentID:int,name:String,offset:Vector2,t:int = 0,graph_node:GraphNode=null):
	self.name = name;
	self.offset = offset;
	self.type = t;
	self.ID = id;
	self.graph_node = graph_node
	self.parent_id = parentID

func get_json() -> JSONParseResult:
	var dict = {}
	var props = get_script().get_script_property_list()
	for p in props:
		dict[p.name] = str(get(p.name))
	print(str(dict))
	return parse_json(str(dict))

func get_state_functions() -> Array:
	var arr = []
	if has_init: arr.append("st_init_"+name)
	arr.append("st_update_"+name)
	if has_exit: arr.append("st_exit_"+name)
	return arr

func get_parent_id() -> int: return parent_id

func add_connection(node_to):
	connections.append(node_to.state.ID)

func remove_connection(id):
	connections.remove(connections.find(id))
	print("removed: %s" % str(id))

#func set_connections(_connections,add:bool=false) -> void:
#	var arr = []
#	var func_name = "state_machine.change_state(STATE.%s)"
#	if (typeof(_connections) == TYPE_ARRAY):
#		for c in _connections:
#			var name = c.state.name
#			var f = func_name % name.to_upper()
#			arr.append(f)
#	if !add:connections = arr
#	else: 
#		var name = _connections.state.name
#		connections.append(func_name % name.to_upper())

func is_connected_with(state_id:int) -> bool:
	for id in connections:
		if id == state_id: return true
	return false

func get_connections() -> Array:
	return connections

func set_graph_node(value):
	graph_node = value
