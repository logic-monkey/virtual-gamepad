@tool
extends Node

var vc: VirtualGamepad
@export var active := true
@export var player := "p1"
func _process(delta):
	if Engine.is_editor_hint(): return
	if has_node("/root/_IMP"):
		if _IMP.mode != _IMP.EXPLORE: return
	if not active: return
	if not vc:
		for node in owner.get_children():
			if node is VirtualGamepad:
				vc = node
				break
	if not vc: return
	for button in vc.buttons:
		vc.buttons[button].update_button(Input.is_action_pressed("%s_%s" % [player, button]))
	vc.stick = Input.get_vector(
				"%s_left" % player,
				"%s_right" % player,
				"%s_up" % player,
				"%s_down" % player)
