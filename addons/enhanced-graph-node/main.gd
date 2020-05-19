tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("AutoIncrement", "res://addons/enhanced-graph-node/AutoIncrement.gd")
	pass


func _exit_tree():
	remove_autoload_singleton("AutoIncrement")
	pass
