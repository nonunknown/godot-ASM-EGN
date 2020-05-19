extends Node

var last_number = -1

func get_number() -> int:
	last_number += 1
	return last_number
