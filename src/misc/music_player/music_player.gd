extends AudioStreamPlayer2D
class_name MusicPlayer2D

@export var _music_tracks: Array[AudioStream]
@export var _randomize_track_list_on_start: bool = true
var _active_track_index: int = -1 

func _ready() -> void:
	stop()
	finished.connect(_on_finished)
	if _randomize_track_list_on_start:
		randomize_track_order()
	if autoplay:
		play_next_track()

func play_next_track() -> void:
	stop()
	if !_music_tracks.is_empty():
		_active_track_index = (_active_track_index + 1) % _music_tracks.size()
		stream = _music_tracks[_active_track_index]
		play()

func randomize_track_order() -> void:
	if !_music_tracks.is_empty():
		_music_tracks.shuffle()

func _on_finished() -> void:
	play_next_track()
