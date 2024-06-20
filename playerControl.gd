@tool
extends Node

var vc: VirtualGamepad
@export var active := true
@export var player := "p1"
@export var button_map := {"jump":"j", "attack": ["a","b"], "run":"shift"}
var was_explore = false
func _process(delta):
	if Engine.is_editor_hint(): return
	if has_node("/root/_IMP"):
		if _IMP.mode != _IMP.EXPLORE: 
			if was_explore:
				was_explore = false
				empty_controls()
			return
	if not active: return
	if not vc:
		for node in owner.get_children():
			if node is VirtualGamepad:
				vc = node
				break
	if not vc: return
	for button in button_map:
		if not button in vc.buttons: continue
		if button_map[button] is String:
			vc.buttons[button].update_button(Input.is_action_pressed("%s_%s" % [player, button_map[button]]))
		elif button_map[button] is Array:
			var b := false
			for sub_button in button_map[button]:
				if sub_button.is_empty(): continue
				b = b or Input.is_action_pressed("%s_%s" % [player, sub_button])
			vc.buttons[button].update_button(b)
	vc.stick = Input.get_vector(
				"%s_left" % player,
				"%s_right" % player,
				"%s_up" % player,
				"%s_down" % player)
	was_explore = true
	
func empty_controls():
	vc.stick = Vector2.ZERO
	for button in button_map:
		if not button in vc.buttons: continue
		vc.buttons[button].update_button(false)
