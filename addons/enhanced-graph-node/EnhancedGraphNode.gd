extends Control
class_name EnhancedGraphNode, "res://addons/enhanced-graph-node/icons/enhanced_node.png"

signal delete_request
signal position_changed

export var title:String setget set_title,get_title

var graph_edit
var ID:int = -1
var PARENT_ID:int = -1


func _ready():
	if get_parent().get_parent() is EnhancedGraphEdit: pass; else: return
	graph_edit = get_parent().get_parent()
	ID = AutoIncrement.get_number()
	if graph_edit == null:
		push_warning(name + ": Does not have a parent")
	else: PARENT_ID = graph_edit.ID
#	print(str(ID))


func set_title(value):
	title = value


func get_title() -> String: return title


var held:bool = false
var last_clicked:Vector2 = Vector2.ZERO
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
#			print("clicked")
			held = true
			last_clicked = get_local_mouse_position()
		elif event.button_index == BUTTON_LEFT and !event.pressed:
#			print("released")
			held = false
	elif event is InputEventMouseMotion and held:
		rect_position = get_global_mouse_position() - last_clicked
		emit_signal("position_changed")
		pass
	pass # Replace with function body.

func _on_mouse_entered():
	if graph_edit == null: return
	graph_edit.node_focused = self
	pass # Replace with function body.


func _on_mouse_exited():
	if graph_edit == null: return
	graph_edit.node_focused = null
	pass # Replace with function body.


func _on_Delete_pressed():
	emit_signal("delete_request")
	pass # Replace with function body.

onready var _initial_size_y = rect_size.y
func _on_Content_visibility_changed():
	if $Content.visible:
		rect_size.y = _initial_size_y + $Content.rect_size.y
		pass
	else:
		rect_size.y = _initial_size_y
#		print(str(_initial_size_y))
		pass
	emit_signal("position_changed")
