tool
extends Control
class_name EnhancedGraphEdit , "res://addons/enhanced-graph-node/icons/enhanced_edit.png"

#emited when user starts a connection
signal connection_begin
signal connection_end
signal connection_selected
signal connection_unselected
signal node_selected
signal node_unselected
enum STATE {IDLE,CONNECTING}



var state = STATE.IDLE
var ID:int = -1
var PARENT_ID:int = -1
var node_focused = null setget set_node_focused
var connections:Array = []
var connection = preload("res://addons/enhanced-graph-node/Connection.tscn")
var point = preload("res://addons/enhanced-graph-node/Point.tscn")
onready var temp_connection:Line2D = connection.instance()

func _ready():
	ID = AutoIncrement.get_number()
#	add_child(temp_connection)
	
	

func change_state(var new_state:int):
	state = new_state
	match(new_state):
		STATE.IDLE:
			enter_idle()
		STATE.CONNECTING:
			
			enter_connecting()

func set_node_focused(value):
	node_focused = value
	print("focused node: "+str(node_focused))
	pass

func enter_idle():
	
	pass

func enter_connecting():
	cr_connecting()
	
func cr_connecting():
	temp_connection.add_point(Vector2(0,0),0)
	temp_connection.add_point(Vector2(0,0),1)
	
	while state == STATE.CONNECTING:
		temp_connection.points[0] = connection_begin_node.rect_position
		temp_connection.points[1] = get_global_mouse_position()
		yield(get_tree(),"idle_frame")

func _input(event):
	if event is InputEventMouseButton:
		if !event.pressed and event.button_index == BUTTON_LEFT and state == STATE.CONNECTING:
			print("RELEASED ON CONNECTING")
			if node_focused != null:
				temp_connection.points[1] = node_focused.rect_position
			change_state(STATE.IDLE)


var connection_begin_node = null
func _on_connection_begin(graph_node):
	connection_begin_node = graph_node
	change_state(STATE.CONNECTING)
	pass # Replace with function body.
