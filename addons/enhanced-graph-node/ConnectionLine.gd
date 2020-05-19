extends Line2D

export var np_pa:NodePath
export var np_pb:NodePath

onready var graph_a
var graph_b

func _ready():
	graph_a = get_node(np_pa)
	graph_b = get_node(np_pb)
	graph_a.connect("position_changed",self,"_on_position_changed")
	graph_b.connect("position_changed",self, "_on_position_changed")
var last_x = 0
func _on_position_changed():
	var size_a = graph_a.rect_size
	var pos_a = graph_a.rect_position
	
	var size_b = graph_b.rect_size
	var pos_b = graph_b.rect_position
	
	var conn_a:int = 2
	var conn_b:int = 2 #number of connections
	
	var middle_a = pos_a + size_a / 2
	var middle_b = pos_b + size_b / 2
	
	var result_a:Vector2 = middle_a
	var result_b:Vector2 = middle_b
	if pos_b.x > pos_a.x and pos_b.x < pos_a.x + size_a.x:
		result_a = middle_a
	
	# A - LEFT
#	if pos_a.y+size_a.y < pos_b.y: result_a.y = size_a.y + pos_a.y
#	elif pos_a.y < pos_b.y + size_b.y and pos_a.y > pos_b.y: result_a.y = pos_a.y + size_a.y/conn_a
#	else: result_a = Vector2.ZERO
	
	# A - RIGHT
	
	
	points[0] = result_a
	points[1] = result_b


#	print(str(graph_node.rect_position.y))
