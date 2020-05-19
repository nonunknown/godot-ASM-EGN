extends Control
class_name ConnectionManager


enum STATE {IDLE,CONNECTING}

var _state:int = STATE.IDLE
var _is_mouse_inside_graph_node:bool = false
var _current_graph_node:GraphNode = null
var _last_graph_node:GraphNode = null
var _from:GraphNode = null
var _to:GraphNode = null
var _clicked_from:Vector2 = Vector2()
var _clicked_to:Vector2 = Vector2()

var graph_controller

func _init(graph_controller):
	self.graph_controller = graph_controller

func _set_state(new_state:int):
	_state = new_state

func _add_connection():
	_from.state.add_connection(_to)
	var st = _from.state
	var ost = _to.state
	st.clicked_points[ost.ID] = {from=_clicked_from,to=_clicked_to}
	
	_set_state(STATE.IDLE)
	print("connected from: %s to %s" % [_from.name,_current_graph_node.name])
	pass

func send_data(graph_node:GraphNode,inside_graph:bool=false):
	_is_mouse_inside_graph_node = inside_graph
	if inside_graph:
		_last_graph_node = _current_graph_node
		_current_graph_node = graph_node
		print("current GN: "+_current_graph_node.name)
		
	else: 
		_current_graph_node = null
		print("current GN: none")
	

func _input(event):
	if event is InputEventKey:
		if (event.is_pressed() and event.scancode == KEY_C):
			if _is_mouse_inside_graph_node and _state == STATE.IDLE:
				_from = _current_graph_node
				if not is_valid_connection_make(): return
				_clicked_from = _from.get_local_mouse_position()
				_set_state(STATE.CONNECTING)
			pass
	elif event is InputEventMouseButton:
		if (event.is_pressed() and event.button_index == BUTTON_LEFT and _state == STATE.CONNECTING):
			_to = _current_graph_node
			if not is_valid_connection_receive(): return
			_clicked_to = _to.get_local_mouse_position()
			_add_connection()
			pass
		pass

func is_valid_connection_receive() -> bool:
	var st:State = _to.state
	if st.can_receive_connection == false:
		print("ERROR: %s cant receive connection" % st.name)
	elif sizeof_receiving_connections(st)+1 > st.max_connections.y:
		print("ERROR: %s cant receive more connections" % st.name)
	elif _from.state.is_connected_with(st.ID):
		print("ERROR: %s Already connected with %s" % [_from.state.name,st.name])
	else: return true
	_state = STATE.IDLE
	return false

func sizeof_receiving_connections(state:State) -> int: return 0

func is_valid_connection_make() -> bool:
	var st:State = _from.state
	
	if st.can_make_connection == false:
		print("ERROR: %s cant make connections" % st.name)
	elif st.connections.size()+1 > st.max_connections.x:
		print("ERROR: %s cant make more connections" % st.name)
	else: return true
	
	return false

func _process(delta):
	update()
	pass
	
func _draw():
	if _state == STATE.CONNECTING:
		draw_line(_from.rect_position + _clicked_from,get_local_mouse_position(),Color.aqua,2)
	
	for graph_node in graph_controller.get_active_gnodes():
		var st:State = graph_node.state
		for i in range(st.connections.size()):
			var from = graph_node
			var to = graph_controller.get_graph_node_by_state_id(st.connections[i])
			if to == from:
				draw_arc(from.rect_position+Vector2(from.rect_size.x/2,0),50,0,-3,10,Color.white,3)
			else:
			#{from,to} -> Vector2 clicked_point
				var dict = graph_node.state.clicked_points[to.state.ID]
				var pos_a = from.rect_position + dict.from
				var pos_b = to.rect_position + dict.to

				draw_line(pos_a,pos_b,Color.white,3)
				draw_circle(pos_a,3,Color.gold)


