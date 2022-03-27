tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("RandomAudioNodePlayer", "Node", preload("res://addons/RandomAudioNodePlayer/RandomAudioNodePlayer.gd"), preload("res://addons/RandomAudioNodePlayer/icon.png"))


func _exit_tree() -> void:
	remove_custom_type("RandomAudioNodePlayer")
