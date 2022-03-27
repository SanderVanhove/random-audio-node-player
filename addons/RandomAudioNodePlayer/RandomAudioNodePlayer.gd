tool
extends Node
class_name RandomAudioNodePlayer


##
## Plays a random AudioStreamPlayer(2D/3D).
##
## @desc:
##		This node will play a random child node
##		that has a [code]play()[/code] method. 
##
##		This works for AudioStreamPlayer, 
##		AudioStreamPlayer2D and AudioStreamPlayer3D.
##		But it works for anything with the
##		[code]play()[/code] method.
##
##		It will not play the same node twice in
##		a row.
##


## Emitted when one audio stream stops playing.
signal finished
## Emitted when all audio streams stop playing.
signal finished_all


## If `true`, a child audio stream node is playing
export(bool) var playing: bool = false setget set_playing, get_playing
## If `true`, audio plays when added to scene tree.
export(bool) var autoplay: bool = false setget set_autoplay, get_autoplay
## If `true`, the playback of all child audio streams are paused.
export(bool) var paused: bool = false setget set_paused, get_paused


var _last_played: Node
var _audio_nodes: Array = []


func _ready() -> void:
	randomize()

	_init_audio_nodes()

	if autoplay: set_playing(true)


func add_child(node: Node, legible_unique_name: bool = false) -> void:
	.add_child(node, legible_unique_name)
	_init_audio_nodes()


func remove_child(node: Node) -> void:
	.remove_child(node)
	_init_audio_nodes()


## Plays a random audio stream node that is a child of this node.
func play() -> void:
	if len(_audio_nodes) == 0: return

	var new_playing_node := _get_random_audio_node()

	while new_playing_node == _last_played and len(_audio_nodes) != 1:
		new_playing_node = _get_random_audio_node()
	
	_last_played = new_playing_node

	new_playing_node.play()


func _done_playing() -> void:
	emit_signal("finished")

	if not get_playing():
		emit_signal("finished_all")


## Stop all audio stream nodes.
func stop() -> void:
	set_playing(false)


## Returns all the playing audio stream nodes.
func get_playing_nodes() -> Array:
	var playing_nodes: Array = []

	for node in _audio_nodes:
		if node.playing: playing_nodes.append(node)
	
	return playing_nodes


func set_playing(new_playing: bool) -> void:
	if len(_audio_nodes) == 0: return

	if new_playing:
		play()
	else:
		for node in _audio_nodes:
			node.stop()


func get_playing() -> bool:
	return _is_a_node_playing()


func set_paused(new_paused: bool) -> void:
	paused = new_paused

	for node in _audio_nodes:
		node.stream_paused = paused
	

func get_paused() -> bool:
	return paused


func set_autoplay(new_autoplay: bool) -> void:
	autoplay = new_autoplay


func get_autoplay() -> bool:
	return autoplay


func _init_audio_nodes() -> void:
	_audio_nodes = []

	for node in get_children():
		if not node.has_method("play"):
			continue

		_audio_nodes.append(node)
		node.connect("finished", self, "_done_playing")


func _get_random_audio_node() -> Node:
	var node_index: int = int(floor(rand_range(0, len(_audio_nodes))))
	return _audio_nodes[node_index]


func _is_a_node_playing() -> bool:
	for node in _audio_nodes:
		if node.playing: return true
	
	return false
