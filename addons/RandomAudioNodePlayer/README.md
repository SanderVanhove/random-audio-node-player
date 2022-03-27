# Random Audio Node Player

This Godot Engine plugin plays a random audio stream child node.

Ideal if you want control over all the settings per audio stream, like volume, audio bus, pitch, etc. Check the [alternatives](#alternative) for other options.

## Usage

1. Add the `RandomAudioNodePlayer` to your scene.
2. Add `AudioStreamPlayer`, `AudioStreamPlayer2D` or `AudioStreamPlayer3D` nodes as children.
3. Call `play()` on the `RandomAudioNodePlayer`.

## Features

* Play random AudioStreamPlayer(2D/3D) nodes.
* Doesn't play the same node twice.
* Interface is similar to an AudioStreamPlayer.

## Class signature

### Signals

* **finished()**
Emitted when one stream is `finished`.

* **finished_all()**
Emitted when all streams are `finished` and nothing is playing.

### Property Descriptions

* **playing**: bool *(set_playing, get_playing)*
If `true`, a child audio stream node is playing

* **autoplay**: bool *(set_autoplay, get_autoplay)*
If `true`, audio plays when added to scene tree.

* **paused**: bool *(set_paused, get_paused)*
If `true`, the playback of all child audio streams are paused.

### Method Descriptions

* **play**: void
Plays a random audio stream node that is a child of this node.

* **stop**: void
Stop all the playing audio stream nodes.

* **get_playing_nodes**: Array[Node]
Returns all the playing audio stream nodes.

## Alternative

* [Random Audio Stream Player](https://godotengine.org/asset-library/asset/651): If you just want to play random audio streams.
* [RandomSound](https://godotengine.org/asset-library/asset/359): Similar to this one, but with channels.
