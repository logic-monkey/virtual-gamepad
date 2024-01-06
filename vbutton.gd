@tool
extends Node
class_name VirtualButton

@export var decay_time := 0.25
var decay_time_left : float = 0

var is_down := false
var live := false

signal just_pressed

func update_button(pressed: bool):
	if not is_down and pressed:
		live = true
		decay_time_left = decay_time
		just_pressed.emit()
	is_down = pressed
		
func _process(delta):
#	await get_tree().process_frame
	if not live or decay_time_left <= 0: return
	decay_time_left -= delta
	if decay_time_left <= 0:
		live = false
