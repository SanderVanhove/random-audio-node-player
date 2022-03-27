extends Node2D


func _ready() -> void:
	pass


func _on_RandomAudioNodePlayer_finished() -> void:
	print("Finished playing ONE")


func _on_RandomAudioNodePlayer_finished_all() -> void:
	print("Finished playing ALL")
