@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("VirtualGamePad", "Node", preload("virtualgamepad.gd"), preload("vpad icon.svg"))
	add_custom_type("VirtualButton", "Node", preload("vbutton.gd"), preload("vpad button icon.svg"))
	add_custom_type("PlayerControl", "Node", preload("playerControl.gd"), preload("player control icon.svg"))
	pass


func _exit_tree():
	remove_custom_type("VirtualGamePad")
	remove_custom_type("VirtualButton")
	remove_custom_type("PlayerControl")
	pass
