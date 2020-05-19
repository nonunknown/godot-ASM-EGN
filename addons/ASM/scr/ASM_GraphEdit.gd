tool
extends GraphEdit
class_name ASM_GraphEdit

export var exitable:bool = false
export var ID:int = 0
var father:ASM_GraphEdit = null
onready var graph_control = get_tree().get_nodes_in_group("Controller")[0]
var selected_state:State = null

func _ready():
	self.connect("connection_request",graph_control,"_on_GraphEdit_connection_request")
	self.connect("disconnection_request",graph_control,"_on_GraphEdit_disconnection_request")
	
	print("connected")

func _on_enter():
	$Panel/GridContainer/ID.text = "ID: "+str(ID)
	$Panel/GridContainer/Active.text = "Active: "+str(graph_control.active_graph.ID)
	if exitable:
		$Panel/GridContainer/ESC.visible = true
		$Panel/GridContainer/Tree.text = "Child of: "+str(father.ID)
		$Panel/GridContainer/Tree.visible = true
		
	pass




func add_stuff(index):
	match index:
		0: graph_control.add_state()
		1: graph_control.add_statec()

func config_state(index):

	pass

var line = false
var the_gn:GraphNode = null
func _draw():
	if !line: return
#	print(get_parent().get_child(0).name)
#	draw_line(the_gn.rect_position + the_gn.pos,get_local_mouse_position(),Color.white,2)
	var a = the_gn.rect_position + the_gn.pos
	var b = get_local_mouse_position()
#	var c = ( (a+b)/2 )+ (Vector2.UP * 2)
	draw_line(a,b,Color.red)
#	draw_polygon([a,b,c],[Color.white,Color.red,Color.blue])
#	draw_line(get_local_mouse_position(),get_local_mouse_position()-Vector2(-5,-5),Color.white,2)
#	draw_line(get_local_mouse_position(),get_local_mouse_position()-Vector2(5,-5),Color.white,2)

func _process(delta):
	update()

func set_start_line(gn):
	line = true
	the_gn = gn
